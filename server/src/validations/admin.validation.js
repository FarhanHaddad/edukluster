const { z } = require('zod');

// POST /api/admins — validasi body pembuatan admin (FR-A03).
// FE Screen 12 hanya mengirim username + password; name/email opsional di BE.
const createAdminSchema = z.object({
  username: z
    .string()
    .trim()
    .min(3, 'Username minimal 3 karakter')
    .max(50, 'Username maksimal 50 karakter'),
  password: z
    .string()
    .min(6, 'Password minimal 6 karakter')
    .max(72, 'Password maksimal 72 karakter'),
  name: z.string().trim().max(100, 'Nama maksimal 100 karakter').optional(),
  email: z
    .string()
    .trim()
    .email('Format email tidak valid')
    .max(100, 'Email maksimal 100 karakter')
    .optional()
    .or(z.literal('').transform(() => undefined)),
});

// PUT /api/admins/:id — update profil; password kosong/absen = tidak diubah (FR-A03).
const updateAdminSchema = z.object({
  username: z
    .string()
    .trim()
    .min(3, 'Username minimal 3 karakter')
    .max(50, 'Username maksimal 50 karakter'),
  password: z
    .string()
    .min(6, 'Password minimal 6 karakter')
    .max(72, 'Password maksimal 72 karakter')
    .optional()
    .or(z.literal('').transform(() => undefined)),
});

// :id pada semua route admin — validasi param id.
const adminIdParamSchema = z.object({
  id: z.coerce.number().int().positive('ID admin tidak valid'),
});

module.exports = { createAdminSchema, updateAdminSchema, adminIdParamSchema };
