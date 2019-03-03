import places from 'places.js';

const initAutocomplete = () => {
  const locations = document.querySelectorAll('.race_checkpoints_location');
  const checkpoints = document.getElementById('checkpoints');

  if (locations) {
    locations.forEach(location => places({ container: location.querySelector('input') }));
  }

  const config = { attributes: true, childList: true, subtree: true };

  const callback = function(mutationsList, observer) {
      for(let mutation of mutationsList) {
          if (mutation.type == 'childList') {
            const node = mutation.addedNodes[0] //.querySelector('input');

            if (node !== undefined && node.tagName === 'DIV') {
              const input = node.querySelector('input');

              if (input) {
                places({ container: input })
              }
            }
          }
      }
  };

  const observer = new MutationObserver(callback);

  if (checkpoints) observer.observe(checkpoints, config);
};

export { initAutocomplete };
