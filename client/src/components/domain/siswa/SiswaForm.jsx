import { useEffect } from 'react';
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { z } from 'zod';
import { ChevronDown } from 'lucide-react';
import Button from '../../ui/Button';
import Badge from '../../ui/Badge';
import { MAPPEL, KELAS_OPTIONS } from '../../../lib/constants';
import { cn } from '../../../lib/utils';

// Helper mapping data API -> form fields
export function mapSiswaDataToFormValues(data) {
  const mapelEmpty = {};
  MAPPEL.forEach((m) => {
    mapelEmpty[m.key] = '';
  });

  if (!data) {
    return {
      nis: '',
      nama: '',
      kelas: '',
      jenis_kelamin: '',
      nilai: {
        rapor: { ...mapelEmpty },
        pts: { ...mapelEmpty },
        pas: { ...mapelEmpty },
      },
      non_akademik: {
        ekstrakurikuler: '',
        prestasi: '',
        kemampuan: '',
        organisasi: '',
        kursus: '',
        jurusan_1: '',
        jurusan_2: '',
      },
    };
  }

  const siswa = data.siswa ?? data;
  const siswaPeriode = data.siswa_periode ?? data;
  const nilai = data.nilai_akademik ?? data.nilai ?? {};
  const nonAkademik = data.non_akademik ?? data.nonAkademik ?? {};

  return {
    nis: siswa.nis ?? '',
    nama: siswa.nama ?? '',
    kelas: siswaPeriode.kelas ?? '',
    jenis_kelamin: siswa.jenis_kelamin ?? '',
    nilai: {
      rapor: { ...mapelEmpty, ...(nilai.rapor ?? {}) },
      pts: { ...mapelEmpty, ...(nilai.pts ?? {}) },
      pas: { ...mapelEmpty, ...(nilai.pas ?? {}) },
    },
    non_akademik: {
      ekstrakurikuler: nonAkademik.ekstrakurikuler ?? '',
      prestasi: nonAkademik.prestasi ?? '',
      kemampuan: nonAkademik.kemampuan ?? '',
      organisasi: nonAkademik.organisasi ?? '',
      kursus: nonAkademik.kursus ?? '',
      jurusan_1: nonAkademik.jurusan_1 ?? nonAkademik.jurusan1 ?? '',
      jurusan_2: nonAkademik.jurusan_2 ?? nonAkademik.jurusan2 ?? '',
    },
  };
}

// Zod validation schema
const singleNilaiSchema = z.coerce
  .number({ invalid_type_error: 'Wajib diisi angka 0-100' })
  .min(0, 'Nilai minimal 0')
  .max(100, 'Nilai maksimal 100');

const mappelObjectSchema = z.object(
  MAPPEL.reduce((acc, item) => {
    acc[item.key] = singleNilaiSchema;
    return acc;
  }, {})
);

const siswaFormSchema = z.object({
  nis: z.string().trim().min(1, 'NIS wajib diisi'),
  nama: z.string().trim().min(1, 'Nama siswa wajib diisi'),
  kelas: z.enum(['XII-1', 'XII-2', 'XII-3', 'XII-4'], {
    errorMap: () => ({ message: 'Pilih kelas siswa' }),
  }),
  jenis_kelamin: z.enum(['L', 'P'], {
    errorMap: () => ({ message: 'Pilih jenis kelamin' }),
  }),
  nilai: z.object({
    rapor: mappelObjectSchema,
    pts: mappelObjectSchema,
    pas: mappelObjectSchema,
  }),
  non_akademik: z.object({
    ekstrakurikuler: z.string().optional(),
    prestasi: z.string().optional(),
    kemampuan: z.string().optional(),
    organisasi: z.string().optional(),
    kursus: z.string().optional(),
    jurusan_1: z.string().trim().min(1, 'Jurusan 1 wajib diisi'),
    jurusan_2: z.string().trim().min(1, 'Jurusan 2 wajib diisi'),
  }),
});

