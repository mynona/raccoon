// V1.0

/* Alpine component: drag-and-drop file upload with preview and a FileList polyfill. */

// Guard against double registration if the script is included twice
if (!window.__fileUploadLoaded) {
  window.__fileUploadLoaded = true;

  // Polyfill helper scoped to this script module
  // Builds a FileList from an array of File objects (browsers don't allow constructing one directly)
  const createFileList = (function() {
    "use strict";
    var e = function() {
      return new DataTransfer();
    },
    t = Array.prototype.concat;
    try {
      e();
    } catch (t) {
      e = function() {
        return new ClipboardEvent("").clipboardData;
      };
    }
    return function() {
      for (var n = t.apply([], arguments), r = 0, o = n.length, i = e(); r < o; r++) i.items.add(n[r]);
      return i.files;
    };
  })();

  document.addEventListener('alpine:init', () => {
    // Component for single file upload
    Alpine.data('singleFileDnD', (inputId = 'fileUploadInput') => ({
      files: [],
      file: null,
      fileSize: '',
      fileName: '',
      isDragging: false,
      isFocused: false,
      hasServerError: false,
      inputId,
      // Clears the selected file and resets the underlying input
      remove(index) {
        this.files = createFileList([]);
        this.file = null;
        this.fileName = '';
        this.fileSize = '';
        this.hasServerError = false;
        const element = document.getElementById(this.inputId);
        if (element) element.value = '';
      },
      addFiles(e) {
        try {
          const targetFiles = e && e.target && e.target.files ? [...e.target.files] : [];
          if (targetFiles.length > 0) {
            const single = [targetFiles[0]];
            const files = createFileList(single);
            this.files = files;
            this.file = single[0];
            this.fileName = single[0].name;
            const size = single[0].size;
            if (size > 0) {
              const i = Math.floor(Math.log(size) / Math.log(1024));
              this.fileSize = (
                (size / Math.pow(1024, i)).toFixed(2) * 1 +
                " " +
                ["B", "kB", "MB", "GB", "TB"][i]
              );
            } else {
              this.fileSize = "0 B";
            }
            const element = document.getElementById(this.inputId);
            if (element) {
              element.files = files;
            }
          }
        } catch (err) {
          console.error('[singleFileDnD] Failed to add file:', err);
        }
      }
    }));

    // Component for multiple file upload
    Alpine.data('multipleFileDnD', (inputId = 'multipleFileUploadInput') => ({
      files: [],
      fileDragging: null,
      fileDropping: null,
      isDragging: false,
      isFocused: false,
      hasServerError: false,
      inputId,
      formatSize(bytes) {
        if (!bytes || bytes <= 0) return '0 B';
        const i = Math.floor(Math.log(bytes) / Math.log(1024));
        return (bytes / Math.pow(1024, i)).toFixed(2) * 1 + ' ' + ['B', 'kB', 'MB', 'GB', 'TB'][i];
      },
      remove(index) {
        const remaining = Array.from(this.files).filter((_, i) => i !== index);
        this.files = createFileList(remaining);
        const element = document.getElementById(this.inputId);
        if (element) {
          element.files = this.files;
          if (remaining.length === 0) {
            element.value = '';
          }
        }
      },
      addFiles(e) {
        try {
          const newFiles = e && e.target && e.target.files ? Array.from(e.target.files) : [];
          const existing = Array.from(this.files);
          const existingNames = new Set(existing.map(f => f.name));
          const toAdd = [];
          for (const file of newFiles) {
            if (!existingNames.has(file.name)) {
              existingNames.add(file.name);
              toAdd.push(file);
            }
          }
          const combined = createFileList(existing.concat(toAdd));
          this.files = combined;
          const element = document.getElementById(this.inputId);
          if (element) element.files = combined;
        } catch (err) {
          console.error('[multipleFileDnD] Failed to add files:', err);
        }
      }
    }));
  });
}
