import { ref, watch } from "vue";
import { lsSet } from "../utils/storage";

export function useLocalState<T>(key: string, defaultValue: T) {
  const storedValue = localStorage.getItem(key);
  const state = ref<T>(
    storedValue ? JSON.parse(storedValue) : defaultValue
  ) as any;
  watch(
    state,
    (newValue) => {
      lsSet(key, JSON.stringify(newValue));
    },
    { deep: true }
  );
  return state as { value: T };
}
