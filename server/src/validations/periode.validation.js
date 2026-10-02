const { z } = require('zod');

// POST /api/periodes — validasi body pembuatan periode (FR-B01).
const createPeriodeSchema = z.object({
  tahunAjaran: z
    .string()
    .trim()
    .regex(/^\d{4}\/\d{4}$/, 'Format tahun ajaran harus YYYY/YYYY, contoh 2025/2026'),
  semester: z.enum(['GANJIL', 'GENAP'], {
    message: 'Semester harus GANJIL atau GENAP',
  }),
});

// PATCH /api/periodes/:id/activate — validasi param id (FR-B02).
const periodeIdParamSchema = z.object({
  id: z.coerce.number().int().positive('ID periode tidak valid'),
});

module.exports = { createPeriodeSchema, periodeIdParamSchema };
