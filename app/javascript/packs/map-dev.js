mapboxgl.accessToken = 'pk.eyJ1IjoiZC1tdiIsImEiOiJjanNvYmdndTIwajNnM3lvNDl5ZG82aG8xIn0.N0NV8g7WfsBbJMcYlg7uvQ'
// mylocation
const myCenter = [34.7681902, 32.0765364]

var map = new mapboxgl.Map({
  container: 'map', // container id
  style: 'mapbox://styles/mapbox/dark-v9', //stylesheet location
  center: myCenter, // starting position
  zoom: 18, // starting zoom
});

// set the bounds of the map
// var bounds = [[34.8, 32.1], [34.6, 31.9]];
// map.setMaxBounds(bounds);

// initialize the map canvas to interact with later
var canvas = map.getCanvasContainer();

// an arbitrary start will always be the same
// only the end or destination will change
var start = myCenter;

// create a function to make a directions request
function getRoute(end) {
  // make directions request using cycling profile
  var url = 'https://api.mapbox.com/directions/v5/mapbox/cycling/' + start[0] + ',' + start[1] + ';' + end[0] + ',' + end[1] + '?steps=true&geometries=geojson&access_token=' + mapboxgl.accessToken;

  // make an XHR request https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest
  var req = new XMLHttpRequest();
  req.responseType = 'json';
  req.open('GET', url, true);
  req.onload = function () {
    var data = req.response.routes[0];
    var route = data.geometry.coordinates;
    var geojson = {
      "type": "Feature",
      "properties": {},
      "geometry": {
        "type": "LineString",
        "coordinates": route
      }
    };
    // if the route already exists on the map, we'll reset it using setData
    if (map.getSource('route')) {
      map.getSource('route').setData(geojson);
    }
    // otherwise, we'll make a new request
    else {
      map.addLayer({
        "id": "route",
        "type": "line",
        "source": {
          "type": "geojson",
          "data": {
            "type": "Feature",
            "properties": {},
            "geometry": {
              "type": "LineString",
              "coordinates": geojson
            }
          }
        },
        "layout": {
          "line-join": "round",
          "line-cap": "round"
        },
        "paint": {
          "line-color": "#3887be",
          "line-width": 5,
          "line-opacity": 0.75
        }
      });
    };

    // get the sidebar and add the instructions
    var instructions = document.getElementById('instructions');
    var steps = data.legs[0].steps;

    var tripInstructions = [];
    for (var i = 0; i < steps.length; i++) {
      tripInstructions.push('<br><li>' + steps[i].maneuver.instruction) + '</li>';
      instructions.innerHTML = '<br><span class="duration">Trip duration: ' + Math.floor(data.duration / 60) + ' min 🚴 </span>' + tripInstructions;
    };
  };
  req.send();
};

map.on('load', function () {
  // make an initial directions request that
  // starts and ends at the same location
  getRoute(start);

  // Add destination to the map
  map.addLayer({
    "id": "point",
    "type": "circle",
    "source": {
      "type": "geojson",
      "data": {
        "type": "FeatureCollection",
        "features": [{
          "type": "Feature",
          "properties": {},
          "geometry": {
            "type": "Point",
            "coordinates": start
          }
        }
        ]
      }
    },
    "paint": {
      "circle-radius": 10,
      "circle-color": "#3887be"
    }
  });

  // allow the user to click the map to change the destination
  map.on('click', function (e) {
    var coordsObj = e.lngLat;
    canvas.style.cursor = '';
    var coords = Object.keys(coordsObj).map(function (key) { return coordsObj[key]; });
    var end = {
      "type": "FeatureCollection",
      "features": [{
        "type": "Feature",
        "properties": {},
        "geometry": {
          "type": "Point",
          "coordinates": coords
        }
      }
      ]
    };
    if (map.getLayer('end')) {
      map.getSource('end').setData(end);
    } else {
      map.addLayer({
        "id": "end",
        "type": "circle",
        "source": {
          "type": "geojson",
          "data": {
            "type": "FeatureCollection",
            "features": [{
              "type": "Feature",
              "properties": {},
              "geometry": {
                "type": "Point",
                "coordinates": coords
              }
            }
            ]
          }
        },
        "paint": {
          "circle-radius": 10,
          "circle-color": "#f30"
        }
      });
    };
    getRoute(coords);
  });
});