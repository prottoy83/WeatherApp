import 'package:flutter/material.dart';

class WeatherPage extends StatelessWidget {
  final String cityName;
  final double temperatureC;
  final String weatherType;
  final double feelsLike;
  final double uv;
  final String wind_dir;
  final double humidity;
  final double latitude;
  final double longitude;

  const WeatherPage({
    super.key,
    required this.cityName,
    required this.temperatureC,
    required this.weatherType,
    required this.feelsLike,
    required this.uv,
    required this.wind_dir,
    required this.humidity,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          cityName,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black), 
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 20),

              
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$temperatureC°C',
                        style: const TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        weatherType,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Weather Details
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _weatherDetailItem('Feels Like', '$feelsLike'),
                      _weatherDetailItem('UV', '$uv'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _weatherDetailItem('Wind Direction', wind_dir),
                      _weatherDetailItem('Humidity', '$humidity'),
                    ],
                  ),
                ],
              ),

              // Latitude / Longitude
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Text(
                  'Lat: ${latitude.toStringAsFixed(4)}, Lon: ${longitude.toStringAsFixed(4)}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _weatherDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
