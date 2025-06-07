import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'Weather.dart';

final _cityInputBox = TextEditingController();


class SetupPage extends StatelessWidget {
  const SetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Weather App',
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(), // Empty top spacer
              // Center section: search input
              SearchBox(context),
              // Bottom section: footer text
              const Padding(
                padding: EdgeInsets.only(bottom: 24),
                child: Text(
                  "This app was built by Prottoy Roy while learning Flutter's input system, UI design, and API integration.",
                  style: TextStyle(color: Colors.black45, fontSize: 11),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget SearchBox(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.white10, blurRadius: 20, spreadRadius: 0),
            ],
          ),
          child: TextField(
            controller: _cityInputBox,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 16,
              ),
              prefixIcon: Icon(
                Icons.location_city,
                color: Colors.grey.shade600,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.black, width: 1.5),
              ),
              hintText: 'Enter your city',
              hintStyle: TextStyle(color: Colors.grey.shade500),
            ),
          ),
        ),
        const SizedBox(height: 20),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () async {
            final city = _cityInputBox.text.trim();

            if (city.isEmpty) return;
            print('Loaded API key: ${dotenv.env['WEATHER_API_KEY']}');
            final apiKey = dotenv.env['WEATHER_API_KEY'];
            final reqUrl =
                'http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$city';

            try {
              final respUrl = await http.get(Uri.parse(reqUrl));

              if (respUrl.statusCode == 200) {
                final data = json.decode(respUrl.body);

                final cityName = data['location']['name'] + ', ' + data['location']['country'];
                final temperatureC = data['current']['temp_c'];
                final weatherType = data['current']['condition']['text'];
                final feelsLike = data['current']['feelslike_c'].toDouble();
                final uv = data['current']['uv'];
                final wind_dir =  '${data['current']['wind_kph']} KpH at ${data['current']['wind_dir']}';
                final humidity = data['current']['humidity'].toDouble();
                final latitude = data['location']['lat'];
                final longitude = data['location']['lon'];

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WeatherPage(
                      cityName: cityName,
                      temperatureC: temperatureC,
                      weatherType: weatherType,
                      feelsLike: feelsLike,
                      uv: uv,
                      wind_dir: wind_dir,
                      humidity: humidity,
                      latitude: latitude,
                      longitude: longitude,
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Couldnt Find City"),
                    duration: Duration(seconds: 2), 
                  )
                );
              }
            } catch (e) {
              print('Error in API method\n$e');
            }
          },
          child: const Text(
            "Search City",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
