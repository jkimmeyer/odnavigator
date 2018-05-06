// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// = require leaflet
// = require jquery
// = require leaflet.markercluster
// = require helpers
// = require feature_actions
// = require api_requests
// = require navigation.js
// = require markers

// Declare variables that are used in every context
var geojson;
var mapid;
var cityData = [];
var info = L.control();
var search = L.control();
var statesData;
var datasetValues = {};
var markers = [];
var featureMarkers;

$(document).on('turbolinks:load',  function (){
  //Use the passed data.
  cityData = $('.city-data').data('cities');
  datasetValues =  $('.city-data').data('city-values');

  $('#metric').click(function(){
    displayMetric();
  })

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

  // Add initial feature marker.
  L.geojson = L.geoJson(cityData, {
    style: style,
    onEachFeature: function (feature, layer) {
      onEachFeature(feature, layer);
      generateMarkers(feature, layer);
    }
  }).addTo(mapid);
  featureMarkers = L.layerGroup(markers);
  featureMarkers.addTo(mapid);

  initSearch()
  initInfoBox()
});
