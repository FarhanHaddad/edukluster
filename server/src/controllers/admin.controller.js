const adminService = require('../services/admin.service');
const {
  createAdminSchema,
  updateAdminSchema,
  adminIdParamSchema,
} = require('../validations/admin.validation');

// GET /api/admins — daftar semua admin (FR-A03).
async function listAdmins(_req, res, next) {
  try {
    const data = await adminService.listAdmins();
    return res.json({
      success: true,
      message: 'Berhasil mengambil daftar admin',
      data,
    });
  } catch (err) {
    return next(err);
  }
}

// POST /api/admins — buat admin baru (FR-A03).
async function createAdmin(req, res, next) {
  try {
    const payload = createAdminSchema.parse(req.body);
    const data = await adminService.createAdmin(payload);
    return res.status(201).json({
      success: true,
      message: 'Berhasil menambahkan admin',
      data,
    });
  } catch (err) {
    return next(err);
  }
}

// PUT /api/admins/:id — update admin (FR-A03).
async function updateAdmin(req, res, next) {
  try {
    const { id } = adminIdParamSchema.parse(req.params);
    const payload = updateAdminSchema.parse(req.body);
    const data = await adminService.updateAdmin(id, payload);
    return res.json({
      success: true,
      message: 'Berhasil memperbarui admin',
      data,
    });
  } catch (err) {
    return next(err);
  }
}

// PATCH /api/admins/:id/status — toggle status admin tanpa body (FR-M02).
async function toggleAdminStatus(req, res, next) {
  try {
    const { id } = adminIdParamSchema.parse(req.params);
    const data = await adminService.toggleAdminStatus(id, req.admin.id);
    return res.json({
      success: true,
      message: 'Berhasil mengubah status admin',
      data,
    });
  } catch (err) {
    return next(err);
  }
}

// DELETE /api/admins/:id — hapus admin (FR-A03).
async function deleteAdmin(req, res, next) {
  try {
    const { id } = adminIdParamSchema.parse(req.params);
    const data = await adminService.deleteAdmin(id, req.admin.id);
    return res.json({
      success: true,
      message: 'Berhasil menghapus admin',
      data,
    });
  } catch (err) {
    return next(err);
  }
}

module.exports = { listAdmins, createAdmin, updateAdmin, toggleAdminStatus, deleteAdmin };
