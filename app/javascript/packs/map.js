let centerCoords = [4.899, 52.372]

mapboxgl.accessToken = 'pk.eyJ1IjoiZC1tdiIsImEiOiJjanNvYmdndTIwajNnM3lvNDl5ZG82aG8xIn0.N0NV8g7WfsBbJMcYlg7uvQ'
let map = new mapboxgl.Map({
  container: 'map',
  style: 'mapbox://styles/mapbox/dark-v9',
  zoom: 3,
  center: [centerCoords[0], centerCoords[1]]
});

let latlon = ''

let position = Object.new

const coordinates = pos => {
 position = {
    "geometry": {
      "type": "Point",
      "coordinates": [pos.coords.longitude, pos.coords.latitude]
    },
    "type": "Feature",
    "properties": {}
  }

}

navigator.geolocation.getCurrentPosition(coordinates)



setTimeout(() => {
  console.table(position.geometry.coordinates)
  map.on('load', function () {
    map.loadImage("https://res.cloudinary.com/diciu4xpu/image/upload/v1551278802/chaserz/marker.png", function (error, image) { //this is where we load the image file
      if (error) throw error;
      map.addImage("custom-marker", image); //this is where we name the image file we are loading
      map.addLayer({
        'id': "markers", //this is the name of the layer, it is what we will reference below
        'type': "symbol",
        'source': { //now we are adding the source to the layer more directly and cleanly
          type: "geojson",
          data: position // CHANGE THIS TO REFLECT WHERE YOUR DATA IS COMING FROM
        },
        'layout': {
          "icon-image": "custom-marker", // the name of image file we used above
          "icon-allow-overlap": false,
          "icon-size": 0.2 //this is a multiplier applied to the standard size. So if you want it half the size put ".5"
        }
      })
      map.flyTo({
        center: [
          position.geometry.coordinates[0],
          position.geometry.coordinates[1]],
          zoom: 18
      });
    })
  })


}, 1000)
