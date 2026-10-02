const periodeService = require('../services/periode.service');
const { createPeriodeSchema, periodeIdParamSchema } = require('../validations/periode.validation');

// GET /api/periodes — daftar semua periode (FR-B01).
async function listPeriodes(_req, res, next) {
  try {
    const data = await periodeService.listPeriodes();
    return res.json({
      success: true,
      message: 'Berhasil mengambil daftar periode',
      data,
    });
  } catch (err) {
    return next(err);
  }
}

// GET /api/periodes/active — periode yang sedang aktif (FR-B02).
async function getActivePeriode(_req, res, next) {
  try {
    const data = await periodeService.getActivePeriode();
    return res.json({
      success: true,
      message: 'Berhasil mengambil periode aktif',
      data,
    });
  } catch (err) {
    return next(err);
  }
}

// POST /api/periodes — buat periode baru (FR-B01).
async function createPeriode(req, res, next) {
  try {
    const payload = createPeriodeSchema.parse(req.body);
    const data = await periodeService.createPeriode(payload);
    return res.status(201).json({
      success: true,
      message: 'Berhasil menambahkan periode',
      data,
    });
  } catch (err) {
    return next(err);
  }
}

// PATCH /api/periodes/:id/activate — aktivasi periode (FR-B02).
async function activatePeriode(req, res, next) {
  try {
    const { id } = periodeIdParamSchema.parse(req.params);
    const data = await periodeService.activatePeriode(id);
    return res.json({
      success: true,
      message: 'Berhasil mengaktifkan periode',
      data,
    });
  } catch (err) {
    return next(err);
  }
}

module.exports = { listPeriodes, getActivePeriode, createPeriode, activatePeriode };
