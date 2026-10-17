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
