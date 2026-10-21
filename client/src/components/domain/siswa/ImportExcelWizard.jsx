import { useState, useEffect, useRef } from 'react';
import { useQueryClient } from '@tanstack/react-query';
import {
  UploadCloud,
  FileSpreadsheet,
  FileText,
  X,
  Check,
  CheckCircle2,
  AlertTriangle,
  AlertCircle,
  ShieldAlert,
  Download,
  ChevronLeft,
  ChevronRight,
  LoaderCircle,
  Info,
} from 'lucide-react';
import api from '../../../lib/api';
import Button from '../../ui/Button';
import Badge from '../../ui/Badge';
import { cn } from '../../../lib/utils';
import { MAPPEL, SOURCE_TYPES, getSourceBadgeProps } from '../../../lib/constants';

// Dictionary mapping for human readable labels (O3)
const FIELD_HUMAN_LABELS = {
  nis: 'NIS',
  nama: 'Nama Siswa',
  kelas: 'Kelas',
  ekstrakurikuler: 'Ekstrakurikuler',
  prestasi: 'Prestasi',
  kemampuan: 'Kemampuan',
  organisasi: 'Organisasi',
  kursus: 'Kursus',
  jurusan_1: 'Pilihan Jurusan 1',
  jurusan_2: 'Pilihan Jurusan 2',
};

// Map mapel keys from constants
MAPPEL.forEach((item) => {
  FIELD_HUMAN_LABELS[item.key] = item.label;
});

export function getHumanLabel(field) {
  if (!field) return '';
  const lower = String(field).toLowerCase();
  return FIELD_HUMAN_LABELS[lower] || FIELD_HUMAN_LABELS[field] || field;
}

const SHEET_NAMES = ['RAPOR', 'PTS', 'PAS', 'NON-AKADEMIK'];

function formatFileSize(bytes) {
  if (!bytes) return '0 B';
  if (bytes < 1024) return `${bytes} B`;
  if (bytes < 1024 * 1024) return `${(bytes / 1024).toFixed(1)} KB`;
  return `${(bytes / (1024 * 1024)).toFixed(1)} MB`;
}

