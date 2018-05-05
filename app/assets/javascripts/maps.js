// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// = require leaflet
// = require jquery
// = require leaflet.markercluster
// = require helpers
// = require feature_actions

// Declare variables that are used in every context
var geojson;
var mapid;
var cityData = [];
var info = L.control();
var search = L.control();
var statesData;
var datasetValues = {};
var markers = {};

function style(feature) {
    return {
        fillColor: getColor(Math.random()*101),// getColor(getDatasetValuesByName(feature.properties.GEN)),
        weight: 1,
        color: '#000',
        opacity: 0.4,
        fillOpacity: 0
    };
}

// Send ajax request to the server and render the data again.
function switchCategory(){
  geojson.remove(geojson);
  var category = $("#category :selected").text();
  $.ajax("category/" + category, {
  contentType: 'application/json',
  dataType: 'json',
  success:function(result){
    datasetValues = result.city_values;
    geojson = L.geoJson(cityData, {
      style: style,
      onEachFeature: onEachCityFeature
    }).addTo(mapid);
    }
  });
}

// Send ajax request to the server to call Get categories.
function requestCategory(){
  $.ajax("request_categories/", {
  contentType: 'text/plain',
  success:function(result){
    console.log("Asking for request");
  }
  });
}

//Send ajax request to load the data for the citys of the federal_state.
// function zoomToFeature(e){
//   var id = e.target.feature.properties.RS;
//   $.ajax(id, {
//   contentType: 'application/json',
//   dataType: 'json',
//   success:function(result){
//     geojson.remove(e.target);
//     cityData = result.feature_collection;
//     datasetValues = result.city_values;
//     geojson = L.geoJson(cityData, {
//       style: style,
//       onEachFeature: onEachCityFeature
//     }).addTo(mapid);
//     mapid.fitBounds(e.target.getBounds());
//   }
// });
// }

$(document).on('turbolinks:load',  function (){
  //Use the passed data.
  cityData = $('.city-data').data('cities');
  datasetValues =  $('.city-data').data('city-values');
  //Click Listener to filter for category
  $('#switch-category').click(function (){
    switchCategory();
  });
  $('#request-categories').click(function (){
    requestCategory();
  });
  //Access Token for Mapbox(mapbox.de)
  var mapboxAccessToken = "pk.eyJ1IjoiamtpbW1leWVyIiwiYSI6ImNqYTQ1ODFhbmEwangzM3M0N3F5MnI2MzAifQ.Cioxdl3kozpPOKAL9vxMQA";
  mapid = L.map('mapid').setView([52, 10], 6);
  L.tileLayer('https://api.mapbox.com/styles/v1/jkimmeyer/cjgj1zk8k00602rs2j6rh1rxu/tiles/256/{z}/{x}/{y}?access_token=' + mapboxAccessToken, {
        attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
        maxZoom: 18,
        minZoom: 6,
        id: 'mapbox.streets',
        accessToken: mapboxAccessToken
  }).addTo(mapid);

  var markers = L.

  geojson = L.geoJson(cityData, {
    style: style,
    onEachFeature:
      function (feature, layer) {
        onEachFeature(feature, layer);
        var markerItem = L.divIcon({className: 'feature--marker ' + getColor(Math.random()*101), iconSize: [10, 10]})
        var featureMarker = L.marker(layer._bounds.getCenter(), {icon: markerItem});
        featureMarker.addTo(mapid);
       }
  }).addTo(mapid);

  search.onAdd = function (mapid) {
      this._input = L.DomUtil.create('input', 'search'); // create a input field with a class "search"
      this.update();
      return this._input;
  };

  search.update = function (props) {
    this._input.placeholder = 'Suche';
  };

  search.addTo(mapid);

  //Infobox for the upper right corner
  info.onAdd = function (mapid) {
      this._div = L.DomUtil.create('div', 'info'); // create a div with a class "info"
      this.update();
      return this._div;
  };

  // method that we will use to update the control based on feature properties passed
  info.update = function (props) {
      this._div.innerHTML = '<h4>Bevölkerung</h4>' +  (props ?
          '<b>' + props.GEN + '</b><br />' + props.destatis.population + ' Einwohner'
          : 'Hover over a state');
  };

  info.addTo(mapid);
});
