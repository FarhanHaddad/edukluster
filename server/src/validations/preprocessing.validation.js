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

module.exports = { pipelineStatusQuerySchema, sourcePreviewQuerySchema };
