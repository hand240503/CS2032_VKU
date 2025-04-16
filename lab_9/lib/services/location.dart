import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longitude;

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    try {
      // 1. Kiểm tra dịch vụ định vị có bật không
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print('Location services are disabled.');
        return;
      }

      // 2. Kiểm tra và xin quyền truy cập
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        print('Location permissions are permanently denied.');
        return;
      }

      // 3. Sử dụng LocationSettings thay vì desiredAccuracy
      LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.low, // có thể đổi sang high nếu cần độ chính xác cao
      );

      // 4. Lấy vị trí hiện tại
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );

      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print("Error getting location: $e");
    }
  }
}
