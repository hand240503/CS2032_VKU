import 'package:flutter/material.dart';

class LocationScreen extends StatelessWidget {
  final dynamic weatherData;

  LocationScreen({required this.weatherData});

  @override
  Widget build(BuildContext context) {
    double temp = weatherData['main']['temp'];
    String city = weatherData['name'];
    String weather = weatherData['weather'][0]['main'];

    return Scaffold(
      appBar: AppBar(title: Text('Clima')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Nhiệt độ: $temp°C', style: TextStyle(fontSize: 24)),
            Text('Thời tiết: $weather', style: TextStyle(fontSize: 20)),
            Text('Thành phố: $city', style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
