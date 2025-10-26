export type TicketStatus = "open" | "in_progress" | "closed";

export interface Ticket {
  id: string;
  title: string;
  description?: string;
  priority: "low" | "medium" | "high";
  status: TicketStatus;
  createdAt: string;
  updatedAt?: string;
}

export interface Session {
  token: string;
  username: string;
  createdAt: string;
}
