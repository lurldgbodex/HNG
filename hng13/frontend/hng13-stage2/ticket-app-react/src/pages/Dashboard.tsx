import Footer from "../componenets/Footer";
import Header from "../componenets/Header";
import { useLocalState } from "../hooks/useLocalStorage";
import type { Ticket } from "../types";

const Dashboard = () => {
  const [tickets] = useLocalState<Ticket[]>("ticketapp_tickets", []);

  // Fixed the assignment bug in the filter
  const total = tickets.length;
  const open = tickets.filter((t) => t.status === "open").length;
  const inProgress = tickets.filter((t) => t.status === "in_progress").length;
  const resolved = tickets.filter((t) => t.status === "closed").length;

  // Priority counts
  const highPriority = tickets.filter((t) => t.priority === "high").length;
  const mediumPriority = tickets.filter((t) => t.priority === "medium").length;
  const lowPriority = tickets.filter((t) => t.priority === "low").length;

  // Recent tickets (last 5)
  const recentTickets = tickets.slice(0, 5);

  // Calculate resolution rate
  const resolutionRate = total > 0 ? Math.round((resolved / total) * 100) : 0;

  return (
    <div className="min-h-screen flex flex-col bg-gray-50">
      <Header />
      <main className="flex-1 max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        {/* Header Section */}
        <div className="mb-8">
          <h1 className="text-3xl font-bold text-gray-900">Dashboard</h1>
          <p className="text-gray-600 mt-2">
            Overview of your ticket management system
          </p>
        </div>

        {/* Key Metrics Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
          {/* Total Tickets Card */}
          <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-6 hover:shadow-md transition-shadow duration-200">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm font-medium text-gray-600">
                  Total Tickets
                </p>
                <p className="text-3xl font-bold text-gray-900 mt-2">{total}</p>
              </div>
              <div className="w-12 h-12 bg-gradient-to-r from-blue-500 to-blue-600 rounded-lg flex items-center justify-center">
                <span className="text-white text-xl">📊</span>
              </div>
            </div>
            <div className="mt-4">
              <div className="flex items-center text-sm text-gray-600">
                <span>All time tickets</span>
              </div>
            </div>
          </div>

          {/* Open Tickets Card */}
          <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-6 hover:shadow-md transition-shadow duration-200">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm font-medium text-gray-600">
                  Open Tickets
                </p>
                <p className="text-3xl font-bold text-gray-900 mt-2">{open}</p>
              </div>
              <div className="w-12 h-12 bg-gradient-to-r from-red-500 to-red-600 rounded-lg flex items-center justify-center">
                <span className="text-white text-xl">🔴</span>
              </div>
            </div>
            <div className="mt-4">
              <div className="flex items-center text-sm text-gray-600">
                <span>Requiring attention</span>
              </div>
            </div>
          </div>

          {/* In Progress Card */}
          <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-6 hover:shadow-md transition-shadow duration-200">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm font-medium text-gray-600">In Progress</p>
                <p className="text-3xl font-bold text-gray-900 mt-2">
                  {inProgress}
                </p>
              </div>
              <div className="w-12 h-12 bg-gradient-to-r from-yellow-500 to-yellow-600 rounded-lg flex items-center justify-center">
                <span className="text-white text-xl">🟡</span>
              </div>
            </div>
            <div className="mt-4">
              <div className="flex items-center text-sm text-gray-600">
                <span>Currently being worked on</span>
              </div>
            </div>
          </div>

          {/* Resolved Card */}
          <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-6 hover:shadow-md transition-shadow duration-200">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm font-medium text-gray-600">Resolved</p>
                <p className="text-3xl font-bold text-gray-900 mt-2">
                  {resolved}
                </p>
              </div>
              <div className="w-12 h-12 bg-gradient-to-r from-green-500 to-green-600 rounded-lg flex items-center justify-center">
                <span className="text-white text-xl">🟢</span>
              </div>
            </div>
            <div className="mt-4">
              <div className="flex items-center text-sm text-green-600 font-medium">
                <span>{resolutionRate}% resolution rate</span>
              </div>
            </div>
          </div>
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
          {/* Priority Overview */}
          <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
            <h3 className="text-lg font-semibold text-gray-900 mb-6">
              Priority Overview
            </h3>
            <div className="space-y-4">
              {/* High Priority */}
              <div className="flex items-center justify-between p-3 bg-red-50 rounded-lg border border-red-200">
                <div className="flex items-center gap-3">
                  <div className="w-3 h-3 bg-red-500 rounded-full"></div>
                  <span className="font-medium text-gray-900">
                    High Priority
                  </span>
                </div>
                <div className="flex items-center gap-2">
                  <span className="text-lg font-bold text-gray-900">
                    {highPriority}
                  </span>
                  <span className="text-sm text-gray-600">tickets</span>
                </div>
              </div>

              {/* Medium Priority */}
              <div className="flex items-center justify-between p-3 bg-yellow-50 rounded-lg border border-yellow-200">
                <div className="flex items-center gap-3">
                  <div className="w-3 h-3 bg-yellow-500 rounded-full"></div>
                  <span className="font-medium text-gray-900">
                    Medium Priority
                  </span>
                </div>
                <div className="flex items-center gap-2">
                  <span className="text-lg font-bold text-gray-900">
                    {mediumPriority}
                  </span>
                  <span className="text-sm text-gray-600">tickets</span>
                </div>
              </div>

              {/* Low Priority */}
              <div className="flex items-center justify-between p-3 bg-blue-50 rounded-lg border border-blue-200">
                <div className="flex items-center gap-3">
                  <div className="w-3 h-3 bg-blue-500 rounded-full"></div>
                  <span className="font-medium text-gray-900">
                    Low Priority
                  </span>
                </div>
                <div className="flex items-center gap-2">
                  <span className="text-lg font-bold text-gray-900">
                    {lowPriority}
                  </span>
                  <span className="text-sm text-gray-600">tickets</span>
                </div>
              </div>
            </div>
          </div>

          {/* Recent Activity */}
          <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
            <div className="flex items-center justify-between mb-6">
              <h3 className="text-lg font-semibold text-gray-900">
                Recent Tickets
              </h3>
              <span className="text-sm text-gray-600">
                {recentTickets.length} of {total}
              </span>
            </div>
            <div className="space-y-4">
              {recentTickets.length === 0 ? (
                <div className="text-center py-8 text-gray-500">
                  <svg
                    className="w-12 h-12 mx-auto mb-3 text-gray-400"
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
                  <p>No tickets yet</p>
                </div>
              ) : (
                recentTickets.map((ticket) => (
                  <div
                    key={ticket.id}
                    className="flex items-center justify-between p-3 hover:bg-gray-50 rounded-lg transition-colors duration-200"
                  >
                    <div className="flex items-center gap-3 min-w-0">
                      <div
                        className={`w-2 h-2 rounded-full ${
                          ticket.priority === "high"
                            ? "bg-red-500"
                            : ticket.priority === "medium"
                            ? "bg-yellow-500"
                            : "bg-blue-500"
                        }`}
                      ></div>
                      <div className="min-w-0 flex-1">
                        <p className="font-medium text-gray-900 truncate">
                          {ticket.title}
                        </p>
                        <p className="text-sm text-gray-600 capitalize">
                          {ticket.status.replace("_", " ")}
                        </p>
                      </div>
                    </div>
                    <div className="text-sm text-gray-500 whitespace-nowrap ml-4">
                      {new Date(ticket.createdAt).toLocaleDateString()}
                    </div>
                  </div>
                ))
              )}
            </div>
          </div>
        </div>

        {/* Quick Actions */}
        <div className="mt-8 bg-white rounded-xl shadow-sm border border-gray-200 p-6">
          <h3 className="text-lg font-semibold text-gray-900 mb-6">
            Quick Actions
          </h3>
          <div className="flex flex-col sm:flex-row gap-4">
            <a
              href="/tickets"
              className="inline-flex items-center justify-center px-6 py-3 bg-blue-600 hover:bg-blue-700 text-white font-semibold rounded-lg transition-colors duration-200 shadow-sm hover:shadow-md"
            >
              <svg
                className="w-5 h-5 mr-2"
                fill="none"
                stroke="currentColor"
                viewBox="0 0 24 24"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeWidth={2}
                  d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"
                />
              </svg>
              Manage All Tickets
            </a>
            <a
              href="/tickets?create=true"
              className="inline-flex items-center justify-center px-6 py-3 bg-green-600 hover:bg-green-700 text-white font-semibold rounded-lg transition-colors duration-200 shadow-sm hover:shadow-md"
            >
              <svg
                className="w-5 h-5 mr-2"
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
              Create New Ticket
            </a>
          </div>
        </div>

        {/* Stats Summary */}
        <div className="mt-8 grid grid-cols-1 md:grid-cols-3 gap-6">
          <div className="bg-gradient-to-r from-blue-500 to-blue-600 rounded-xl p-6 text-white">
            <div className="text-sm opacity-90">Avg. Resolution Time</div>
            <div className="text-2xl font-bold mt-2">-</div>
            <div className="text-sm opacity-90 mt-2">Data not tracked</div>
          </div>
          <div className="bg-gradient-to-r from-purple-500 to-purple-600 rounded-xl p-6 text-white">
            <div className="text-sm opacity-90">Customer Satisfaction</div>
            <div className="text-2xl font-bold mt-2">-</div>
            <div className="text-sm opacity-90 mt-2">Data not tracked</div>
          </div>
          <div className="bg-gradient-to-r from-gray-500 to-gray-600 rounded-xl p-6 text-white">
            <div className="text-sm opacity-90">Team Performance</div>
            <div className="text-2xl font-bold mt-2">-</div>
            <div className="text-sm opacity-90 mt-2">Data not tracked</div>
          </div>
        </div>
      </main>
      <Footer />
    </div>
  );
};

export default Dashboard;
