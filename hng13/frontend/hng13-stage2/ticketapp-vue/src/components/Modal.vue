<template>
  <div v-if="open" class="fixed inset-0 z-40 flex items-center justify-center">
    <div class="absolute inset-0 bg-black opacity-40" @click="$emit('close')" />
    <div class="bg-white rounded-lg shadow-xl p-4 z-50 w-full max-w-md">
      <h3 v-if="$slots.title" class="font-semibold mb-2">
        <slot name="title" />
      </h3>
      <slot />
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
export default defineComponent({
  props: { open: { type: Boolean, default: false } },
});
</script>
