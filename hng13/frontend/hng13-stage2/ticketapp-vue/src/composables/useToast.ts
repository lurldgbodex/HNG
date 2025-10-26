import { reactive } from "vue";

type Toast = {
  id: string;
  type: "success" | "error" | "info";
  message: string;
};

const store = reactive({ toasts: [] as Toast[] });

export function useToast() {
  function push(t: Omit<Toast, "id">) {
    const id = Math.random().toString(36).slice(2);
    store.toasts.push({ id, ...t });
    setTimeout(
      () => (store.toasts = store.toasts.filter((x) => x.id !== id)),
      4000
    );
  }
  return { push };
}

export const toastStore = store;
