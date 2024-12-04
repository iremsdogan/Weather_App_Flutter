import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_data.dart';
import '../services/location_service.dart';
import '../services/city_service.dart';

const String apiKey = 'BQQSy5xLa4JiOKldCHm0Y5Mh8NoUfJsF';

class WeatherService {
  final LocationService _locationService = LocationService();
  final CityService _cityService = CityService();

  Future<Map<String, dynamic>> fetchWeatherData() async {
    final position = await _locationService.getCurrentLocation();
    final double latitude = position.latitude;
    final double longitude = position.longitude;

    await _cityService.loadCities();
    final String cityName = await _cityService.getCityName(latitude, longitude);
    print("Closest City: $cityName");
    
    final url =
        'https://api.tomorrow.io/v4/weather/forecast?location=$latitude,$longitude&timesteps=1d&units=metric&apikey=$apiKey';

    print("coordinates: position= $position lat = $latitude, lon = $longitude");

    final response = await http.get(Uri.parse(url));
    print('API Response: ${response.body}');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final dailyWeather = data['timelines']['daily'] as List<dynamic>;
      print('Daily weather raw data: $dailyWeather');

      final weatherList = dailyWeather.map((day) {
        return WeatherData.fromJson(day);
      }).toList();

      return {
          'weatherList': weatherList,
          'cityName': cityName,
        };
    } 
    else {
      throw Exception('Hava durumu verisi alınamadı: ${response.body}');
    }
  }
}


