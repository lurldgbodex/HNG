export function lsSet<T>(key: string, value: T): void {
  localStorage.setItem(key, JSON.stringify(value));
}

export function lsGet<T>(key: string): T | null {
  const item = localStorage.getItem(key);
  return item ? (JSON.parse(item) as T) : null;
}

export function lsRemove(key: string): void {
  localStorage.removeItem(key);
}

export function lsClear(): void {
  localStorage.clear();
}
