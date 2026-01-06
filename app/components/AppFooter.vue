<script setup lang="ts">
const currentYear = new Date().getFullYear();
</script>

<template>
  <footer class="border-t bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60">
    <div class="flex h-14 items-center px-4">
      <div class="text-sm text-muted-foreground">
        &copy; {{ currentYear }} Ringan Data. All rights reserved.
      </div>
      <div class="ml-auto flex items-center gap-4 text-sm text-muted-foreground">
        <a href="#" class="hover:text-foreground hover:underline">Terms</a>
        <a href="#" class="hover:text-foreground hover:underline">Privacy</a>
        <a href="#" class="hover:text-foreground hover:underline">Help</a>
        <span class="text-xs text-muted-foreground/50">v1.0.0</span>
      </div>
    </div>
  </footer>
</template>
