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
    L.geojson.resetStyle(e.target);
    info.update();
}

function showDetails(feature, layer){
  $('.details').toggleClass("hide");
}

//actions added to all federal_state features
function onEachFeature(feature, layer) {
    layer.on({
        mouseover: highlightFeature,
        mouseout: resetHighlight,
        click: showDetails
    });
}
