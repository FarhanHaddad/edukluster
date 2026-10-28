// Controller K-Means — TIKET BE-KM-2. Skinny: TANPA business logic (semua di service).
'use strict';

const kmeansService = require('../services/kmeans/kmeans.service');
const {
  kmeansRunQuerySchema,
  kmeansLatestQuerySchema,
  kmeansCentroidsParamSchema,
} = require('../validations/kmeans.validation');

// POST /api/kmeans/runs?periodeId= — jalankan Lloyd + audit trail (409 bila terkunci derived).
async function runKmeans(req, res, next) {
  try {
    const query = kmeansRunQuerySchema.parse(req.query);
    const data = await kmeansService.executeKmeansRun(query.periodeId, req.admin);
    return res.status(201).json({ success: true, message: 'K-Means berhasil dijalankan', data });
  } catch (err) {
    return next(err);
  }
}

// GET /api/kmeans/runs/latest?periodeId= — summary + iterations (moves/movers) + assignments.
async function getLatestRun(req, res, next) {
  try {
    const query = kmeansLatestQuerySchema.parse(req.query);
    const data = await kmeansService.getLatestKmeansRun(query.periodeId);
    return res.json({ success: true, message: 'Berhasil mengambil run K-Means terbaru', data });
  } catch (err) {
    return next(err);
  }
}

// GET /api/kmeans/runs/latest/iterations/:iterationNumber/centroids — lazy accordion 8E.
async function getIterationCentroids(req, res, next) {
  try {
    const params = kmeansCentroidsParamSchema.parse(req.params);
    const query = kmeansLatestQuerySchema.parse(req.query);
    const data = await kmeansService.getIterationCentroids(query.periodeId, params.iterationNumber);
    return res.json({ success: true, message: 'Berhasil mengambil centroid iterasi', data });
  } catch (err) {
    return next(err);
  }
}

module.exports = { runKmeans, getLatestRun, getIterationCentroids };
