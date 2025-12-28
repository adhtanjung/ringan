<template>
  <div class="min-h-screen bg-gray-50 overflow-x-hidden w-full">
    <!-- Main Container -->
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-2 sm:py-3 lg:py-4 w-full">
      <!-- Dataset Table Container -->
      <div class="mt-6">
        <DatasetTable
          :title="dataTypeLabel"
          :data="data"
          :columns="columns"
          :loading="loading"
          :error="error"
          :pagination="pagination"
          :current-page="currentPage"
          :total-pages="totalPages"
          :search-query="searchQuery"
          :filters="filters"
          @create="openCreateModal"
          @edit="openEditModal"
          @delete="deleteItem"
          @bulk-delete="bulkDeleteItems"
          @refresh="refreshData"
          @import="openImportModal"
          @export="openExportModal"
          @page-change="goToPage"
          @page-size-change="changePageSize"
          @next-page="nextPage"
          @prev-page="prevPage"
          @search-change="(value) => searchQuery = value"
          @filter-change="setFilter"
          @clear-filters="clearFilters"
        />
      </div>
    </div>

    <!-- Import Modal -->
    <ImportModal
      :is-open="showImportModal"
      :data-type="'suggestions'"
      @close="closeImportModal"
      @import-success="handleImportSuccess"
    />

    <!-- Export Modal -->
    <ExportModal
      :is-open="showExportModal"
      :data-type="'suggestions'"
      @close="closeExportModal"
    />

    <!-- Edit Modal -->
    <DatasetEditModalShadcn
      :is-open="showEditModal"
      :data-type="'suggestions'"
      :item="editingItem"
      :loading="actionLoading"
      @close="closeEditModal"
      @save="handleSave"
    />

    <!-- Toast Notifications -->
    <Toaster />
  </div>
</template>

<script setup>
import { onMounted } from 'vue'

// Components
import DatasetTable from '@/components/admin/DatasetTable.vue'
import ImportModal from '@/components/admin/ImportModal.vue'
import ExportModal from '@/components/admin/ExportModal.vue'
import DatasetEditModalShadcn from '@/components/admin/DatasetEditModalShadcn.vue'

// shadcn-vue components
import { Toaster } from '@/components/ui/toast'

// Use the shared composable
const {
  loading,
  error,
  data,
  actionLoading,
  showImportModal,
  showExportModal,
  showEditModal,
  editingItem,
  pagination,
  columns,
  dataTypeLabel,
  currentPage,
  totalPages,
  searchQuery,
  filters,
  refreshData,
  openCreateModal,
  openEditModal,
  closeEditModal,
  handleSave,
  deleteItem,
  bulkDeleteItems,
  openImportModal,
  closeImportModal,
  openExportModal,
  closeExportModal,
  handleImportSuccess,
  goToPage,
  changePageSize,
  nextPage,
  prevPage,
  setFilter,
  clearFilters
} = useDatasetManagement('suggestions')

// Lifecycle
onMounted(() => {
  refreshData()
})
</script>
