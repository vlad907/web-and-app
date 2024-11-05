import 'package:flutter/material.dart';
import 'weather_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService();
  final TextEditingController _cityController = TextEditingController();
  Map<String, dynamic>? _weatherData;
  String? _error;

  void _fetchWeather() async {
    final city = _cityController.text;
    if (city.isEmpty) return;

    final data = await _weatherService.fetchWeather(city);
    setState(() {
      if (data != null) {
        _weatherData = data;
        _error = null;
      } else {
        _error = 'Could not fetch weather data. Please try again.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Enter city',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _fetchWeather,
              child: Text('Get Weather'),
            ),
            SizedBox(height: 16.0),
            _error != null
                ? Text(
                    _error!,
                    style: TextStyle(color: Colors.red),
                  )
                : _weatherData != null
                    ? WeatherInfo(weatherData: _weatherData!)
                    : Container(),
          ],
        ),
      ),
    );
  }
}

class WeatherInfo extends StatelessWidget {
  final Map<String, dynamic> weatherData;

  const WeatherInfo({required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '${weatherData['location']['name']}, ${weatherData['location']['country']}',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Text('Temperature: ${weatherData['current']['temp_c']}°C'),
        Text('Condition: ${weatherData['current']['condition']['text']}'),
        Image.network('https:${weatherData['current']['condition']['icon']}'),
        Text('Humidity: ${weatherData['current']['humidity']}%'),
        Text('Wind Speed: ${weatherData['current']['wind_kph']} kph'),
      ],
    );
  }
}
