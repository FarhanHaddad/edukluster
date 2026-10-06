import { FieldLabel, inputClass } from '../ui/Field';
import PasswordField from '../ui/PasswordField';

export default function AdminFormFields({ register, errors, clearErrors, isEdit = false }) {
  return (
    <div className="space-y-4">
      <div>
        <FieldLabel htmlFor="username">
          Username <span className="text-brand">*</span>
        </FieldLabel>
        <input
          id="username"
          type="text"
          placeholder="contoh: guru_bk_01"
          autoComplete="off"
          aria-invalid={errors.username ? 'true' : undefined}
          className={`${inputClass} ${errors.username ? 'border-danger-text focus:border-danger-text focus:ring-danger-text/30' : ''}`}
          {...register('username', {
            onChange: () => clearErrors('username'),
          })}
        />
        {errors.username ? (
          <p className="mt-1.5 text-sm leading-5 text-danger-text">
            {errors.username.message}
          </p>
        ) : null}
      </div>

      <div>
        <PasswordField
          id="password"
          label={isEdit ? 'Password Baru (Opsional)' : 'Password'}
          required={!isEdit}
          placeholder={isEdit ? 'Kosongkan jika tidak diubah' : 'Minimal 6 karakter'}
          error={errors.password?.message}
          {...register('password', {
            onChange: () => clearErrors('password'),
          })}
        />
      </div>

      <div>
        <PasswordField
          id="confirmPassword"
          label={isEdit ? 'Konfirmasi Password Baru' : 'Konfirmasi Password'}
          required={!isEdit}
          placeholder={isEdit ? 'Kosongkan jika tidak diubah' : 'Ulangi password'}
          error={errors.confirmPassword?.message}
          {...register('confirmPassword', {
            onChange: () => clearErrors('confirmPassword'),
          })}
        />
      </div>
    </div>
  );
}
