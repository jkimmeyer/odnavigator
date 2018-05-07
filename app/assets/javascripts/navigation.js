function initSearch(){
  search.onAdd = function (mapid) {
    this._input = L.DomUtil.create('input', 'search'); // create a input field with a class "search"
    this.update();
    return this._input;
  };

  search.update = function (props) {
    this._input.placeholder = 'Suche';
  };
  search.addTo(mapid);
}

function initInfoBox(){
  //Infobox for the upper right corner
  info.onAdd = function (mapid) {
      this._div = L.DomUtil.create('div', 'info'); // create a div with a class "info"
      this.update();
      return this._div;
  };

  // method that we will use to update the control based on feature properties passed
  info.update = function (props) {
      this._div.innerHTML = '<h4>Metrikwert</h4>' +  (props ?
          '<b>' + props.GEN + '</b><br />' + datasetValues[props.GEN] + ' %'
          : 'Hover over a state');
  };

  info.addTo(mapid);
}
