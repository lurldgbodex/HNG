import { useMemo, useState } from "react";
import { useLocalState } from "../hooks/useLocalStorage";
import type { Ticket } from "../types";
import { useToast } from "../componenets/ToastProvider";
import { validateTicketInput } from "../utils/validator";
import Header from "../componenets/Header";
import Footer from "../componenets/Footer";
import Modal from "../componenets/Modal";
import TicketCard from "../componenets/TicketCard";
import StatsCard from "../componenets/StatsCard";

const createTicket = (payload: Partial<Ticket>): Ticket => {
  return {
    id: Math.random().toString(36).slice(2),
    title: payload.title || "Untitled",
    description: payload.description || "",
    priority: payload.priority || "medium",
    status: (payload.status as Ticket["status"]) || "open",
    createdAt: new Date().toISOString(),
  };
};

const Tickets = () => {
  const [tickets, setTickets] = useLocalState<Ticket[]>(
    "ticketapp_tickets",
    []
  );
  const [openCreate, setOpenCreate] = useState(false);
  const [editing, setEditing] = useState<Ticket | null>(null);
  const [form, setForm] = useState<Partial<Ticket>>({
    title: "",
    status: "open",
  });
  const [errors, setErrors] = useState<Record<string, string>>({});
  const toast = useToast();

  function reloadEmptyForm() {
    setForm({ title: "", status: "open", description: "", priority: "medium" });
    setErrors({});
  }

  function handleCreate(e: React.FormEvent) {
    e.preventDefault();
    const errs = validateTicketInput({
      title: form.title,
      status: form.status,
    });
    setErrors(errs);
    if (Object.keys(errs).length) return;
    const ticket = createTicket(form);
    setTickets([ticket, ...tickets]);
    toast.push({ type: "success", message: "Ticket created" });
    setOpenCreate(false);
    reloadEmptyForm();
  }

  function handleEditSubmit(e: React.FormEvent) {
    e.preventDefault();
    if (!editing) return;
    const errs = validateTicketInput({
      title: editing.title,
      status: editing.status,
    });
    setErrors(errs);
    if (Object.keys(errs).length) return;
    const updated = tickets.map((t) =>
      t.id === editing.id
        ? { ...editing, updatedAt: new Date().toISOString() }
        : t
    );
    setTickets(updated);
    setEditing(null);
    toast.push({ type: "success", message: "Ticket updated" });
  }

  function handleDelete(id: string) {
    if (!confirm("Delete this ticket?")) return;
    setTickets(tickets.filter((t) => t.id !== id));
    toast.push({ type: "success", message: "Ticket deleted" });
  }

  const statusCounts = useMemo(() => {
    return tickets.reduce((acc: any, t) => {
      acc[t.status] = (acc[t.status] || 0) + 1;
      return acc;
    }, {} as Record<string, number>);
  }, [tickets]);

  const priorityCounts = useMemo(() => {
    return tickets.reduce((acc: any, t) => {
      acc[t.priority] = (acc[t.priority] || 0) + 1;
      return acc;
    }, {} as Record<string, number>);
  }, [tickets]);

  return (
    <div className="min-h-screen flex flex-col bg-gray-50">
      <Header />
      <main className="flex-1 max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        {/* Header Section */}
        <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between mb-8">
          <div className="mb-4 sm:mb-0">
            <h1 className="text-3xl font-bold text-gray-900">Tickets</h1>
            <p className="text-gray-600 mt-2">
              Manage and track all your support tickets
            </p>
          </div>
          <button
            className="btn-primary flex items-center gap-2 px-6 py-3 bg-blue-600 hover:bg-blue-700 text-white font-semibold rounded-lg transition-colors duration-200"
            onClick={() => setOpenCreate(true)}
          >
            <svg
              className="w-5 h-5"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth={2}
                d="M12 4v16m8-8H4"
              />
            </svg>
            Create Ticket
          </button>
        </div>

        {/* Stats Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
          <StatsCard
            title="Total Tickets"
            value={tickets.length}
            icon="📊"
            gradient="from-blue-500 to-blue-600"
          />
          <StatsCard
            title="Open"
            value={statusCounts["open"] || 0}
            icon="🔴"
            gradient="from-red-500 to-red-600"
          />
          <StatsCard
            title="In Progress"
            value={statusCounts["in_progress"] || 0}
            icon="🟡"
            gradient="from-yellow-500 to-yellow-600"
          />
          <StatsCard
            title="Closed"
            value={statusCounts["closed"] || 0}
            icon="🟢"
            gradient="from-green-500 to-green-600"
          />
        </div>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
          <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-200">
            <div className="flex items-center gap-3 mb-4">
              <div className="w-3 h-3 bg-red-500 rounded-full"></div>
              <h3 className="font-semibold text-gray-900">High Priority</h3>
            </div>
            <p className="text-2xl font-bold text-gray-900">
              {priorityCounts["high"] || 0}
            </p>
            <p className="text-sm text-gray-600 mt-1">
              Requires immediate attention
            </p>
          </div>
          <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-200">
            <div className="flex items-center gap-3 mb-4">
              <div className="w-3 h-3 bg-yellow-500 rounded-full"></div>
              <h3 className="font-semibold text-gray-900">Medium Priority</h3>
            </div>
            <p className="text-2xl font-bold text-gray-900">
              {priorityCounts["medium"] || 0}
            </p>
            <p className="text-sm text-gray-600 mt-1">Normal priority tasks</p>
          </div>
          <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-200">
            <div className="flex items-center gap-3 mb-4">
              <div className="w-3 h-3 bg-blue-500 rounded-full"></div>
              <h3 className="font-semibold text-gray-900">Low Priority</h3>
            </div>
            <p className="text-2xl font-bold text-gray-900">
              {priorityCounts["low"] || 0}
            </p>
            <p className="text-sm text-gray-600 mt-1">Can be addressed later</p>
          </div>
        </div>

        <div className="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
          <div className="px-6 py-4 border-b border-gray-200">
            <h2 className="text-lg font-semibold text-gray-900">All Tickets</h2>
          </div>
          <div className="divide-y divide-gray-200">
            {tickets.length === 0 ? (
              <div className="text-center py-12">
                <div className="text-gray-400 mb-4">
                  <svg
                    className="w-16 h-16 mx-auto"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                  >
                    <path
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeWidth={1}
                      d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"
                    />
                  </svg>
                </div>
                <h3 className="text-lg font-medium text-gray-900 mb-2">
                  No tickets yet
                </h3>
                <p className="text-gray-600 mb-4">
                  Get started by creating your first ticket
                </p>
                <button
                  className="btn-primary inline-flex items-center gap-2 px-4 py-2 bg-blue-600 hover:bg-blue-700 text-white font-medium rounded-lg transition-colors duration-200"
                  onClick={() => setOpenCreate(true)}
                >
                  Create Ticket
                </button>
              </div>
            ) : (
              tickets.map((ticket) => (
                <TicketCard
                  key={ticket.id}
                  ticket={ticket}
                  onEdit={setEditing}
                  onDelete={handleDelete}
                />
              ))
            )}
          </div>
        </div>

        {/* Create Modal */}
        <Modal
          open={openCreate}
          onClose={() => setOpenCreate(false)}
          title="Create ticket"
        >
          <form onSubmit={handleCreate} className="space-y-3">
            <label>
              Title
              <input
                value={form.title}
                onChange={(e) => setForm({ ...form, title: e.target.value })}
                className="input"
              />
            </label>
            {errors.title && (
              <div className="text-sm text-red-600">{errors.title}</div>
            )}
            <label>
              Status
              <select
                value={form.status}
                onChange={(e) =>
                  setForm({ ...form, status: e.target.value as any })
                }
                className="input"
              >
                <option value="open">open</option>
                <option value="in_progress">in_progress</option>
                <option value="closed">closed</option>
              </select>
            </label>
            {errors.status && (
              <div className="text-sm text-red-600">{errors.status}</div>
            )}
            <label>
              Description
              <textarea
                value={form.description}
                onChange={(e) =>
                  setForm({ ...form, description: e.target.value })
                }
                className="input h-24"
              />
            </label>
            <div className="flex gap-2">
              <button className="btn" type="submit">
                Create
              </button>
              <button
                type="button"
                className="btn-outline"
                onClick={() => setOpenCreate(false)}
              >
                Cancel
              </button>
            </div>
          </form>
        </Modal>

        {/* Edit Modal */}
        <Modal
          open={!!editing}
          onClose={() => setEditing(null)}
          title="Edit ticket"
        >
          {editing && (
            <form onSubmit={handleEditSubmit} className="space-y-3">
              <label>
                Title
                <input
                  value={editing.title}
                  onChange={(e) =>
                    setEditing({ ...editing, title: e.target.value })
                  }
                  className="input"
                />
              </label>
              {errors.title && (
                <div className="text-sm text-red-600">{errors.title}</div>
              )}
              <label>
                Status
                <select
                  value={editing.status}
                  onChange={(e) =>
                    setEditing({ ...editing, status: e.target.value as any })
                  }
                  className="input"
                >
                  <option value="open">open</option>
                  <option value="in_progress">in_progress</option>
                  <option value="closed">closed</option>
                </select>
              </label>
              {errors.status && (
                <div className="text-sm text-red-600">{errors.status}</div>
              )}
              <label>
                Description
                <textarea
                  value={editing.description}
                  onChange={(e) =>
                    setEditing({ ...editing, description: e.target.value })
                  }
                  className="input h-24"
                />
              </label>

              <div className="flex gap-2">
                <button className="btn" type="submit">
                  Save
                </button>
                <button
                  type="button"
                  className="btn-outline"
                  onClick={() => setEditing(null)}
                >
                  Cancel
                </button>
              </div>
            </form>
          )}
        </Modal>
      </main>
      <Footer />
    </div>
  );
};

export default Tickets;
