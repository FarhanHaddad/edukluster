import Badge from '../../../ui/Badge';

export default function ImportStatusBadge({ status, className }) {
  const statusStr = status || 'Valid';
  const tone =
    statusStr === 'Valid'
      ? 'success'
      : statusStr === 'Missing'
      ? 'warning'
      : 'danger';

  return (
    <Badge tone={tone} className={className}>
      {statusStr}
    </Badge>
  );
}
