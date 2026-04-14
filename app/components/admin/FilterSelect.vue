<template>
  <DropdownMenu v-model:open="open">
    <DropdownMenuTrigger as-child>
      <button
        class="flex h-10 w-full min-w-0 items-center justify-between gap-2 rounded-md border border-input bg-background px-3 py-2 text-sm shadow-none ring-offset-background focus:outline-none focus:ring-2 focus:ring-ring focus:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50"
        :class="cn(modelValue && modelValue !== '__all__' ? 'border-primary/40' : '')"
      >
        <div class="flex items-center gap-2 overflow-hidden min-w-0">
          <component :is="icon" v-if="icon" class="h-4 w-4 shrink-0 text-muted-foreground" />
          <span class="truncate" :class="selectedLabel ? '' : 'text-muted-foreground'">
            {{ selectedLabel || placeholder }}
          </span>
        </div>
        <ChevronDown class="h-4 w-4 shrink-0 opacity-50" />
      </button>
    </DropdownMenuTrigger>
    <DropdownMenuContent
      class="p-0 w-[var(--reka-dropdown-menu-trigger-width)] min-w-[200px]"
      align="start"
      :side-offset="4"
    >
      <Command :filter-function="filterFn">
        <CommandInput :placeholder="`Search ${searchPlaceholder || placeholder}...`" :auto-focus="true" />
        <CommandList class="max-h-[220px]">
          <CommandEmpty>No results found.</CommandEmpty>
          <CommandItem
            value="__all__"
            @select="select(null)"
            class="cursor-pointer"
          >
            <Check v-if="!modelValue || modelValue === '__all__'" class="mr-2 h-4 w-4" />
            <span v-else class="mr-2 h-4 w-4 inline-block" />
            {{ allLabel }}
          </CommandItem>
          <CommandItem
            v-for="opt in options"
            :key="getKey(opt)"
            :value="getSearchValue(opt)"
            @select="select(getValue(opt))"
            class="cursor-pointer"
          >
            <Check v-if="modelValue === getValue(opt)" class="mr-2 h-4 w-4" />
            <span v-else class="mr-2 h-4 w-4 inline-block" />
            {{ getLabel(opt) }}
          </CommandItem>
        </CommandList>
      </Command>
    </DropdownMenuContent>
  </DropdownMenu>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { Check, ChevronDown } from 'lucide-vue-next'
import { cn } from '@/lib/utils'
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuTrigger,
} from '@/components/ui/dropdown-menu'
import {
  Command,
  CommandInput,
  CommandList,
  CommandEmpty,
  CommandItem,
} from '@/components/ui/command'

type Option = string | { id: string; name: string }

const props = withDefaults(defineProps<{
  modelValue?: string | null
  options: Option[]
  placeholder?: string
  allLabel?: string
  searchPlaceholder?: string
  icon?: any
}>(), {
  placeholder: 'Select...',
  allLabel: 'All',
})

const emit = defineEmits<{
  'update:modelValue': [value: string | null]
}>()

const open = ref(false)

const getKey = (opt: Option) => typeof opt === 'string' ? opt : opt.id
const getValue = (opt: Option) => typeof opt === 'string' ? opt : opt.id
const getLabel = (opt: Option) => typeof opt === 'string' ? opt : (opt.id === opt.name ? opt.id : `${opt.id} - ${opt.name}`)
const getSearchValue = (opt: Option) => typeof opt === 'string' ? opt : `${opt.id} ${opt.name}`

const selectedLabel = computed(() => {
  if (!props.modelValue || props.modelValue === '__all__') return ''
  const found = props.options.find((o) => getValue(o) === props.modelValue)
  return found ? getLabel(found) : props.modelValue
})

// Custom filter: reka-ui passes string[] of item values + search term
// We match against the value string directly (which includes id + name)
const filterFn = (itemValues: string[], search: string) => {
  if (!search) return itemValues
  const s = search.toLowerCase()
  return itemValues.filter((v) => v.toLowerCase().includes(s))
}

const select = (value: string | null) => {
  emit('update:modelValue', value)
  open.value = false
}
</script>
