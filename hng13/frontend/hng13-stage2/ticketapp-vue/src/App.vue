<template>
  <ToastProvider>
    <router-view />
  </ToastProvider>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import ToastProvider from "./components/ToastProvider.vue";
export default defineComponent({ components: { ToastProvider } });
</script>
