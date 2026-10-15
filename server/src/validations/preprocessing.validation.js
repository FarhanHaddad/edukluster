const { z } = require('zod');

// Kontrak query BE-PRE-1 (formal — komentar di atas = informal).
// GET /preprocessing/pipeline-status ?periodeId=<optional int>
const pipelineStatusQuerySchema = z.object({
  periodeId: z.coerce.number().int().positive('Periode tidak valid').optional(),
});

// GET /preprocessing/source-preview ?jenis=rapor|pts|pas|non_akademik&page&limit&periodeId?
const sourcePreviewQuerySchema = z.object({
  jenis: z.enum(['rapor', 'pts', 'pas', 'non_akademik'], {
    message: 'Jenis harus rapor, pts, pas, atau non_akademik',
  }),
  page: z.coerce.number().int().min(1, 'Page minimal 1').default(1),
  limit: z.coerce.number().int().min(1, 'Limit minimal 1').max(200, 'Limit maksimal 200').default(20),
  periodeId: z.coerce.number().int().positive('Periode tidak valid').optional(),
});

// ===== BE-PRE-2 Cleaning.
// POST /preprocessing/cleaning body (kontrak mentor):
// { imputationMethod: "mean"|"median"|"mode", mappings: { <field>: { <raw>: <standard> } } }
// mappings opsional (boleh {}); key field dibatasi string <=50 (schema category_mapping),
// rawValue <=150, standardValue <=150 sesuai batas kolom DB.
const cleaningBodySchema = z.object({
  imputationMethod: z.enum(['mean', 'median', 'mode'], {
    message: 'Metode imputasi harus mean, median, atau mode',
  }),
  mappings: z
    .record(
      z.string().min(1, 'Nama field tidak valid').max(50, 'Nama field maksimal 50 karakter'),
      z.record(
        z.string().min(1, 'Nilai asal tidak valid').max(150, 'Nilai asal maksimal 150 karakter'),
        z.string().min(1, 'Nilai standar wajib string').max(150, 'Nilai standar maksimal 150 karakter')
      )
    )
    .default({}),
});

module.exports = {
  pipelineStatusQuerySchema,
  sourcePreviewQuerySchema,
  cleaningBodySchema,
};
