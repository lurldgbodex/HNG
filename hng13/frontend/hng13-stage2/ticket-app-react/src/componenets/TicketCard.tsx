import clsx from "clsx";
import type { Ticket } from "../types";

const statusColor = (s: Ticket["status"]) => {
  if (s === "open") return "bg-green-100 text-green-800";
  if (s === "in_progress") return "gb-amber-100 text-amber-800";
  return "bg-gray-100 text-gray-700";
};

type TicketCardProps = {
  ticket: Ticket;
  onEdit: (t: Ticket) => void;
  onDelete: (id: string) => void;
};

const TicketCard: React.FC<TicketCardProps> = ({
  ticket,
  onEdit,
  onDelete,
}) => {
  return (
    <article className="bg-white rounded-lg shadow p-4 flex flex-col gap-3">
      <div className="flex items-start justify-between">
        <div>
          <h4 className="font-semibold">{ticket.title}</h4>
          <p className="text-sm text-slate-500">{ticket.description}</p>
        </div>
        <div className="text-right">
          <span
            className={clsx(
              "inline-block px-2 py-1 text-xs rounded-full",
              statusColor(ticket.status)
            )}
          >
            {ticket.status.replace("_", " ")}
          </span>
          <div className="mt-2 flex gap-2">
            <button
              className="text-sm btn-ghost"
              onClick={() => onEdit(ticket)}
            >
              Edit
            </button>
            <button
              className="text-sm btn-ghost text-red-600"
              onClick={() => onDelete(ticket.id)}
            >
              Delete
            </button>
          </div>
        </div>
      </div>
      <div className="text-xs text-slate-400">
        Created: {new Date(ticket.createdAt).toLocaleString()}
      </div>
    </article>
  );
};

export default TicketCard;
