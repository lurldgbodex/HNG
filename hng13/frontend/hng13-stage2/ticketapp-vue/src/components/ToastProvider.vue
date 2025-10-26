<template>
  <div>
    <slot />
    <div
      aria-live="polite"
      class="fixed right-4 bottom-4 z-50 flex flex-col gap-2"
    >
      <div
        v-for="t in toasts"
        :key="t.id"
        :class="['p-3 rounded shadow-lg max-w-xs', toastClass(t.type)]"
      >
        {{ t.message }}
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import { toastStore } from "../composables/useToast"; // Adjust path as needed

export default defineComponent({
  setup() {
    return {
      toasts: toastStore.toasts,
      toastClass(type: "success" | "error" | "info") {
        return type === "success"
          ? "bg-green-600 text-white"
          : type === "error"
          ? "bg-red-600 text-white"
          : "bg-blue-600 text-white";
      },
    };
  },
});
</script>
