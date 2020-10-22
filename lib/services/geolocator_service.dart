import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeolocatorService {
  Future<Position> getInitialPosition() {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Stream<Position> getCurrentLocation() {
    return Geolocator.getPositionStream(
        desiredAccuracy: LocationAccuracy.high, distanceFilter: 10);
  }

  Future<double> getDistanceBetween(
      double startLat, double startLong, double endLat, double endLong) async {
    return Geolocator.distanceBetween(startLat, startLong, endLat, endLong);
  }

  void centerToPosition(
      GoogleMapController controller, LatLng pos, double zoom) async {
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: pos,
      zoom: zoom,
    )));
  }
}
