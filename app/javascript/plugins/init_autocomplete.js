import places from 'places.js';

const initAutocomplete = () => {
  const addressInput = document.getElementById('search-bar');
  const searchButton = document.getElementById('search-button');
  const searchCoords = document.getElementById('search-coords');
  if (addressInput) {
    const autocomplete = places({
      container: addressInput
    });
    autocomplete.on('change', (e) =>{
      const coords = e.suggestion.latlng;
      searchCoords.value = `${coords.lat}-${coords.lng}`;
    });
  }
};

export { initAutocomplete };
