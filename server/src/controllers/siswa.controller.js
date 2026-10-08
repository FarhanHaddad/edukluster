const siswaService = require('../services/siswa.service');
const {
  createSiswaSchema,
  updateSiswaSchema,
  listSiswaQuerySchema,
  siswaIdParamSchema,
} = require('../validations/siswa.validation');

// GET /api/siswa — daftar siswa per periode + filter/pagination (FR-C01).
async function listSiswa(req, res, next) {
  try {
    const query = listSiswaQuerySchema.parse(req.query);
    const data = await siswaService.listSiswa(query);
    return res.json({
      success: true,
      message: 'Berhasil mengambil daftar siswa',
      data,
    });
  } catch (err) {
    return next(err);
  }
}

// GET /api/siswa/:id — detail siswa + nilai (rapor/pts/pas) + non-akademik (FR-C01).
async function getSiswa(req, res, next) {
  try {
    const { id } = siswaIdParamSchema.parse(req.params);
    const query = listSiswaQuerySchema.pick({ periode_id: true }).parse(req.query);
    const data = await siswaService.getSiswaDetail(id, query.periode_id);
    return res.json({
      success: true,
      message: 'Berhasil mengambil detail siswa',
      data,
    });
  } catch (err) {
    return next(err);
  }
}

// POST /api/siswa — single input manual satu transaksi (FR-C01).
async function createSiswa(req, res, next) {
  try {
    const payload = createSiswaSchema.parse(req.body);
    const data = await siswaService.createSiswa(payload);
    return res.status(201).json({
      success: true,
      message: 'Berhasil menambahkan siswa',
      data,
    });
  } catch (err) {
    return next(err);
  }
}

// PUT /api/siswa/:id — update siswa + upsert nilai & non-akademik (FR-C01).
async function updateSiswa(req, res, next) {
  try {
    const { id } = siswaIdParamSchema.parse(req.params);
    const payload = updateSiswaSchema.parse(req.body);
    const data = await siswaService.updateSiswa(id, payload);
    return res.json({
      success: true,
      message: 'Berhasil memperbarui siswa',
      data,
    });
  } catch (err) {
    return next(err);
  }
}

// DELETE /api/siswa/:id — hapus siswa dengan proteksi RESTRICT cluster (FR-C03).
async function deleteSiswa(req, res, next) {
  try {
    const { id } = siswaIdParamSchema.parse(req.params);
    const query = listSiswaQuerySchema.pick({ periode_id: true }).parse(req.query);
    await siswaService.deleteSiswa(id, query.periode_id);
    return res.json({
      success: true,
      message: 'Siswa berhasil dihapus.',
      data: null,
    });
  } catch (err) {
    return next(err);
  }
}

module.exports = { listSiswa, getSiswa, createSiswa, updateSiswa, deleteSiswa };
