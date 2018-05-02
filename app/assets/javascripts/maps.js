// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// = require leaflet
// = require jquery
// = require leaflet.markercluster

// Declare variables that are used in every context
var geojson;
var mapid;
var cityData = [];
var info = L.control();
var statesData;
var datasetValues = {};
var markers = {};

var geojsonMarkerOptions = {
    radius: 8,
    fillColor: "#ff7800",
    color: "#000",
    weight: 1,
    opacity: 1,
    fillOpacity: 1
};

//Method that returns color based on percentage
function getColor(d) {
    return  d >    98 ?  '#4169E1' :
            d >    90 ?  '#546FCB' :
            d >    80 ?  '#6775B4' :
            d >    70 ?  '#7A7B9E' :
            d >    60 ?  '#8D8187' :
            d >    50 ?  '#A08771' :
            d >    40 ?  '#B38D5A' :
            d >    30 ?  '#C69344' :
            d >    20 ?  '#D9992D' :
            d >    10 ?  '#EC9F17' :
            d >     0 ?  '#FFA500' :
                         '#e7e7e7';
}

// Returns metric of category according to the name
function getDatasetValuesByName(name) {
  name = name.replace(/\(.*\)/g, '').trim();
  return datasetValues[name];
}

//Styles for a feature
function style(feature) {
    return {
        fillColor: getColor(Math.random()*101),// getColor(getDatasetValuesByName(feature.properties.GEN)),
        weight: 1,
        color: '#CCCCCC',
        opacity: 1,
        fillOpacity: 1
    };
}

// This happens if you hover over a feature.
function highlightFeature(e) {
    var layer = e.target;

    layer.setStyle({
        weight: 3,
        color: '#CCCCCC',
        dashArray: '',
        fillOpacity: 0.7
    });

    if (!L.Browser.ie && !L.Browser.opera && !L.Browser.edge) {
        layer.bringToFront();
    }
    info.update(layer.feature.properties);
}

// this happens if you move out of the feature
function resetHighlight(e) {
    geojson.resetStyle(e.target);
    info.update();
}

//actions added to all federal_state features
function onEachFeature(feature, layer) {
    layer.on({
        mouseover: highlightFeature,
        mouseout: resetHighlight,
        click: zoomToFeature
    });
}

//zooms back to federal_state layer
function zoomOut(e) {
    geojson.remove(e.target);
    geojson = L.geoJson(statesData, {
      style: style,
      onEachFeature: onEachFeature
    }).addTo(mapid);
    mapid.fitBounds(geojson.getBounds());
}

// actions added to all city features
function onEachCityFeature(feature, layer) {
  layer.on({
    mouseover: highlightFeature,
    mouseout: resetHighlight,
    click: zoomOut
  });
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
function zoomToFeature(e){
  var id = e.target.feature.properties.RS;
  $.ajax(id, {
  contentType: 'application/json',
  dataType: 'json',
  success:function(result){
    geojson.remove(e.target);
    cityData = result.feature_collection;
    datasetValues = result.city_values;
    geojson = L.geoJson(cityData, {
      style: style,
      onEachFeature: onEachCityFeature
    }).addTo(mapid);
    mapid.fitBounds(e.target.getBounds());
  }
});
}

$(document).on('turbolinks:load',  function (){
  //Use the passed data.
  statesData = $('.federalState-data').data('federal-states');
  datasetValues =  $('.federalState-data').data('values');
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
        id: 'mapbox.streets',
        accessToken: mapboxAccessToken
  }).addTo(mapid);

  var markers = L.

  geojson = L.geoJson(statesData, {
    style: style,
    onEachFeature: onEachFeature,
    // function (feature, layer) {
    //   var markerItem = L.divIcon({className: 'feature--marker', iconSize: [10, 10]})
    //   var featureMarker = L.marker(layer._bounds.getCenter(), {icon: markerItem});
    //   featureMarker.addTo(mapid);
    //  }
  }).addTo(mapid);

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
