function generateMarkers(feature, layer){
  if (datasetValues[feature.properties.GEN]!= undefined) {
    var markerItem = L.divIcon({className: 'feature--marker ' + getColor(getDatasetValuesByName(feature.properties.GEN)), iconSize: [12, 12]});
    var featureMarker = L.marker(layer._bounds.getCenter(), {icon: markerItem});
    featureMarker.on('mouseover', function (e) {
      info.update(feature.properties);
    });
    markers.push(featureMarker);
  }
}
