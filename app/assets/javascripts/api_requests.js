function displayMetric (metric) {
  featureMarkers.remove()
  var metric = $("#metric :selected").text();
  $.ajax("/api/data_portals/markers?metric=" + metric, {
    contentType: 'application/json',
    dataType: 'json',
    success:function(result){
      datasetValues = result
      geojson = L.geoJson(cityData, {
        style: style,
        onEachFeature: generateMarkers
      })
      featureMarkers = L.layerGroup(markers)
      featureMarkers.addTo(mapid)
    }
  });
}

function hideDetails(){
  $('.details').toggleClass("hide");
  $('.details').empty();
}

function showDetails(e){
  var city = e.target.feature.properties.GEN
  $.ajax("/api/data_portals/details?city=" + city, {
    contentType: 'application/json',
    dataType: 'json',
    success:function(result){
      $('.details').toggleClass("hide");
      $.each(result, function(key, value){
        $('.details').append('<p>' + key + ' : ' + value + '</p>')
      });
    }
  });
}
