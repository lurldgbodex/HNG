interface StatusBadgeProps {
  status: "open" | "in_progress" | "closed";
}

const StatusBadge: React.FC<StatusBadgeProps> = ({ status }) => {
  const statusConfig = {
    open: {
      label: "Open",
      className: "bg-red-100 text-red-800 border-red-200",
    },
    in_progress: {
      label: "In Progress",
      className: "bg-yellow-100 text-yellow-800 border-yellow-200",
    },
    closed: {
      label: "Closed",
      className: "bg-green-100 text-green-800 border-green-200",
    },
  };

  const config = statusConfig[status];

  return (
    <span
      className={`inline-flex items-center px-3 py-1 rounded-full text-xs font-medium border ${config.className}`}
    >
      {config.label}
    </span>
  );
};

export default StatusBadge;
