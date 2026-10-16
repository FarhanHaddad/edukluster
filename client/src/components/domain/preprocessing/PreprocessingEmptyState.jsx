import { Database } from 'lucide-react';
import EmptyState from '../EmptyState';

export default function PreprocessingEmptyState() {
  return (
    <EmptyState
      icon={Database}
      title="Belum Ada Data Siswa"
      description="Pipeline preprocessing membutuhkan data siswa pada periode aktif. Import melalui Excel atau tambahkan manual untuk memulai."
      ctaLabel="Import Data Siswa"
      ctaTo="/siswa"
      linkLabel="Tambah Manual"
      linkTo="/siswa"
    />
  );
}
