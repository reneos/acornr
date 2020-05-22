import mapboxgl from 'mapbox-gl';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';



const buildMap = (mapElement) => {
  mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
  const newMap = new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/mapbox/streets-v10',
  });
  return newMap;
};


const addMarkersToMap = (map, markers) => {
  markers.forEach((marker) => {
    const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);
    new mapboxgl.Marker({color:"#1f473f"})
      .setLngLat([ marker.lng, marker.lat ])
      .setPopup(popup)
      .addTo(map);
  });
};

const fitMapToMarkers = (map, markers) => {
  if (markers.length === 1) {
    map.flyTo( { center: [markers[0].lng, markers[0].lat], zoom: 15, speed: 3 } );
  } else {
    const bounds = new mapboxgl.LngLatBounds();
    markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
    map.fitBounds(bounds, { padding: 70, maxZoom: 15 });
  }
};

const initMapbox = () => {
  const mapElement = document.getElementById('map');
  if (mapElement) {
    const map = buildMap(mapElement);
    const markers = JSON.parse(mapElement.dataset.markers);
    if (markers.length > 0) {
      addMarkersToMap(map, markers);
      fitMapToMarkers(map, markers);
    }
    map.resize();
    map.addControl(new MapboxGeocoder({ accessToken: mapElement.dataset.mapboxApiKey,
                                mapboxgl: mapboxgl }));
    const list = document.querySelectorAll('.map-button');
    list.forEach((space) => {
      space.addEventListener('click',(e) => {
        e.preventDefault();
        const coords = e.currentTarget.dataset.coords.split(',').map((i) => parseFloat(i));
        map.flyTo({ center: coords, zoom: 15, speed: 2 });
      })
    });
  }
};


export { initMapbox };
