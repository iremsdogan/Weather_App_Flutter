import 'package:intl/intl.dart';
class WeatherData{
  String date;
  int minTemp;
  int maxTemp;
  int avgTemp;
  int weatherCode;
  String sunriseTime;
  String sunsetTime;

  WeatherData({
    required this.date,
    required this.minTemp,
    required this.maxTemp,
    required this.avgTemp,
    required this.weatherCode,
    required this.sunriseTime, 
    required this.sunsetTime,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json){
    
    final values = json['values'];

    return WeatherData(
      date: json['time'] ?? '',
      minTemp: values['temperatureMin']?.toInt() ?? 0,
      maxTemp: values['temperatureMax']?.toInt() ?? 0,
      avgTemp: values['temperatureAvg']?.toInt() ?? 0,
      weatherCode: values['weatherCodeMax'],
      sunriseTime: values['sunriseTime'] ?? '',
      sunsetTime: values['sunsetTime'] ?? '',
    );
  }
  String get formattedDate => DateFormat('EEEE | d MMMM').format(DateTime.parse(date));
  String get formattedSunriseTime => DateFormat('HH:mm').format(DateTime.parse(sunriseTime));
  String get formattedSunsetTime => DateFormat('HH:mm').format(DateTime.parse(sunsetTime));
}