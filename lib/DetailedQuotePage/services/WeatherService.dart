import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_task/DetailedQuotePage/models/Weather.dart';

class WeatherService {
  static String _apiKey = "";

  static Future<Weather> fetchCurrentWeather({city}) async {
    var url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$_apiKey&units=metric';
    final response = await http.post(url);

    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Data loading error');
    }
  }
}
