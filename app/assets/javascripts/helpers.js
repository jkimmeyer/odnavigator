//Method that returns color based on percentage
function getColor(d) {
    return  d >    98 ?  'blue--100--saturation' :
            d >    90 ?  'blue--90--saturation' :
            d >    80 ?  'blue--80--saturation' :
            d >    70 ?  'blue--70--saturation' :
            d >    60 ?  'blue--60--saturation' :
            d >    50 ?  'blue--50--saturation' :
            d >    40 ?  'blue--40--saturation' :
            d >    30 ?  'blue--30--saturation' :
            d >    20 ?  'blue--20--saturation' :
            d >    10 ?  'blue--10--saturation' :
            d >     0 ?  'blue--5--saturation' :
                         'white';
}

// Returns metric of category according to the name
function getDatasetValuesByName(name) {
  name = name.replace(/\(.*\)/g, '').trim();
  return datasetValues[name];
}
