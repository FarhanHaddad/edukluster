import PageHeader from './PageHeader';

// PlaceholderPage: menu shell yang belum dibangun (Sprint berikutnya).
// Hanya judul menu + deskripsi muted "Segera tersedia." (whitelist teks).
export default function PlaceholderPage({ title }) {
  return (
    <div className="space-y-6">
      <PageHeader title={title} description="Segera tersedia." />
    </div>
  );
}
