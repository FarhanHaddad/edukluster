// Validasi K-Means — TIKET BE-KM-2 (zod, pola sama dgn preprocessing.validation.js).
'use strict';

const { z } = require('zod');

// POST /kmeans/runs ?periodeId=<optional int>
const kmeansRunQuerySchema = z.object({
  periodeId: z.coerce.number().int().positive('Periode tidak valid').optional(),
});

// GET /kmeans/runs/latest (+ centroids) ?periodeId=<optional int>
const kmeansLatestQuerySchema = z.object({
  periodeId: z.coerce.number().int().positive('Periode tidak valid').optional(),
});

// Param :iterationNumber — int >= 0 (iterasi 0-based).
const kmeansCentroidsParamSchema = z.object({
  iterationNumber: z.coerce.number().int().min(0, 'Iterasi tidak valid'),
});

module.exports = { kmeansRunQuerySchema, kmeansLatestQuerySchema, kmeansCentroidsParamSchema };
