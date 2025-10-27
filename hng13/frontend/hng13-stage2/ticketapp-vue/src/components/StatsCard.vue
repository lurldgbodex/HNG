<template>
  <div
    class="bg-white rounded-xl shadow-sm border border-gray-200 p-6 hover:shadow-md transition-shadow duration-200"
  >
    <div class="flex items-center justify-between">
      <div>
        <p class="text-sm font-medium text-gray-600">{{ title }}</p>
        <p class="text-3xl font-bold text-gray-900 mt-2">{{ value }}</p>
      </div>
      <div
        :class="`w-12 h-12 bg-gradient-to-r ${gradient} rounded-lg flex items-center justify-center`"
      >
        <span class="text-white text-xl">{{ icon }}</span>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";

export default defineComponent({
  name: "StatsCard",
  props: {
    title: {
      type: String,
      required: true,
    },
    value: {
      type: Number,
      required: true,
    },
    icon: {
      type: String,
      required: true,
    },
    gradient: {
      type: String,
      required: true,
    },
  },
});
</script>
