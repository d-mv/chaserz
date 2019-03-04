
mapboxgl.accessToken = 'pk.eyJ1IjoiZXhhbXBsZXMiLCJhIjoiY2lqbmpqazdlMDBsdnRva284cWd3bm11byJ9.V6Hg2oYJwMAxeoR9GEzkAA';
var map = new mapboxgl.Map({
    container: 'map', // container id
    style: 'mapbox://styles/examples/cjgiiz9ck002j2ss5zur1vjji', // stylesheet location
    center: [-87.661557, 41.893748],
    zoom: 10.7
});

map.on('click', function(e) {
  var features = map.queryRenderedFeatures(e.point, {
    layers: ['chicago-parks'] // replace this with the name of the layer
  });

  if (!features.length) {
    return;
  }

  var feature = features[0];

  var popup = new mapboxgl.Popup({ offset: [0, -15] })
    .setLngLat(feature.geometry.coordinates)
    .setHTML('<h3>' + feature.properties.title + '</h3><p>' + feature.properties.description + '</p>')
    .setLngLat(feature.geometry.coordinates)
    .addTo(map);
});
