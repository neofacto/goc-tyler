var HttpClient = function () {
  this.get = function (aUrl, aCallback) {
    var anHttpRequest = new XMLHttpRequest();
    anHttpRequest.onreadystatechange = function () {
      if (anHttpRequest.readyState == 4 && anHttpRequest.status == 200)
        aCallback(anHttpRequest.responseText);
    }

    anHttpRequest.open("GET", aUrl, true);
    anHttpRequest.send(null);
  }
}

function AddMarkers() {
  var iconBase = 'https://maps.google.com/mapfiles/kml/shapes/';
  var icons = {
    parking: {
      icon: iconBase + 'parking_lot_maps.png'
    },
    library: {
      icon: iconBase + 'library_maps.png'
    },
    info: {
      icon: iconBase + 'info-i_maps.png'
    }
  };

  var client = new HttpClient();
  client.get('https://localhost:5001/api/year/1873', function (response) {
    // do something with response
    var obj = JSON.parse(response);
    var markers;

    
    obj.forEach(function(locality){
        var marker = new google.maps.Marker({
          position: new google.maps.LatLng(locality.latLL84,locality.lonLL84)
        });
        markers.push(marker);
    });
  });

  var features = [
    {
      position: new google.maps.LatLng(6.11611, 49.59962),
      type: 'info'
    }
  ];

  // Create markers.
  features.forEach(function (feature) {
    var marker = new google.maps.Marker({
      position: feature.position,
      icon: icons[feature.type].icon,
      map: map
    });
  });
}

function PositionMarkers(){
  var client = new HttpClient();
  client.get('https://localhost:5001/api/year/1873', function (response) {
    // do something with response
    var obj = JSON.parse(response);
  });
}
