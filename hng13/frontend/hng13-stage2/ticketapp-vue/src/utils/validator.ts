import type { TicketStatus } from "../types";

export const isValidStaus = (status: string): status is TicketStatus => {
  return ["open", "in_progress", "closed"].includes(status);
};

export const validateTicketInput = (data: {
  title?: string;
  status?: string;
  description?: string;
}) => {
  const errors: Record<string, string> = {};

  if (!data.title || data.title.trim() === "") {
    errors.title = "Title is required.";
  } else if (data.title.length > 120) {
    errors.title = "Title must be at most 120 characters.";
  }

  if (!data.status) errors.status = "Status is required.";
  else if (!isValidStaus(data.status))
    errors.status =
      "status must be one of: 'open', 'in_progress', or 'closed'.";
  if (data.description && data.description.length > 500) {
    errors.description = "Description is too long (max 500 characters).";
  }

  return errors;
};
