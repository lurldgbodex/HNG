import type { Session } from "../types";
import { lsGet, lsRemove, lsSet } from "../utils/storage";

const SESSION_KEY = "ticketapp_session";

export const getSession = (): Session | null => {
  return lsGet<Session>(SESSION_KEY);
};

export const createSession = (username: string) => {
  const token = Math.random().toString(36).substring(2);
  const session: Session = {
    token,
    username,
    createdAt: new Date().toISOString(),
  };
  lsSet(SESSION_KEY, session);
  return session;
};

export const clearSession = () => {
  lsRemove(SESSION_KEY);
};

export const isauthenticated = (): boolean => {
  return !!getSession();
};
