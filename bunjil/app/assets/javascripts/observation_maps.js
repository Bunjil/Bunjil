function initialize() {
    var mapOptions = {
        center: new google.maps.LatLng(-37.822, 145.039),
        zoom: 8,
        mapTypeId: google.maps.MapTypeId.SATELLITE 
    };
    var left_map = new google.maps.Map(document.getElementById("left_map_canvas"), mapOptions);
    var right_map = new google.maps.Map(document.getElementById("right_map_canvas"), mapOptions);

    google.maps.event.addListener(left_map, 'center_changed', function() {
        right_map.panTo(left_map.getCenter());
    });
    google.maps.event.addListener(right_map, 'center_changed', function() {
        left_map.panTo(right_map.getCenter());
    });
    google.maps.event.addListener(left_map, 'idle', function() {
        right_map.setZoom(left_map.getZoom());
    });
    google.maps.event.addListener(right_map, 'idle', function() {
        left_map.setZoom(right_map.getZoom());
    });
    google.maps.event.addListener(right_map, 'click', function(event) {
        var marker = new google.maps.Marker({
            position: event.latLng,
            map: right_map
        });
        google.maps.event.addListener(marker, 'click', function() {
            marker.setMap(null);
        });
    });
}