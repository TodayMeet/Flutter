class LocationLatLng {
  LocationLatLng({required this.latitude, required this.longitude});

  final double latitude;
  final double longitude;
}

class Markers {
  Markers({required this.time, required this.categoryName, required this.personClose,
    required this.location, required this.meetNo});

  final String time;
  final String categoryName;
  final int personClose;
  final LocationLatLng location;
  final int meetNo;
}

class Address {
  Address({required this.address, required this.latitude, required this.longitude});

  final String address;
  final double latitude;
  final double longitude;
}