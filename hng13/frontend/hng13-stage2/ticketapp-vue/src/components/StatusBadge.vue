<template>
  <span
    :class="`inline-flex items-center px-3 py-1 rounded-full text-xs font-medium border ${statusConfig.className}`"
  >
    {{ statusConfig.label }}
  </span>
</template>

<script lang="ts">
import { defineComponent, computed } from "vue";

export default defineComponent({
  name: "StatusBadge",
  props: {
    status: {
      type: String as () => "open" | "in_progress" | "closed",
      required: true,
    },
  },
  setup(props) {
    const statusConfig = computed(() => {
      const configs = {
        open: {
          label: "Open",
          className: "bg-red-100 text-red-800 border-red-200",
        },
        in_progress: {
          label: "In Progress",
          className: "bg-yellow-100 text-yellow-800 border-yellow-200",
        },
        closed: {
          label: "Closed",
          className: "bg-green-100 text-green-800 border-green-200",
        },
      };
      return configs[props.status];
    });

    return {
      statusConfig,
    };
  },
});
</script>
