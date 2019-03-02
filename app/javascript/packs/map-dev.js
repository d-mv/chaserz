// set up map API key
const mapElement = document.getElementById('map');
mapboxKey = mapElement.dataset.mapboxApiKey
console.log(mapboxKey)
mapboxgl.accessToken = mapboxKey;

// start/end coordinates
// TODO: inputs
const myStart = [34.842772, 32.167252]
const myEnd = [34.852847, 32.167941]
// const currentLocation = [34.768330, 32.077234]

// drawings map
const map = new mapboxgl.Map({
  container: 'map',
  style: 'mapbox://styles/mapbox/dark-v10',
  center: myStart, // @starting position
  zoom: 14 // TODO: Adjust
});
// to use touch later
var canvas = map.getCanvasContainer();

// TODO: calculate below, based on the start/end
// var bounds = [[parseFloat((myStart[0] + 0.1).toFixed(5)), parseFloat((myStart[1] - 0.1).toFixed(5))], [parseFloat((myEnd[0] - 0.1).toFixed(5)), parseFloat((myEnd[1] + 0.1).toFixed(5))]];
// console.log(bounds)
// map.setMaxBounds(bounds);

// form the request to API with start/end coordinates
const url = 'https://api.mapbox.com/directions/v5/mapbox/cycling/' + myStart[0] + ',' + myStart[1] + ';' + myEnd[0] + ',' + myEnd[1] + '?steps=true&geometries=geojson&access_token=' + mapboxgl.accessToken;
// request API
fetch(url)
  .then(response => response.json())
  .then((data) => {
    // choose routes section
    const routes = data.routes[0]
    // choose route instructions
    const instructions = document.getElementById('instructions');
    // choose route steps
    const steps = routes.legs[0].steps;
    // form instructions
    // var tripInstructions = [];
    // for (var i = 0; i < steps.length; i++) {
    //   // TODO: drop the last one/or add turn by turn navigation, based on the geoLocation
    //   tripInstructions.push('<br><li class="text t5 white">' + steps[i].maneuver.instruction) + '</li>';
    //   instructions.innerHTML = '<div class="map-instructions text t4 white">Instructions:</div><span class="duration text t6 accent">- race duration: ' + Math.floor(data.duration / 60) + ' min</span>' + tripInstructions + '<div class="map-divider"></div>';
    // }

    // form coordinates array for routes
    const coordinates = []
    routes.geometry.coordinates.forEach((waypoint) => {
      coordinates.push(waypoint)
    })
    // display the route
    map.on('load', function () {
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
              // TODO: change below to repsonse from API
              "coordinates": routes.geometry.coordinates
            }
          }
        },
        "layout": {
          "line-join": "round",
          "line-cap": "round"
        },
        "paint": {
          "line-color": "#FFC700",
          "line-width": 6
        }
      })
      // display start point
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
          'circle-color': '#13a513'
        }
      })
      // display end point
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
          'circle-color': '#ff0000'
        }
      });
      // TODO: add layer with current locations of others
      // show my current location
      setInterval(() => {
        // process
        navigator.geolocation.getCurrentPosition((coordinates) => {
          // form GeoJson for current location
          let positionJson = {
            "geometry": {
              "type": "Point",
              "coordinates": [coordinates.coords.longitude, coordinates.coords.latitude]
            },
            "type": "Feature",
            "properties": {}
          }
          // show on the map
          // check if exists and clear it
          if (map.getSource('markers')) {
            map.getSource('markers').setData(positionJson);
          }
          // or create new
          else {
            map.loadImage("https://res.cloudinary.com/diciu4xpu/image/upload/v1551461746/chaserz/marker_v2.png", function (error, image) { //this is where we load the image file
              if (error) throw error;
              map.addImage("custom-marker", image); //this is where we name the image file we are loading
              map.addLayer({
                'id': "markers", //this is the name of the layer, it is what we will reference below
                'type': "symbol",
                'source': { //now we are adding the source to the layer more directly and cleanly
                  type: "geojson",
                  data: positionJson // CHANGE THIS TO REFLECT WHERE YOUR DATA IS COMING FROM
                },
                'layout': {
                  "icon-image": "custom-marker", // the name of image file we used above
                  "icon-allow-overlap": false,
                  "icon-size": 0.2 //this is a multiplier applied to the standard size. So if you want it half the size put ".5"
                }
              })
            })
          }
        })
        // end of process
      }, 500);
    })
  })