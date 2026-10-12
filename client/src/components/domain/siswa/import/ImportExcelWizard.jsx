import { useState, useRef } from 'react';
import { useQueryClient } from '@tanstack/react-query';
import api from '../../../../lib/api';
import ImportStepper from './ImportStepper';
import UploadStep from './UploadStep';
import ValidationProgress from './ValidationProgress';
import TemplateFailPanel from './TemplateFailPanel';
import PreviewStep from './PreviewStep';
import ConfirmStep from './ConfirmStep';
import ResultStep from './ResultStep';

export default function ImportExcelWizard({ onSwitchToDaftarTab, showToast }) {
  const queryClient = useQueryClient();

  // Wizard state: 1: Upload, 2: Validasi, '2-FAIL': Validasi Fail, 3: Preview, 4: Konfirmasi, 5: Hasil
  const [wizardState, setWizardState] = useState(1);

  // File state
  const [selectedFile, setSelectedFile] = useState(null);
  const [preCheckError, setPreCheckError] = useState('');

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
      return;
    }

    setSelectedFile(file);
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

  return (
    <div className="flex flex-col min-h-125">
      {/* STEPPER HEADER */}
      <ImportStepper wizardState={wizardState} />

      {/* BODY CONTENT AREA */}
      <div className="flex-1 p-6 space-y-6">
        {wizardState === 1 && (
          <UploadStep
            selectedFile={selectedFile}
            preCheckError={preCheckError}
            onFileSelect={handleFileSelect}
            onFileRemove={() => setSelectedFile(null)}
            onDownloadTemplate={handleDownloadTemplate}
            onResetWizard={handleResetWizard}
            onStartValidation={handleStartValidation}
          />
        )}

        {wizardState === 2 && (
          <ValidationProgress
            selectedFile={selectedFile}
            validationProgress={validationProgress}
            validationStep={validationStep}
            onCancelValidation={handleCancelValidation}
          />
        )}

        {wizardState === '2-FAIL' && (
          <TemplateFailPanel
            fatalErrors={fatalErrors}
            fatalMessage={fatalMessage}
            onResetWizard={handleResetWizard}
            onDownloadTemplate={handleDownloadTemplate}
          />
        )}

        {wizardState === 3 && (
          <PreviewStep
            previewData={previewData}
            selectedFile={selectedFile}
            activeSheetTab={activeSheetTab}
            previewPage={previewPage}
            onSheetTabChange={(tab) => {
              setActiveSheetTab(tab);
              setPreviewPage(1);
            }}
            onPageChange={(page) => setPreviewPage(page)}
            onResetWizard={handleResetWizard}
            onNext={() => setWizardState(4)}
          />
        )}

        {wizardState === 4 && (
          <ConfirmStep
            previewData={previewData}
            selectedFile={selectedFile}
            consentChecked={consentChecked}
            isConfirming={isConfirming}
            onConsentChange={(val) => setConsentChecked(val)}
            onBack={() => setWizardState(3)}
            onConfirm={handleConfirmImport}
          />
        )}

        {wizardState === 5 && (
          <ResultStep
            resultData={resultData}
            onResetWizard={handleResetWizard}
            onSwitchToDaftar={() => {
              queryClient.invalidateQueries(['siswa']);
              if (onSwitchToDaftarTab) onSwitchToDaftarTab();
            }}
          />
        )}
      </div>
    </div>
  );
}
