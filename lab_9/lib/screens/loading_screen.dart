import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import 'location_screen.dart'; // nhớ tạo file này

class LoadingScreen extends StatefulWidget {
  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationAndWeather();
  }

  Future<void> getLocationAndWeather() async {
    try {
      // 1. Kiểm tra quyền truy cập vị trí
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print('Location services are disabled.');
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Permission denied');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        print('Permission denied forever');
        return;
      }

      // 2. Lấy vị trí
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      );

      double lat = position.latitude;
      double lon = position.longitude;
      print('Vị trí: $lat, $lon');

      // 3. Gọi API thời tiết
      const apiKey =
          'b86efc72297314b801f5322b82e07166'; // <== Đổi bằng API key của bạn
      final url =
          'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var weatherData = jsonDecode(response.body);

        // 4. Chuyển sang màn hình LocationScreen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LocationScreen(weatherData: weatherData),
          ),
        );
      } else {
        print('Lỗi khi lấy thời tiết: ${response.statusCode}');
      }
    } catch (e) {
      print('Lỗi: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
