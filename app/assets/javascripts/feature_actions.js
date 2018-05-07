// This happens if you hover over a feature.
function highlightFeature(e) {
    var layer = e.target;
    layer.setStyle({
        weight: 3,
        color: '#CCCCCC',
        dashArray: '',
        fillOpacity: 0
    });

    if (!L.Browser.ie && !L.Browser.opera && !L.Browser.edge) {
        layer.bringToFront();
    }
    info.update(layer.feature.properties);
}

// this happens if you move out of the feature
function resetHighlight(e) {
    L.geojson.resetStyle(e.target);
    info.update();
}

//actions added to each feature
function onEachFeature(feature, layer) {
    layer.on({
        mouseover: highlightFeature,
        mouseout: resetHighlight,
        click:
        function(target){
          if ($('.details').children().length > 0) {
            hideDetails(target)
          } else {
            showDetails(target)
          }
        }
    });
}
