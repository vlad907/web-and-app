import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = '60457be7e4134359aa734053241110';
  
  Future<Map<String, dynamic>?> fetchWeather(String city) async {
    try {
      final url = Uri.parse(
        'https://api.weatherapi.com/v1/current.json?key=60457be7e4134359aa734053241110&q=$city');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Error fetching weather data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
