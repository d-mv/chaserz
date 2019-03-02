const mapElement = document.getElementById('map');
mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;

const myStart = [34.7681902, 32.0765364]
const myEnd = [34.769217, 32.079145]

const map = new mapboxgl.Map({
  container: 'map',
  style: 'mapbox://styles/mapbox/streets-v10',
  center: myStart, // starting position
  zoom: 18
});
console.log('1. map is done')

// set the bounds of the map
// var bounds = [[myStart[0] + 0.1, myStart[1] + 0.1], [myEnd[0]+0.1, myEnd[1]+0.1]];
// map.setMaxBounds(bounds);

// create a function to make a directions request
function getRoute(end) {
  // make a directions request using cycling profile
  const url = 'https://api.mapbox.com/directions/v5/mapbox/cycling/' + myStart[0] + ',' + myStart[1] + ';' + end[0] + ',' + end[1] + '?steps=true&geometries=geojson&access_token=' + mapboxgl.accessToken;
  console.log(url)
  console.log('3. url is set')

  // make an XHR request https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest
  // var req = new XMLHttpRequest();
  // req.responseType = 'json';
  // console.log(req)
  // req.open('GET', url, true);
  // console.log(req)

  // let responseJson = ''
  fetch(url)
    .then(response => response.json())
    .then((data)=>{

      var data1 = data.routes[0];
      console.log('data is set')

      var route = data1.geometry.coordinates;
      console.log(route)
      var geojson = {
        type: 'Feature',
        properties: {},
        geometry: {
          type: 'LineString',
          coordinates: route
        }
      };



  // console.log(responseJson)
  // responseJson.onload = function () {
  // req.onload = function () {
    // var data = req.response.routes[0];

    // if the route already exists on the map, reset it using setData
    // if (map.getSource('route')) {
    //   map.getSource('route').setData(geojson);
    // } else { // otherwise, make a new request
      map.addLayer({
        id: 'route',
        type: 'line',
        source: {
          type: 'geojson',
          data: {
            type: 'Feature',
            properties: {},
            geometry: {
              type: 'LineString',
              coordinates: geojson
            }
          }
        },
        layout: {
          'line-join': 'round',
          'line-cap': 'round'
        },
        paint: {
          'line-color': '#3887be',
          'line-width': 5,
          'line-opacity': 0.75
        }
      });
    console.log('end of data func')


    // add turn instructions here at the end
    // get the sidebar and add the instructions
    var instructions = document.getElementById('instructions');
    var steps = data1.legs[0].steps;
    console.log('parsing instructions')

    var tripInstructions = [];
    for (var i = 0; i < steps.length; i++) {
      tripInstructions.push('<br><li>' + steps[i].maneuver.instruction) + '</li>';
      instructions.innerHTML = '<br><span class="duration">Trip duration: ' + Math.floor(data.duration / 60) + ' min 🚴 </span>' + tripInstructions;
      }
    })
}




map.on('load', function () {
  // getRoute(myEnd);
  map.addLayer({
    id: 'start',
    type: 'circle',
    source: {
      type: 'geojson',
      data: {
        type: 'FeatureCollection',
        features: [{
          type: 'Feature',
          properties: {},
          geometry: {
            type: 'Point',
            coordinates: myStart
          }
        }
        ]
      }
    },
    paint: {
      'circle-radius': 10,
      'circle-color': '#3887be'
    }
  });
  map.addLayer({
    id: 'end',
    type: 'circle',
    source: {
      type: 'geojson',
      data: {
        type: 'FeatureCollection',
        features: [{
          type: 'Feature',
          properties: {},
          geometry: {
            type: 'Point',
            coordinates: myEnd
          }
        }
        ]
      }
    },
    paint: {
      'circle-radius': 10,
      'circle-color': '#cf8900'
    }
  });
})
