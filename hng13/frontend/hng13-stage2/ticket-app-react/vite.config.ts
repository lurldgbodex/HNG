import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import tailwindcss from "@tailwindcss/vite";
import { resolve } from "path";
import fs from "fs";

// https://vite.dev/config/
export default defineConfig({
  build: {
    outDir: "dist",
  },
  define: {},
  esbuild: {},
  css: {},
  optimizeDeps: {},
  server: {},
  plugins: [
    react(),
    tailwindcss(),
    {
      name: "copy-redirects",
      closeBundle() {
        const src = resolve(__dirname, "public/_redirects");
        const dest = resolve(__dirname, "dist/_redirects");
        if (fs.existsSync(src)) {
          fs.copyFileSync(src, dest);
          console.log("Copied _redirects to dist folder");
        } else {
          console.warn("_redirects file does not exist in public folder");
        }
      },
    },
  ],
});