export default function SiswaForm({
  mode = 'create', // 'create' | 'edit'
  initialData = null,
  onSubmit,
  onCancel,
  isSubmitting = false,
  serverNisError = null,
  onClearServerNisError,
}) {
  const {
    register,
    handleSubmit,
    reset,
    formState: { errors },
  } = useForm({
    resolver: zodResolver(siswaFormSchema),
    defaultValues: mapSiswaDataToFormValues(initialData),
  });

  useEffect(() => {
    if (initialData) {
      reset(mapSiswaDataToFormValues(initialData));
    }
  }, [initialData, reset]);

  return (
    <form onSubmit={handleSubmit(onSubmit)} className="space-y-8 bg-card p-6">
      {/* SECTION 1: IDENTITAS SISWA */}
      <section className="space-y-4">
        <div>
          <h3 className="text-base font-semibold text-ink">Identitas Siswa</h3>
          <p className="mt-0.5 text-sm text-muted">
            Data identitas dasar siswa pada periode aktif.
          </p>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
          {/* NIS */}
          <div>
            <label className="mb-1.5 block text-xs font-semibold uppercase tracking-wide text-muted">
              NIS <span className="text-brand">*</span>
            </label>
            <input
              type="text"
              {...register('nis', {
                onChange: () => onClearServerNisError?.(),
              })}
              placeholder="contoh: 2101"
              className={cn(
                'h-10 w-full rounded-lg border bg-input px-3 text-sm text-ink placeholder:text-faint transition-colors focus:outline-none focus:ring-2',
                errors.nis || serverNisError
                  ? 'border-danger focus:border-danger focus:ring-danger/30'
                  : 'border-line focus:border-brand focus:ring-brand/30'
              )}
            />
            {(errors.nis || serverNisError) && (
              <p className="mt-1.5 text-xs text-danger-text">
                {serverNisError || errors.nis?.message}
              </p>
            )}
          </div>

          {/* Nama Siswa */}
          <div>
            <label className="mb-1.5 block text-xs font-semibold uppercase tracking-wide text-muted">
              NAMA SISWA <span className="text-brand">*</span>
            </label>
            <input
              type="text"
              {...register('nama')}
              placeholder="contoh: Muhammad Rizky Pratama"
              className={cn(
                'h-10 w-full rounded-lg border bg-input px-3 text-sm text-ink placeholder:text-faint transition-colors focus:outline-none focus:ring-2',
                errors.nama
                  ? 'border-danger focus:border-danger focus:ring-danger/30'
                  : 'border-line focus:border-brand focus:ring-brand/30'
              )}
            />
            {errors.nama && (
              <p className="mt-1.5 text-xs text-danger-text">{errors.nama.message}</p>
            )}
          </div>

          {/* Kelas */}
          <div>
            <label className="mb-1.5 block text-xs font-semibold uppercase tracking-wide text-muted">
              KELAS <span className="text-brand">*</span>
            </label>
            <div className="relative">
              <select
                {...register('kelas')}
                className={cn(
                  'h-10 w-full appearance-none cursor-pointer rounded-lg border bg-input pl-3 pr-8 text-sm text-ink transition-colors focus:outline-none focus:ring-2',
                  errors.kelas
                    ? 'border-danger focus:border-danger focus:ring-danger/30'
                    : 'border-line focus:border-brand focus:ring-brand/30'
                )}
              >
                <option value="">Pilih kelas</option>
                {KELAS_OPTIONS.map((k) => (
                  <option key={k} value={k}>
                    {k}
                  </option>
                ))}
              </select>
              <ChevronDown
                size={16}
                className="pointer-events-none absolute right-3 top-1/2 -translate-y-1/2 text-faint"
                aria-hidden="true"
              />
            </div>
            {errors.kelas && (
              <p className="mt-1.5 text-xs text-danger-text">{errors.kelas.message}</p>
            )}
          </div>

          {/* Jenis Kelamin */}
          <div>
            <label className="mb-1.5 block text-xs font-semibold uppercase tracking-wide text-muted">
              JENIS KELAMIN <span className="text-brand">*</span>
            </label>
            <div className="relative">
              <select
                {...register('jenis_kelamin')}
                className={cn(
                  'h-10 w-full appearance-none cursor-pointer rounded-lg border bg-input pl-3 pr-8 text-sm text-ink transition-colors focus:outline-none focus:ring-2',
                  errors.jenis_kelamin
                    ? 'border-danger focus:border-danger focus:ring-danger/30'
                    : 'border-line focus:border-brand focus:ring-brand/30'
                )}
              >
                <option value="">Pilih jenis kelamin</option>
                <option value="L">Laki-laki</option>
                <option value="P">Perempuan</option>
              </select>
              <ChevronDown
                size={16}
                className="pointer-events-none absolute right-3 top-1/2 -translate-y-1/2 text-faint"
                aria-hidden="true"
              />
            </div>
            {errors.jenis_kelamin && (
              <p className="mt-1.5 text-xs text-danger-text">{errors.jenis_kelamin.message}</p>
            )}
          </div>
        </div>
      </section>

      {/* SECTION 2: NILAI AKADEMIK */}
      <section className="space-y-4">
        <div className="flex items-center justify-between">
          <div>
            <h3 className="text-base font-semibold text-ink">Nilai Akademik</h3>
            <p className="mt-0.5 text-sm text-muted">
              Satu nilai per mata pelajaran (rentang 0-100).
            </p>
          </div>
          <span className="text-xs font-mono font-semibold text-brand bg-brand-tint px-2.5 py-1 rounded-full">
            {MAPPEL.length} Mapel
          </span>
        </div>

        <div className="overflow-x-auto rounded-lg border border-line">
          <table className="w-full text-left text-sm border-collapse">
            <thead>
              <tr className="border-b border-line bg-elevated text-xs font-semibold uppercase tracking-wide text-muted">
                <th scope="col" className="px-4 py-3">
                  MATA PELAJARAN <span className="text-brand">*</span>
                </th>
                <th scope="col" className="px-4 py-3 text-center font-mono w-32 sm:w-40">
                  RAPOR
                </th>
                <th scope="col" className="px-4 py-3 text-center font-mono w-32 sm:w-40">
                  PTS
                </th>
                <th scope="col" className="px-4 py-3 text-center font-mono w-32 sm:w-40">
                  PAS
                </th>
              </tr>
            </thead>
            <tbody className="divide-y divide-line text-ink">
              {MAPPEL.map((item) => {
                const errRapor = errors.nilai?.rapor?.[item.key];
                const errPts = errors.nilai?.pts?.[item.key];
                const errPas = errors.nilai?.pas?.[item.key];

                return (
                  <tr key={item.key} className="hover:bg-input/50 transition-colors">
                    <td className="px-4 py-2.5 font-medium">{item.label}</td>

                    {/* RAPOR */}
                    <td className="px-2 py-2">
                      <input
                        type="number"
                        min={0}
                        max={100}
                        step={1}
                        placeholder="0-100"
                        {...register(`nilai.rapor.${item.key}`)}
                        className={cn(
                          'h-9 w-full rounded-md border bg-input px-2.5 text-center font-mono text-sm text-ink placeholder:text-faint transition-colors focus:outline-none focus:ring-2',
                          errRapor
                            ? 'border-danger focus:border-danger focus:ring-danger/30'
                            : 'border-line focus:border-brand focus:ring-brand/30'
                        )}
                      />
                    </td>

                    {/* PTS */}
                    <td className="px-2 py-2">
                      <input
                        type="number"
                        min={0}
                        max={100}
                        step={1}
                        placeholder="0-100"
                        {...register(`nilai.pts.${item.key}`)}
                        className={cn(
                          'h-9 w-full rounded-md border bg-input px-2.5 text-center font-mono text-sm text-ink placeholder:text-faint transition-colors focus:outline-none focus:ring-2',
                          errPts
                            ? 'border-danger focus:border-danger focus:ring-danger/30'
                            : 'border-line focus:border-brand focus:ring-brand/30'
                        )}
                      />
                    </td>

                    {/* PAS */}
                    <td className="px-2 py-2">
                      <input
                        type="number"
                        min={0}
                        max={100}
                        step={1}
                        placeholder="0-100"
                        {...register(`nilai.pas.${item.key}`)}
                        className={cn(
                          'h-9 w-full rounded-md border bg-input px-2.5 text-center font-mono text-sm text-ink placeholder:text-faint transition-colors focus:outline-none focus:ring-2',
                          errPas
                            ? 'border-danger focus:border-danger focus:ring-danger/30'
                            : 'border-line focus:border-brand focus:ring-brand/30'
                        )}
                      />
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>
      </section>

      {/* SECTION 3: DATA NON-AKADEMIK */}
      <section className="space-y-4">
        <div>
          <h3 className="text-base font-semibold text-ink">Data Non-Akademik</h3>
          <p className="mt-0.5 text-sm text-muted">
            Aktivitas dan minat siswa untuk pembobotan rekomendasi.
          </p>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
          {/* Ekstrakurikuler */}
          <div>
            <label className="mb-1.5 block text-xs font-semibold uppercase tracking-wide text-muted">
              EKSTRAKURIKULER
            </label>
            <input
              type="text"
              {...register('non_akademik.ekstrakurikuler')}
              placeholder="contoh: Paskibra, Pramuka"
              className="h-10 w-full rounded-lg border border-line bg-input px-3 text-sm text-ink placeholder:text-faint focus:border-brand focus:outline-none focus:ring-2 focus:ring-brand/30 transition-colors"
            />
          </div>

          {/* Prestasi */}
          <div>
            <label className="mb-1.5 block text-xs font-semibold uppercase tracking-wide text-muted">
              PRESTASI
            </label>
            <input
              type="text"
              {...register('non_akademik.prestasi')}
              placeholder="contoh: Juara 1 OSN Matematika"
              className="h-10 w-full rounded-lg border border-line bg-input px-3 text-sm text-ink placeholder:text-faint focus:border-brand focus:outline-none focus:ring-2 focus:ring-brand/30 transition-colors"
            />
          </div>

          {/* Kemampuan */}
          <div>
            <label className="mb-1.5 block text-xs font-semibold uppercase tracking-wide text-muted">
              KEMAMPUAN
            </label>
            <input
              type="text"
              {...register('non_akademik.kemampuan')}
              placeholder="contoh: Pemrograman Python, Design"
              className="h-10 w-full rounded-lg border border-line bg-input px-3 text-sm text-ink placeholder:text-faint focus:border-brand focus:outline-none focus:ring-2 focus:ring-brand/30 transition-colors"
            />
          </div>

          {/* Organisasi */}
          <div>
            <label className="mb-1.5 block text-xs font-semibold uppercase tracking-wide text-muted">
              ORGANISASI
            </label>
            <input
              type="text"
              {...register('non_akademik.organisasi')}
              placeholder="contoh: Ketua OSIS"
              className="h-10 w-full rounded-lg border border-line bg-input px-3 text-sm text-ink placeholder:text-faint focus:border-brand focus:outline-none focus:ring-2 focus:ring-brand/30 transition-colors"
            />
          </div>

          {/* Kursus */}
          <div>
            <label className="mb-1.5 block text-xs font-semibold uppercase tracking-wide text-muted">
              KURSUS
            </label>
            <input
              type="text"
              {...register('non_akademik.kursus')}
              placeholder="contoh: Bimbingan Belajar"
              className="h-10 w-full rounded-lg border border-line bg-input px-3 text-sm text-ink placeholder:text-faint focus:border-brand focus:outline-none focus:ring-2 focus:ring-brand/30 transition-colors"
            />
          </div>

          {/* Spacer on desktop */}
          <div className="hidden sm:block" />

          {/* Jurusan 1 */}
          <div>
            <label className="mb-1.5 block text-xs font-semibold uppercase tracking-wide text-muted">
              JURUSAN 1 <span className="text-brand">*</span>
            </label>
            <input
              type="text"
              {...register('non_akademik.jurusan_1')}
              placeholder="contoh: Teknik Informatika"
              className={cn(
                'h-10 w-full rounded-lg border bg-input px-3 text-sm text-ink placeholder:text-faint transition-colors focus:outline-none focus:ring-2',
                errors.non_akademik?.jurusan_1
                  ? 'border-danger focus:border-danger focus:ring-danger/30'
                  : 'border-line focus:border-brand focus:ring-brand/30'
              )}
            />
            {errors.non_akademik?.jurusan_1 && (
              <p className="mt-1.5 text-xs text-danger-text">
                {errors.non_akademik.jurusan_1.message}
              </p>
            )}
          </div>

          {/* Jurusan 2 */}
          <div>
            <label className="mb-1.5 block text-xs font-semibold uppercase tracking-wide text-muted">
              JURUSAN 2 <span className="text-brand">*</span>
            </label>
            <input
              type="text"
              {...register('non_akademik.jurusan_2')}
              placeholder="contoh: Sistem Informasi"
              className={cn(
                'h-10 w-full rounded-lg border bg-input px-3 text-sm text-ink placeholder:text-faint transition-colors focus:outline-none focus:ring-2',
                errors.non_akademik?.jurusan_2
                  ? 'border-danger focus:border-danger focus:ring-danger/30'
                  : 'border-line focus:border-brand focus:ring-brand/30'
              )}
            />
            {errors.non_akademik?.jurusan_2 && (
              <p className="mt-1.5 text-xs text-danger-text">
                {errors.non_akademik.jurusan_2.message}
              </p>
            )}
          </div>
        </div>
      </section>

      {/* FOOTER */}
      <div className="flex flex-wrap items-center justify-between gap-4 border-t border-line pt-6">
        {mode === 'create' ? (
          <div className="flex items-center gap-2">
            <Badge tone="warning">Manual</Badge>
            <span className="text-xs text-muted">
              Data akan disimpan dengan source: Manual (single_input).
            </span>
          </div>
        ) : (
          <div />
        )}

        <div className="flex items-center gap-3 ml-auto">
          <Button type="button" variant="outline" onClick={onCancel} disabled={isSubmitting}>
            Batal
          </Button>
          <Button type="submit" variant="solid" disabled={isSubmitting}>
            {isSubmitting
              ? 'Menyimpan...'
              : mode === 'create'
              ? 'Simpan Data'
              : 'Simpan Perubahan'}
          </Button>
        </div>
      </div>
    </form>
  );
}
