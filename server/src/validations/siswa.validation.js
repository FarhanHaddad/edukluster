const { z } = require('zod');

// 18 mata pelajaran wajib (Decimal(5,2) di DB) — dipakai sub-schema nilai di bawah.
const MATA_PELAJARAN = [
  'agama',
  'pkn',
  'b_indonesia',
  'b_inggris',
  'mtk_wajib',
  'sejarah',
  'pjok',
  'seni_rupa',
  'b_jepang',
  'biologi',
  'fisika',
  'kimia',
  'informatika',
  'mtk_lanjut',
  'geografi',
  'sosial',
  'pkwu',
  'ekonomi',
];

// Satu angka nilai mapel: 0-100 dengan maksimal 2 desimal (selaras Decimal(5,2)).
const nilaiMapelFieldSchema = z
  .number({ message: 'Nilai harus berupa angka' })
  .min(0, 'Nilai minimal 0')
  .max(100, 'Nilai maksimal 100')
  .multipleOf(0.01, 'Nilai maksimal 2 angka desimal');

// Identitas siswa + kelas (FR-C01). Dipakai POST & PUT (nis opsional via .partial()).
const identitasSchema = z.object({
  nis: z
    .string()
    .trim()
    .min(1, 'NIS wajib diisi')
    .max(20, 'NIS maksimal 20 karakter'),
  nama: z
    .string()
    .trim()
    .min(1, 'Nama wajib diisi')
    .max(150, 'Nama maksimal 150 karakter'),
  jenis_kelamin: z.enum(['L', 'P'], {
    message: 'Jenis kelamin harus L atau P',
  }),
  kelas: z
    .string()
    .trim()
    .min(1, 'Kelas wajib diisi')
    .max(20, 'Kelas maksimal 20 karakter'),
});

// Nilai satu jenis (rapor | pts | pas): ke-18 mapel WAJIB ada (RULING: tidak auto-duplikasi).
const nilaiMapelSchema = z.object({
  agama: nilaiMapelFieldSchema,
  pkn: nilaiMapelFieldSchema,
  b_indonesia: nilaiMapelFieldSchema,
  b_inggris: nilaiMapelFieldSchema,
  mtk_wajib: nilaiMapelFieldSchema,
  sejarah: nilaiMapelFieldSchema,
  pjok: nilaiMapelFieldSchema,
  seni_rupa: nilaiMapelFieldSchema,
  b_jepang: nilaiMapelFieldSchema,
  biologi: nilaiMapelFieldSchema,
  fisika: nilaiMapelFieldSchema,
  kimia: nilaiMapelFieldSchema,
  informatika: nilaiMapelFieldSchema,
  mtk_lanjut: nilaiMapelFieldSchema,
  geografi: nilaiMapelFieldSchema,
  sosial: nilaiMapelFieldSchema,
  pkwu: nilaiMapelFieldSchema,
  ekonomi: nilaiMapelFieldSchema,
});

// Paket lengkap: ketiga jenis nilai wajib ada.
const nilaiAkademikSchema = z
  .object({
    rapor: nilaiMapelSchema,
    pts: nilaiMapelSchema,
    pas: nilaiMapelSchema,
  })
  .refine((nilai) => Object.keys(nilai).length === 3, {
    message: 'Nilai rapor, pts, dan pas wajib diisi',
  });

// Data non-akademik: semua field opsional, panjang mengikuti schema VarChar.
const nonAkademikSchema = z.object({
  ekstrakurikuler: z.string().trim().max(100, 'Ekstrakurikuler maksimal 100 karakter').optional(),
  prestasi: z.string().trim().max(100, 'Prestasi maksimal 100 karakter').optional(),
  kemampuan: z.string().trim().max(100, 'Kemampuan maksimal 100 karakter').optional(),
  organisasi: z.string().trim().max(100, 'Organisasi maksimal 100 karakter').optional(),
  kursus: z.string().trim().max(100, 'Kursus maksimal 100 karakter').optional(),
  jurusan_1: z.string().trim().max(150, 'Jurusan 1 maksimal 150 karakter').optional(),
  jurusan_2: z.string().trim().max(150, 'Jurusan 2 maksimal 150 karakter').optional(),
});

// POST /api/siswa — single input manual (FR-C01).
const createSiswaSchema = z.object({
  periode_id: z.coerce.number().int().positive('Periode tidak valid').optional(),
  ...identitasSchema.shape,
  nilai: nilaiAkademikSchema,
  non_akademik: nonAkademikSchema.optional(),
});

// PUT /api/siswa/:id — semua field opsional; bila dikirim, tetap divalidasi penuh.
const updateSiswaSchema = z.object({
  periode_id: z.coerce.number().int().positive('Periode tidak valid').optional(),
  ...identitasSchema.partial().shape,
  nilai: nilaiAkademikSchema.partial().optional(),
  non_akademik: nonAkademikSchema.optional(),
});

// GET /api/siswa — filter + pagination (q, kelas, source, periode_id, page, limit).
const listSiswaQuerySchema = z.object({
  periode_id: z.coerce.number().int().positive('Periode tidak valid').optional(),
  q: z.string().trim().min(1).max(150).optional(),
  kelas: z.string().trim().min(1).max(20).optional(),
  source: z.enum(['single_input', 'excel'], {
    message: 'Source harus single_input atau excel',
  }).optional(),
  page: z.coerce.number().int().min(1, 'Page minimal 1').default(1),
  limit: z.coerce.number().int().min(1, 'Limit minimal 1').max(100, 'Limit maksimal 100').default(10),
});

// :id pada route GET/PUT/DELETE — validasi param id.
const siswaIdParamSchema = z.object({
  id: z.coerce.number().int().positive('ID siswa tidak valid'),
});

module.exports = {
  MATA_PELAJARAN,
  identitasSchema,
  nilaiMapelSchema,
  nilaiAkademikSchema,
  nonAkademikSchema,
  createSiswaSchema,
  updateSiswaSchema,
  listSiswaQuerySchema,
  siswaIdParamSchema,
};
