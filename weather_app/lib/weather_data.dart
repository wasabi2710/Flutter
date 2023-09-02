import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const String apiKey = "0be16cc42d6a4fdabaf170718230109";

//fetch weather
Future<Weather> fetchWeather() async {
  String url =
      "https://api.weatherapi.com/v1/current.json?key=0be16cc42d6a4fdabaf170718230109&q=Phnom Penh&aqi=no";
  http.Response response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return Weather.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load weather, calls limited ...');
  }
}

//weather
class Weather {
  final double currentTemp;
  final String city;

  const Weather({required this.currentTemp, required this.city});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      currentTemp: json['current']['temp_c'],
      city: json['location']['name'],
    );
  }
}
