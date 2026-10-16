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

// ===== BE-PRE-3 Transformasi (Kamus Bidang L2 + Encode + Min-Max).
// GET /preprocessing/transform/config ?periodeId=<optional int> — sama dgn pipeline-status.
const transformConfigQuerySchema = pipelineStatusQuerySchema;

// POST /preprocessing/transform/options body: { fieldName, name, code? }.
// code opsional (create-only, ruling V-3): default max(code)+1 per (periode, field)
// dihitung di service. Batas panjang mengikuti kolom DB category_option.
const transformOptionBodySchema = z.object({
  fieldName: z.string().min(1, 'Nama field wajib diisi').max(30, 'Nama field maksimal 30 karakter'),
  name: z.string().min(1, 'Nama bidang wajib diisi').max(100, 'Nama bidang maksimal 100 karakter'),
  code: z
    .number()
    .int('Kode bidang harus bilangan bulat')
    .min(0, 'Kode bidang tidak boleh negatif')
    .optional(),
});

// DELETE /preprocessing/transform/options/:id — param :id integer positif.
const transformOptionIdParamSchema = z.object({
  id: z.coerce.number().int('ID opsi tidak valid').positive('ID opsi tidak valid'),
});

// POST /preprocessing/transform/assignments body:
// { fieldName, optionId, standardValues: [string] } — upsert L2 per (periode, field, standard_value).
const transformAssignmentsBodySchema = z.object({
  fieldName: z.string().min(1, 'Nama field wajib diisi').max(30, 'Nama field maksimal 30 karakter'),
  optionId: z.number().int('ID opsi tidak valid').positive('ID opsi tidak valid'),
  standardValues: z
    .array(z.string().min(1, 'Nilai standar wajib string tidak kosong').max(191, 'Nilai standar maksimal 191 karakter'))
    .min(1, 'Daftar nilai standar tidak boleh kosong'),
});

// POST /preprocessing/transform/run ?periodeId=<optional int> — query saja (tanpa body).
const transformRunQuerySchema = pipelineStatusQuerySchema;

// ===== BE-PRE-4 Reduksi.
// POST /preprocessing/reduction/run & GET /preprocessing/reduction/summary
// ?periodeId=<optional int> — query saja (tanpa body), sama dgn pipeline-status.
const reductionRunQuerySchema = pipelineStatusQuerySchema;

module.exports = {
  pipelineStatusQuerySchema,
  sourcePreviewQuerySchema,
  cleaningBodySchema,
  transformConfigQuerySchema,
  transformOptionBodySchema,
  transformOptionIdParamSchema,
  transformAssignmentsBodySchema,
  transformRunQuerySchema,
  reductionRunQuerySchema,
};
