<script setup lang="ts">
import { ref, computed } from "vue";
import {
  CommandDialog,
  CommandEmpty,
  CommandGroup,
  CommandInput,
  CommandItem,
  CommandList,
  CommandSeparator,
} from "@/components/ui/command";
import { useRouter } from "vue-router";
import {
  LayoutDashboard,
  FileText,
  Settings,
  User,
  Search,
} from "lucide-vue-next";

const open = ref(false);
const router = useRouter();

// Define command groups
const mainNav = [
  {
    title: "Dashboard",
    url: "/dashboard",
    icon: LayoutDashboard,
  },
  {
    title: "Problems",
    url: "/problems",
    icon: FileText,
  },
  {
    title: "Problem Types",
    url: "/problem-types",
    icon: FileText,
  },
  {
    title: "Assessments",
    url: "/assessments",
    icon: FileText,
  },
];

const settingsNav = [
  {
    title: "Profile",
    url: "#",
    icon: User,
  },
  {
    title: "Settings",
    url: "#",
    icon: Settings,
  },
];

// Handle keyboard shortcut (Cmd+K)
const down = (e: KeyboardEvent) => {
  if (e.key === "k" && (e.metaKey || e.ctrlKey)) {
    e.preventDefault();
    open.value = !open.value;
  }
};

onMounted(() => {
  document.addEventListener("keydown", down);
});

onUnmounted(() => {
  document.removeEventListener("keydown", down);
});

const handleSelect = (url: string) => {
  router.push(url);
  open.value = false;
};
</script>

<template>
  <div>
    <!-- Trigger Button -->
    <button
      @click="open = true"
      class="inline-flex items-center gap-2 whitespace-nowrap rounded-md text-sm font-medium ring-offset-background transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 border border-input bg-background hover:bg-accent hover:text-accent-foreground h-9 px-4 py-2 relative w-full justify-start text-muted-foreground sm:pr-12 md:w-40 lg:w-64"
    >
      <span class="hidden lg:inline-flex">Search documentation...</span>
      <span class="inline-flex lg:hidden">Search...</span>
      <kbd
        class="pointer-events-none absolute right-1.5 top-1.5 hidden h-5 select-none items-center gap-1 rounded border bg-muted px-1.5 font-mono text-[10px] font-medium opacity-100 sm:flex"
      >
        <span class="text-xs">⌘</span>K
      </kbd>
    </button>

    <!-- Command Dialog -->
    <CommandDialog :open="open" @update:open="open = $event">
      <CommandInput placeholder="Type a command or search..." />
      <CommandList>
        <CommandEmpty>No results found.</CommandEmpty>
        <CommandGroup heading="Suggestions">
          <CommandItem
            v-for="item in mainNav"
            :key="item.url"
            :value="item.title"
            @select="handleSelect(item.url)"
          >
            <component :is="item.icon" class="mr-2 h-4 w-4" />
            <span>{{ item.title }}</span>
          </CommandItem>
        </CommandGroup>
        <CommandSeparator />
        <CommandGroup heading="Settings">
          <CommandItem
            v-for="item in settingsNav"
            :key="item.url"
            :value="item.title"
            @select="handleSelect(item.url)"
          >
            <component :is="item.icon" class="mr-2 h-4 w-4" />
            <span>{{ item.title }}</span>
          </CommandItem>
        </CommandGroup>
      </CommandList>
    </CommandDialog>
  </div>
</template>
