// V1.0

/* Reorders a list item and sends the new order to the server. */

// Moves the element at index `from` to index `to`, in place
function move(input, from, to) {
  let numberOfDeletedElm = 1;
  const elm = input.splice(from, numberOfDeletedElm)[0];
  numberOfDeletedElm = 0;
  input.splice(to, numberOfDeletedElm, elm);
  return input
}

// Persists the new item order via a POST request
function updateOrder(order, path) {
   const json = '{"items":' + JSON.stringify(order) + '}';
   fetch(path, {
         method: 'POST',
         body: json,
         headers: {
            'Content-type': 'application/json; charset=UTF-8'
         }
      }
   );
}

// Alpine component for the ArticleItems drag sort: reorder(item, position) is the x-sort handler
const registerArticleItemsSortable = () => {
   Alpine.data('articleItemsSortable', (config = {}) => ({
      editMode: config.editMode ?? true,
      items: config.items ?? [],

      reorder(item, position) {
         const index = this.items.findIndex((element) => element == item);
         const newArray = move(this.items, index, position);
         updateOrder(newArray, config.updatePath);
      },

      // Move buttons of the item menu. `reloadUrl` is optional; the current page is reloaded without it.
      moveUp(id, reloadUrl) {
         this.moveBy(id, -1, reloadUrl);
      },
      moveDown(id, reloadUrl) {
         this.moveBy(id, 1, reloadUrl);
      },
      moveToBeginning(id, reloadUrl) {
         this.moveTo(id, 0, reloadUrl);
      },
      moveToEnd(id, reloadUrl) {
         this.moveTo(id, this.items.length - 1, reloadUrl);
      },
      moveBy(id, offset, reloadUrl) {
         this.moveTo(id, this.items.findIndex((element) => element == id) + offset, reloadUrl);
      },
      moveTo(id, position, reloadUrl) {
         const index = this.items.findIndex((element) => element == id);
         const newArray = move(this.items, index, position);
         updateOrder(newArray, config.updatePath);
         setTimeout(() => this.reload(reloadUrl), 500);
      },
      // `url` is the toggle status endpoint of the item, a POST request
      toggleStatus(url, reloadUrl) {
         fetch(url, { method: 'POST' }).then((response) => {
            if (response.ok) this.reload(reloadUrl);
         });
      },
      reload(reloadUrl) {
         if (reloadUrl) {
            location.href = reloadUrl;
         } else {
            location.reload();
         }
      }
   }));
};

if (window.Alpine) {
   registerArticleItemsSortable();
} else {
   document.addEventListener('alpine:init', registerArticleItemsSortable);
}