export default function ImportExcelWizard({ onSwitchToDaftarTab, showToast }) {
  const queryClient = useQueryClient();

  // Wizard state: 1: Upload, 2: Validasi, '2-FAIL': Validasi Fail, 3: Preview, 4: Konfirmasi, 5: Hasil
  const [wizardState, setWizardState] = useState(1);

  // File state
  const [selectedFile, setSelectedFile] = useState(null);
  const [preCheckError, setPreCheckError] = useState('');
  const fileInputRef = useRef(null);

  // Validation state (State 2)
  const [validationProgress, setValidationProgress] = useState(0);
  const [validationStep, setValidationStep] = useState(0);
  const abortControllerRef = useRef(null);

  // Validation Fail data (State 2-FAIL)
  const [fatalErrors, setFatalErrors] = useState([]);
  const [fatalMessage, setFatalMessage] = useState('');

  // Preview data (State 3)
  const [previewData, setPreviewData] = useState(null);
  const [activeSheetTab, setActiveSheetTab] = useState('RAPOR');
  const [previewPage, setPreviewPage] = useState(1);

  // Confirmation state (State 4)
  const [consentChecked, setConsentChecked] = useState(false);
  const [isConfirming, setIsConfirming] = useState(false);

  // Result data (State 5)
  const [resultData, setResultData] = useState(null);

  // Download template helper
  const handleDownloadTemplate = async () => {
    try {
      const response = await api.get('/siswa/template-excel', {
        responseType: 'blob',
      });
      const url = window.URL.createObjectURL(new Blob([response.data]));
      const link = document.createElement('a');
      link.href = url;
      link.setAttribute('download', 'template-import-siswa.xlsx');
      document.body.appendChild(link);
      link.click();
      link.remove();
      window.URL.revokeObjectURL(url);
    } catch (err) {
      if (showToast) showToast('Gagal mengunduh template Excel.', 'danger');
    }
  };

  // Reset wizard
  const handleResetWizard = () => {
    if (abortControllerRef.current) {
      abortControllerRef.current.abort();
      abortControllerRef.current = null;
    }
    setWizardState(1);
    setSelectedFile(null);
    setPreCheckError('');
    setValidationProgress(0);
    setValidationStep(0);
    setFatalErrors([]);
    setFatalMessage('');
    setPreviewData(null);
    setActiveSheetTab('RAPOR');
    setPreviewPage(1);
    setConsentChecked(false);
    setIsConfirming(false);
    setResultData(null);
    if (fileInputRef.current) fileInputRef.current.value = '';
  };

  // Pre-check file selection
  const handleFileSelect = (file) => {
    setPreCheckError('');
    if (!file) return;

    const fileName = file.name.toLowerCase();
    const isXlsx = fileName.endsWith('.xlsx');
    const isSizeOk = file.size <= 5 * 1024 * 1024; // 5 MB

    if (!isXlsx || !isSizeOk) {
      setPreCheckError('File harus berformat .xlsx dan maksimal 5 MB.');
      setSelectedFile(null);
      if (fileInputRef.current) fileInputRef.current.value = '';
      return;
    }

    setSelectedFile(file);
  };

  // Dropzone drag & drop handlers
  const handleDragOver = (e) => {
    e.preventDefault();
    e.stopPropagation();
  };

  const handleDrop = (e) => {
    e.preventDefault();
    e.stopPropagation();
    if (e.dataTransfer.files && e.dataTransfer.files[0]) {
      handleFileSelect(e.dataTransfer.files[0]);
    }
  };

  // Trigger Validation (State 1 -> State 2)
  const handleStartValidation = () => {
    if (!selectedFile) return;

    setWizardState(2);
    setValidationProgress(0);
    setValidationStep(0);

    const controller = new AbortController();
    abortControllerRef.current = controller;

    // Simulated progressive checklist (~400ms per item up to step 4 / 90%)
    let currentStep = 0;
    const interval = setInterval(() => {
      currentStep += 1;
      if (currentStep <= 4) {
        setValidationStep(currentStep);
        setValidationProgress(currentStep * 20 + 10);
      } else {
        clearInterval(interval);
      }
    }, 400);

    // Make API request
    const formData = new FormData();
    formData.append('file', selectedFile);

    api
      .post('/siswa/import-excel/preview', formData, {
        headers: { 'Content-Type': 'multipart/form-data' },
        signal: controller.signal,
      })
      .then((res) => {
        clearInterval(interval);
        setValidationStep(5);
        setValidationProgress(100);

        setTimeout(() => {
          setPreviewData(res.data);
          if (res.data.sheets && res.data.sheets.length > 0) {
            setActiveSheetTab(res.data.sheets[0].name || 'RAPOR');
          }
          setPreviewPage(1);
          setWizardState(3); // AUTO-ADVANCE to State 3
        }, 300);
      })
      .catch((err) => {
        clearInterval(interval);
        if (err.name === 'CanceledError' || err.code === 'ERR_CANCELED') {
          // Request aborted by user
          return;
        }

        const data = err.response?.data;
        setFatalMessage(
          data?.message || 'Gagal memproses file. Pastikan struktur file sesuai template.'
        );

        let errList = [];
        if (data?.details && Array.isArray(data.details)) {
          errList = data.details;
        } else if (data?.errors && Array.isArray(data.errors)) {
          errList = data.errors;
        }
        setFatalErrors(errList);

        setWizardState('2-FAIL');
      });
  };

  // Cancel Validation (Abort request and return to State 1)
  const handleCancelValidation = () => {
    if (abortControllerRef.current) {
      abortControllerRef.current.abort();
      abortControllerRef.current = null;
    }
    setWizardState(1);
  };

  // Confirm Import (State 4 -> State 5)
  const handleConfirmImport = async () => {
    if (!previewData?.previewId || !consentChecked || isConfirming) return;

    setIsConfirming(true);
    try {
      const res = await api.post('/siswa/import-excel/confirm', {
        previewId: previewData.previewId,
      });

      // 201 Success
      setResultData(res.data);
      queryClient.invalidateQueries(['siswa']);
      setWizardState(5);
    } catch (err) {
      const status = err.response?.status;
      if (status === 404) {
        if (showToast) {
          showToast(
            'Data preview tidak ditemukan atau sudah kedaluwarsa. Silakan upload ulang.',
            'danger'
          );
        }
        handleResetWizard();
      } else {
        const msg = err.response?.data?.message || 'Gagal mengonfirmasi import data.';
        if (showToast) showToast(msg, 'danger');
      }
    } finally {
      setIsConfirming(false);
    }
  };

  // Determine Stepper step status
  // Steps: 1: Upload, 2: Validasi, 3: Preview, 4: Konfirmasi
  const getStepStatus = (stepNumber) => {
    if (wizardState === 5) return 'complete'; // State 5: all steps completed

    if (wizardState === '2-FAIL') {
      if (stepNumber === 1) return 'complete';
      if (stepNumber === 2) return 'fail';
      return 'unreached';
    }

    if (wizardState === stepNumber) return 'active';
    if (wizardState > stepNumber) return 'complete';
    return 'unreached';
  };

  const steps = [
    { number: 1, label: 'Upload' },
    { number: 2, label: 'Validasi' },
    { number: 3, label: 'Preview' },
    { number: 4, label: 'Konfirmasi' },
  ];

  // Selected sheet data for State 3 Preview
  const currentSheet = previewData?.sheets?.find(
    (s) => s.name.toUpperCase() === activeSheetTab.toUpperCase()
  ) || { name: activeSheetTab, status: 'Valid', rows: [], errors: [] };

  const activeRows = currentSheet.rows || [];
  const activeErrors = currentSheet.errors || [];
  const totalSheetRows = activeRows.length;
  const pageSize = 10;
  const totalPages = Math.ceil(totalSheetRows / pageSize) || 1;
  const paginatedRows = activeRows.slice((previewPage - 1) * pageSize, previewPage * pageSize);

  const importableRows = previewData?.summary?.importableRows ?? 0;
  const validRows = previewData?.summary?.validRows ?? 0;
  const missingRows = previewData?.summary?.missingRows ?? 0;
  const errorRows = previewData?.summary?.errorRows ?? 0;
  const totalRows = previewData?.summary?.totalRows ?? 0;

  return (
    <div className="flex flex-col min-h-125">
      {/* STEPPER HEADER */}
      <div className="p-6 border-b border-line bg-card">
        <div className="flex items-center justify-between max-w-3xl mx-auto">
          {steps.map((s, idx) => {
            const status = getStepStatus(s.number);
            return (
              <div key={s.number} className="flex items-center gap-3">
                <div className="flex items-center gap-2">
                  <div
                    className={cn(
                      'flex items-center justify-center h-8 w-8 rounded-full text-xs font-semibold transition-colors',
                      status === 'complete' && 'bg-success text-on-brand',
                      status === 'active' && 'bg-brand text-on-brand ring-4 ring-brand-tint',
                      status === 'fail' && 'bg-danger text-on-brand',
                      status === 'unreached' && 'bg-page text-muted border border-line'
                    )}
                  >
                    {status === 'complete' ? (
                      <Check className="h-4 w-4" />
                    ) : status === 'fail' ? (
                      <X className="h-4 w-4" />
                    ) : status === 'active' && wizardState === 2 ? (
                      <LoaderCircle className="h-4 w-4 animate-spin" />
                    ) : (
                      <span className="font-mono">{s.number}</span>
                    )}
                  </div>
                  <span
                    className={cn(
                      'text-sm font-semibold',
                      status === 'active' || status === 'complete'
                        ? 'text-ink'
                        : status === 'fail'
                        ? 'text-danger'
                        : 'text-muted'
                    )}
                  >
                    {s.label}
                  </span>
                </div>

                {idx < steps.length - 1 && (
                  <div className="w-12 sm:w-16 h-0.5 bg-line mx-2" />
                )}
              </div>
            );
          })}
        </div>
      </div>

      {/* BODY CONTENT AREA */}
      <div className="flex-1 p-6 space-y-6">
        {/* ==================== STATE 1: UPLOAD ==================== */}
        {wizardState === 1 && (
          <div className="space-y-6 max-w-3xl mx-auto">
            {!selectedFile ? (
              /* Dropzone Kosong */
              <div
                onClick={() => fileInputRef.current?.click()}
                onDragOver={handleDragOver}
                onDrop={handleDrop}
                className="flex flex-col items-center justify-center p-8 border-2 border-dashed border-line rounded-xl bg-page/50 hover:bg-page hover:border-brand/50 transition-colors cursor-pointer text-center"
              >
                <input
                  ref={fileInputRef}
                  type="file"
                  accept=".xlsx"
                  className="hidden"
                  onChange={(e) => handleFileSelect(e.target.files?.[0])}
                />
                <div className="h-12 w-12 rounded-full bg-brand-tint flex items-center justify-center text-brand mb-3">
                  <UploadCloud className="h-6 w-6" />
                </div>
                <p className="text-base font-semibold text-ink">
                  Tarik & letakkan file Excel di sini
                </p>
                <p className="text-xs text-muted mt-1">atau</p>
                <Button variant="outline" size="md" className="mt-3">
                  Pilih File
                </Button>
              </div>
            ) : (
              /* X2: File Card */
              <div className="flex items-center justify-between p-4 border border-line rounded-xl bg-card">
                <div className="flex items-center gap-3">
                  <div className="h-10 w-10 rounded-lg bg-brand-tint flex items-center justify-center text-brand">
                    <FileSpreadsheet className="h-5 w-5" />
                  </div>
                  <div>
                    <p className="text-sm font-semibold text-ink">{selectedFile.name}</p>
                    <span className="text-xs font-mono text-muted">
                      {formatFileSize(selectedFile.size)}
                    </span>
                  </div>
                </div>
                <button
                  type="button"
                  onClick={() => {
                    setSelectedFile(null);
                    if (fileInputRef.current) fileInputRef.current.value = '';
                  }}
                  className="p-1 rounded-lg hover:bg-page text-muted hover:text-ink transition-colors"
                  aria-label="Hapus file"
                >
                  <X className="h-5 w-5" />
                </button>
              </div>
            )}

            {/* Inline Pre-Check Error Message */}
            {preCheckError && (
              <div className="flex items-center gap-2 p-3 rounded-lg bg-danger-tint text-danger-text text-sm font-medium">
                <AlertCircle className="h-4 w-4 shrink-0" />
                <span>{preCheckError}</span>
              </div>
            )}

            {/* Hint & Template Link */}
            <div className="flex flex-col sm:flex-row items-start sm:items-center justify-between gap-3 text-xs text-muted border-t border-line pt-4">
              <div>
                Format <span className="font-mono font-semibold text-ink">.xlsx</span> • 4 sheet:{' '}
                <span className="font-mono font-semibold text-ink">
                  RAPOR, PTS, PAS, NON-AKADEMIK
                </span>{' '}
                • Maks 5 MB
              </div>
              <button
                type="button"
                onClick={handleDownloadTemplate}
                className="flex items-center gap-1.5 font-semibold text-brand hover:underline"
              >
                <Download className="h-3.5 w-3.5" />
                <span>Unduh Template Excel (.xlsx)</span>
              </button>
            </div>

            {/* 4 Info Chips Statis */}
            <div className="grid grid-cols-2 sm:grid-cols-4 gap-3">
              {SHEET_NAMES.map((s) => (
                <div
                  key={s}
                  className="flex items-center gap-2 p-2.5 rounded-lg border border-line bg-page/50 text-xs text-ink"
                >
                  <span className="h-2 w-2 rounded-full bg-faint" />
                  <span className="font-mono font-semibold">Sheet {s}</span>
                </div>
              ))}
            </div>

            {/* Footer buttons (X3) */}
            <div className="flex items-center justify-between border-t border-line pt-4">
              <Button variant="outline" onClick={handleResetWizard}>
                Batal
              </Button>
              <Button
                variant="solid"
                disabled={!selectedFile}
                onClick={handleStartValidation}
              >
                Lanjut
              </Button>
            </div>
          </div>
        )}

        {/* ==================== STATE 2: VALIDASI BERJALAN ==================== */}
        {wizardState === 2 && (
          <div className="space-y-6 max-w-2xl mx-auto py-4">
            {/* File Card */}
            <div className="flex items-center gap-3 p-4 border border-line rounded-xl bg-card">
              <div className="h-10 w-10 rounded-lg bg-brand-tint flex items-center justify-center text-brand">
                <FileSpreadsheet className="h-5 w-5" />
              </div>
              <div>
                <p className="text-sm font-semibold text-ink">{selectedFile?.name}</p>
                <span className="text-xs font-mono text-muted">
                  {formatFileSize(selectedFile?.size)}
                </span>
              </div>
            </div>

            {/* Progress status & bar */}
            <div className="space-y-2">
              <div className="flex items-center justify-between text-sm">
                <span className="font-medium text-ink">Memvalidasi template & isi data...</span>
                <span className="font-mono font-semibold text-brand">
                  {validationProgress}%
                </span>
              </div>
              <div className="h-2 w-full bg-page rounded-full overflow-hidden border border-line">
                <div
                  className="h-full bg-brand transition-all duration-300"
                  style={{ width: `${validationProgress}%` }}
                />
              </div>
            </div>

            {/* Progressive Checklist 5 Items */}
            <div className="space-y-3 p-4 rounded-xl border border-line bg-page/40">
              {[
                'Struktur template & nama sheet',
                'Nama kolom setiap sheet',
                'Identitas siswa (NIS) & duplikasi',
                'Tipe nilai numerik (0-100)',
                'Field wajib identitas',
              ].map((item, idx) => {
                const stepNum = idx + 1;
                const isPassed = validationStep >= stepNum;
                const isCurrent = validationStep === stepNum - 1;

                return (
                  <div key={item} className="flex items-center gap-3 text-sm">
                    <div
                      className={cn(
                        'flex h-5 w-5 items-center justify-center rounded-full text-xs font-semibold',
                        isPassed
                          ? 'bg-success text-on-brand'
                          : isCurrent
                          ? 'bg-brand text-on-brand'
                          : 'border border-line bg-card text-muted'
                      )}
                    >
                      {isPassed ? (
                        <Check className="h-3.5 w-3.5" />
                      ) : isCurrent ? (
                        <LoaderCircle className="h-3.5 w-3.5 animate-spin" />
                      ) : (
                        <span className="font-mono text-[10px]">{stepNum}</span>
                      )}
                    </div>
                    <span
                      className={cn(
                        isPassed
                          ? 'font-medium text-ink'
                          : isCurrent
                          ? 'font-semibold text-brand'
                          : 'text-muted'
                      )}
                    >
                      {item}
                    </span>
                  </div>
                );
              })}
            </div>

            {/* Footer buttons */}
            <div className="flex items-center justify-between border-t border-line pt-4">
              <Button variant="outline" onClick={handleCancelValidation}>
                Batal
              </Button>
              <Button variant="solid" disabled>
                Lanjut
              </Button>
            </div>
          </div>
        )}

        {/* ==================== STATE 2-FAIL: VALIDASI FAILED ==================== */}
        {wizardState === '2-FAIL' && (
          <div className="space-y-6 max-w-2xl mx-auto py-2">
            {/* Panel Merah */}
            <div className="p-5 border border-danger/30 bg-danger-tint/50 rounded-xl space-y-4">
              <div className="flex items-center gap-3 text-danger-text">
                <ShieldAlert className="h-6 w-6 shrink-0" />
                <h4 className="text-base font-semibold">File tidak sesuai template</h4>
              </div>

              {/* Bullet errors */}
              <div className="space-y-2 text-sm text-ink pl-2">
                {fatalErrors.length > 0 ? (
                  fatalErrors.map((err, idx) => (
                    <div key={idx} className="flex items-start gap-2">
                      <span className="text-danger-text font-bold">•</span>
                      <div className="flex flex-wrap items-center gap-1.5">
                        {err.sheet && (
                          <Badge tone="danger" className="font-mono text-xs">
                            Sheet {String(err.sheet).toUpperCase()}
                          </Badge>
                        )}
                        {err.field && (
                          <Badge tone="neutral" className="font-mono text-xs">
                            {getHumanLabel(err.field)}
                          </Badge>
                        )}
                        <span>{err.message || 'Format data tidak valid.'}</span>
                      </div>
                    </div>
                  ))
                ) : (
                  <div className="flex items-start gap-2">
                    <span className="text-danger-text font-bold">•</span>
                    <span>{fatalMessage}</span>
                  </div>
                )}
              </div>

              <p className="text-xs text-muted border-t border-danger/20 pt-3">
                Perbaiki struktur file menggunakan template resmi, lalu unggah kembali.
              </p>
            </div>

            {/* Actions */}
            <div className="flex flex-col sm:flex-row items-center gap-3">
              <Button
                variant="solid"
                className="w-full sm:w-auto"
                onClick={handleResetWizard}
              >
                Pilih File Lain
              </Button>
              <Button
                variant="outline"
                className="w-full sm:w-auto"
                onClick={handleDownloadTemplate}
              >
                <Download className="h-4 w-4" />
                <span>Unduh Template Excel (.xlsx)</span>
              </Button>
            </div>

            {/* Footer */}
            <div className="flex items-center justify-start border-t border-line pt-4">
              <Button variant="outline" onClick={handleResetWizard}>
                Kembali ke Upload
              </Button>
            </div>
          </div>
        )}

        {/* ==================== STATE 3: PREVIEW ==================== */}
        {wizardState === 3 && (
          <div className="space-y-6">
            {/* Header row: File chip + Summary chips */}
            <div className="flex flex-wrap items-center justify-between gap-3 p-4 border border-line rounded-xl bg-card">
              {/* File chip */}
              <div className="flex items-center gap-2 px-3 py-1.5 rounded-lg bg-page border border-line">
                <FileSpreadsheet className="h-4 w-4 text-brand shrink-0" />
                <span className="text-xs font-semibold text-ink">
                  {previewData?.fileName || selectedFile?.name}
                </span>
                <span className="text-xs font-mono text-muted">
                  ({formatFileSize(previewData?.fileSize || selectedFile?.size)})
                </span>
              </div>

              {/* Summary chips */}
              <div className="flex flex-wrap items-center gap-2">
                <Badge tone="neutral" className="font-mono">
                  {totalRows} baris terbaca
                </Badge>
                <Badge tone="success" className="font-mono">
                  {validRows} valid
                </Badge>
                <Badge tone="warning" className="font-mono">
                  {missingRows} missing
                </Badge>
                <Badge tone="danger" className="font-mono">
                  {errorRows} error
                </Badge>
                <Badge tone="info" className="font-mono">
                  Header: baris 1
                </Badge>
                <Badge tone="info" className="font-mono">
                  Kolom: sesuai template
                </Badge>
              </div>
            </div>

            {/* Sheet Tabs */}
            <div className="flex border-b border-line gap-4">
              {previewData?.sheets?.map((sheet) => {
                const sheetNameUpper = sheet.name.toUpperCase();
                const isActive = activeSheetTab.toUpperCase() === sheetNameUpper;
                const sheetStatus = sheet.status || 'Valid';

                return (
                  <button
                    key={sheet.name}
                    type="button"
                    onClick={() => {
                      setActiveSheetTab(sheetNameUpper);
                      setPreviewPage(1);
                    }}
                    className={cn(
                      'flex items-center gap-2 pb-3 text-xs font-semibold border-b-2 transition-colors',
                      isActive
                        ? 'border-brand text-brand'
                        : 'border-transparent text-muted hover:text-ink'
                    )}
                  >
                    <span className="font-mono">Sheet {sheetNameUpper}</span>
                    <Badge
                      tone={
                        sheetStatus === 'Valid'
                          ? 'success'
                          : sheetStatus === 'Missing'
                          ? 'warning'
                          : 'danger'
                      }
                      className="text-[10px] px-2 py-0"
                    >
                      {sheetStatus}
                    </Badge>
                  </button>
                );
              })}
            </div>

            {/* Box Error Sheet Aktif (if errors exist or missing exist) */}
            {(activeErrors.length > 0 || missingRows > 0) && (
              <div className="space-y-2">
                {activeErrors.length > 0 && (
                  <div className="p-3 border border-danger/30 bg-danger-tint/40 rounded-lg text-xs space-y-1.5 text-danger-text">
                    <p className="font-semibold flex items-center gap-1.5">
                      <AlertCircle className="h-3.5 w-3.5 shrink-0" />
                      <span>
                        Ditemukan {activeErrors.length} error pada sheet {activeSheetTab}:
                      </span>
                    </p>
                    <div className="pl-5 space-y-1">
                      {activeErrors.slice(0, 3).map((err, idx) => (
                        <p key={idx}>
                          Baris <span className="font-mono font-semibold">{err.row}</span>
                          {err.nis ? (
                            <>
                              {' '}
                              — NIS <span className="font-mono font-semibold">{err.nis}</span>
                            </>
                          ) : null}
                          : {err.message}
                        </p>
                      ))}
                      {activeErrors.length > 3 && (
                        <p className="italic font-medium text-muted">
                          +{activeErrors.length - 3} error lainnya
                        </p>
                      )}
                    </div>
                  </div>
                )}

                {missingRows > 0 && (
                  <div className="p-3 border border-warning/30 bg-warning-tint/40 rounded-lg text-xs text-ink flex items-center gap-2">
                    <Info className="h-4 w-4 text-warning shrink-0" />
                    <span>
                      <strong className="font-mono">{missingRows} baris missing</strong> akan
                      diimputasi pada tahap Cleaning.
                    </span>
                  </div>
                )}
              </div>
            )}

            {/* Table Preview Rows */}
            <div className="border border-line rounded-xl overflow-hidden bg-card">
              <div className="overflow-x-auto">
                <table className="w-full text-left text-xs">
                  <thead className="border-b border-line bg-page text-muted font-semibold">
                    <tr>
                      <th className="px-4 py-3">BARIS</th>
                      <th className="px-4 py-3">NIS</th>
                      <th className="px-4 py-3">NAMA SISWA</th>
                      <th className="px-4 py-3">KELAS</th>
                      <th className="px-4 py-3">STATUS</th>
                      <th className="px-4 py-3">KETERANGAN</th>
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-line text-ink">
                    {paginatedRows.length > 0 ? (
                      paginatedRows.map((row, idx) => {
                        const rowStatus = row.status || 'Valid';
                        const isMissing = rowStatus === 'Missing';
                        const isError = rowStatus === 'Error';

                        return (
                          <tr
                            key={idx}
                            className={cn(
                              'transition-colors',
                              isMissing && 'bg-warning-tint/20',
                              isError && 'bg-danger-tint/20'
                            )}
                          >
                            <td className="px-4 py-2.5 font-mono text-muted">
                              {row.row ?? idx + 1}
                            </td>
                            <td className="px-4 py-2.5 font-mono font-semibold">
                              {row.nis || '-'}
                            </td>
                            <td className="px-4 py-2.5 font-medium">{row.nama || '-'}</td>
                            <td className="px-4 py-2.5 font-mono">{row.kelas || '-'}</td>
                            <td className="px-4 py-2.5">
                              <Badge
                                tone={
                                  isError ? 'danger' : isMissing ? 'warning' : 'success'
                                }
                              >
                                {rowStatus}
                              </Badge>
                            </td>
                            <td className="px-4 py-2.5 text-muted">
                              {row.keterangan || '-'}
                            </td>
                          </tr>
                        );
                      })
                    ) : (
                      <tr>
                        <td colSpan={6} className="px-4 py-8 text-center text-muted">
                          Tidak ada data baris pada sheet ini.
                        </td>
                      </tr>
                    )}
                  </tbody>
                </table>
              </div>

              {/* Client-side Pagination */}
              {totalSheetRows > 0 && (
                <div className="flex items-center justify-between px-4 py-3 border-t border-line bg-page/50 text-xs text-muted">
                  <div>
                    Menampilkan{' '}
                    <span className="font-mono font-semibold text-ink">
                      {(previewPage - 1) * pageSize + 1}
                    </span>
                    -
                    <span className="font-mono font-semibold text-ink">
                      {Math.min(previewPage * pageSize, totalSheetRows)}
                    </span>{' '}
                    dari{' '}
                    <span className="font-mono font-semibold text-ink">{totalSheetRows}</span>{' '}
                    baris
                  </div>
                  <div className="flex items-center gap-2">
                    <Button
                      variant="outline"
                      size="md"
                      className="h-8 px-2 text-xs"
                      disabled={previewPage === 1}
                      onClick={() => setPreviewPage((p) => Math.max(1, p - 1))}
                    >
                      <ChevronLeft className="h-3.5 w-3.5" />
                      <span>Sebelumnya</span>
                    </Button>
                    <span className="font-mono text-ink">
                      {previewPage} / {totalPages}
                    </span>
                    <Button
                      variant="outline"
                      size="md"
                      className="h-8 px-2 text-xs"
                      disabled={previewPage >= totalPages}
                      onClick={() => setPreviewPage((p) => Math.min(totalPages, p + 1))}
                    >
                      <span>Selanjutnya</span>
                      <ChevronRight className="h-3.5 w-3.5" />
                    </Button>
                  </div>
                </div>
              )}
            </div>

            {/* Footer */}
            <div className="flex items-center justify-between border-t border-line pt-4">
              <Button variant="outline" onClick={handleResetWizard}>
                Kembali
              </Button>
              <Button
                variant="solid"
                disabled={importableRows === 0}
                onClick={() => setWizardState(4)}
              >
                Lanjut ke Konfirmasi
              </Button>
            </div>
          </div>
        )}

        {/* ==================== STATE 4: KONFIRMASI ==================== */}
        {wizardState === 4 && (
          <div className="space-y-6 max-w-2xl mx-auto py-2">
            {/* Card Ringkasan */}
            <div className="p-5 border border-line rounded-xl bg-card space-y-4">
              <h4 className="text-base font-semibold text-ink">Ringkasan Import Data</h4>

              <div className="space-y-2.5 text-sm divide-y divide-line">
                <div className="flex justify-between pt-1">
                  <span className="text-muted">Nama File</span>
                  <span className="font-semibold text-ink">
                    {previewData?.fileName || selectedFile?.name}
                  </span>
                </div>
                <div className="flex justify-between pt-2">
                  <span className="text-muted">Total Baris Terbaca</span>
                  <span className="font-mono font-semibold text-ink">{totalRows}</span>
                </div>
                <div className="flex justify-between pt-2">
                  <span className="text-muted">Baris Akan Diimport</span>
                  <div className="text-right">
                    <span className="font-mono font-bold text-success">
                      {importableRows}
                    </span>{' '}
                    <span className="text-xs text-muted">
                      ({validRows} valid + {missingRows} missing ditandai)
                    </span>
                  </div>
                </div>
                <div className="flex justify-between pt-2">
                  <span className="text-muted">Baris Ditolak</span>
                  <div>
                    <span className="font-mono font-bold text-danger">{errorRows}</span>{' '}
                    <span className="text-xs text-muted">(error)</span>
                  </div>
                </div>
                <div className="flex justify-between pt-2">
                  <span className="text-muted">Source Data</span>
                  <div className="flex items-center gap-1.5">
                    <Badge tone={getSourceBadgeProps(SOURCE_TYPES.EXCEL_IMPORT).tone}>{getSourceBadgeProps(SOURCE_TYPES.EXCEL_IMPORT).label}</Badge>
                    <span className="text-xs font-mono text-muted">
                      (source_type = excel_import)
                    </span>
                  </div>
                </div>
              </div>
            </div>

            {/* Banner Amber Warning */}
            <div className="p-4 border border-warning/30 bg-warning-tint/30 rounded-xl flex items-start gap-3 text-xs text-ink">
              <AlertTriangle className="h-5 w-5 text-warning shrink-0 mt-0.5" />
              <div>
                <strong className="font-semibold">Perhatian:</strong> Baris error tidak akan
                diimport. Baris missing akan diimputasi pada tahap Cleaning. Perbaiki file
                lalu ulangi import untuk menambahkan baris error.
              </div>
            </div>

            {/* Checkbox Consent */}
            <label className="flex items-start gap-3 p-4 border border-line rounded-xl bg-page/50 cursor-pointer select-none">
              <input
                type="checkbox"
                checked={consentChecked}
                onChange={(e) => setConsentChecked(e.target.checked)}
                className="mt-0.5 h-4 w-4 rounded border-line text-brand focus:ring-brand"
              />
              <span className="text-xs font-medium text-ink leading-relaxed">
                Saya sudah memeriksa preview dan menyetujui import{' '}
                <strong className="font-mono">{importableRows}</strong> baris data siswa.
              </span>
            </label>

            {/* Footer */}
            <div className="flex items-center justify-between border-t border-line pt-4">
              <Button variant="outline" onClick={() => setWizardState(3)}>
                Kembali
              </Button>
              <Button
                variant="solid"
                disabled={!consentChecked || isConfirming}
                onClick={handleConfirmImport}
              >
                {isConfirming ? (
                  <div className="flex items-center gap-2">
                    <LoaderCircle className="h-4 w-4 animate-spin" />
                    <span>Mengimport Data...</span>
                  </div>
                ) : (
                  <span>Import {importableRows} Baris Data</span>
                )}
              </Button>
            </div>
          </div>
        )}

        {/* ==================== STATE 5: HASIL ==================== */}
        {wizardState === 5 && (
          <div className="space-y-6 max-w-2xl mx-auto py-2">
            {/* Header Success */}
            <div className="flex flex-col items-center justify-center text-center space-y-2">
              <div className="h-14 w-14 rounded-full bg-success-tint flex items-center justify-center text-success">
                <CheckCircle2 className="h-8 w-8" />
              </div>
              <h3 className="text-xl font-bold text-ink">Import Selesai</h3>
              <p className="text-xs text-muted max-w-md">
                <strong className="font-mono">{resultData?.importedCount ?? 0}</strong> baris
                berhasil disimpan,{' '}
                <strong className="font-mono">{resultData?.missingCount ?? 0}</strong> di
                antaranya ditandai missing,{' '}
                <strong className="font-mono">{resultData?.rejectedCount ?? 0}</strong> baris
                gagal diimport.
              </p>
            </div>

            {/* 2 Stat Cards */}
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
              <div className="p-4 border border-success/30 bg-success-tint/20 rounded-xl space-y-1">
                <p className="text-2xl font-bold font-mono text-success">
                  {resultData?.importedCount ?? 0}
                </p>
                <p className="text-xs font-semibold text-ink">Baris Sukses</p>
                <p className="text-[11px] text-muted">
                  termasuk {resultData?.missingCount ?? 0} baris missing
                </p>
              </div>

              <div className="p-4 border border-danger/30 bg-danger-tint/20 rounded-xl space-y-1">
                <p className="text-2xl font-bold font-mono text-danger">
                  {resultData?.rejectedCount ?? 0}
                </p>
                <p className="text-xs font-semibold text-ink">Baris Gagal</p>
              </div>
            </div>

            {/* Rejected rows table (if any) */}
            {resultData?.rejectedRows && resultData.rejectedRows.length > 0 && (
              <div className="space-y-2">
                <h5 className="text-xs font-semibold text-ink">Daftar Baris Ditolak</h5>
                <div className="border border-line rounded-xl overflow-hidden bg-card">
                  <table className="w-full text-left text-xs">
                    <thead className="border-b border-line bg-page text-muted font-semibold">
                      <tr>
                        <th className="px-4 py-2.5">BARIS</th>
                        <th className="px-4 py-2.5">NIS</th>
                        <th className="px-4 py-2.5">NAMA SISWA</th>
                        <th className="px-4 py-2.5">ALASAN GAGAL</th>
                      </tr>
                    </thead>
                    <tbody className="divide-y divide-line text-ink">
                      {resultData.rejectedRows.slice(0, 4).map((row, idx) => (
                        <tr key={idx}>
                          <td className="px-4 py-2 font-mono text-muted">
                            {row.row ?? '-'}
                          </td>
                          <td className="px-4 py-2 font-mono font-semibold">
                            {row.nis || '-'}
                          </td>
                          <td className="px-4 py-2 font-medium">
                            {row.nama ? (
                              row.nama
                            ) : (
                              <span className="italic text-faint">[Kosong]</span>
                            )}
                          </td>
                          <td className="px-4 py-2 text-danger-text flex items-center gap-1.5">
                            <X className="h-3.5 w-3.5 shrink-0" />
                            <span>{row.alasan || row.message}</span>
                          </td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                  {resultData.rejectedRows.length > 4 && (
                    <div className="px-4 py-2 bg-page/50 border-t border-line text-xs italic text-muted text-center">
                      +{resultData.rejectedRows.length - 4} baris lainnya
                    </div>
                  )}
                </div>
              </div>
            )}

            {/* Footer Actions */}
            <div className="flex flex-col sm:flex-row items-center justify-between gap-3 border-t border-line pt-4">
              <Button
                variant="outline"
                className="w-full sm:w-auto"
                onClick={handleResetWizard}
              >
                Import File Lain
              </Button>
              <Button
                variant="solid"
                className="w-full sm:w-auto"
                onClick={() => {
                  queryClient.invalidateQueries(['siswa']);
                  if (onSwitchToDaftarTab) onSwitchToDaftarTab();
                }}
              >
                Lihat Daftar Siswa
              </Button>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}
