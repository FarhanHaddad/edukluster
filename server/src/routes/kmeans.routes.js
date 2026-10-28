// Routes K-Means — TIKET BE-KM-2. Semua endpoint wajib token admin (req.admin).
'use strict';

const { Router } = require('express');
const kmeansController = require('../controllers/kmeans.controller');
const { protect } = require('../middleware/auth.middleware');

const router = Router();

router.use(protect);

// POST /api/kmeans/runs?periodeId= — eksekusi K-Means; run kedua -> 409 (lock derived).
router.post('/runs', kmeansController.runKmeans);

// GET /api/kmeans/runs/latest?periodeId= — summary + iterations + assignments final.
router.get('/runs/latest', kmeansController.getLatestRun);

// GET /api/kmeans/runs/latest/iterations/:iterationNumber/centroids — 10x25 string 4 desimal.
router.get('/runs/latest/iterations/:iterationNumber/centroids', kmeansController.getIterationCentroids);

module.exports = router;
