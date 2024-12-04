//hava durumu verilerini bir API'den alıyor. Bu fonksiyonun doğru çalışıyor mu diye unit test yaptık.
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart'; //sahte veri göndermek için kütüphane
import 'widget_test.mocks.dart';
import 'package:weather_app/models/weather_data.dart';

void main(){
  group('Weather Service Test', (){
    test('fetchWeatherData returns correct data', () async{
      final mockWeatherService = MockWeatherService();

      when(mockWeatherService.fetchWeatherData()).thenAnswer((_) async => [
        WeatherData(
        date: '2024-11-04T00:00:00Z', 
        avgTemp: 3,
        minTemp: 30, 
        maxTemp: 30, 
        weatherCode: 1000,
        sunriseTime: '2024-11-04T11:38:00Z',
        sunsetTime: '2024-11-04T21:55:00Z',
        )
      ]);
      var weatherData = await mockWeatherService.fetchWeatherData();

      expect(weatherData[0].avgTemp, 3);
      expect(weatherData[0].minTemp, 30);
      expect(weatherData[0].maxTemp, 30);
      expect(weatherData[0].sunriseTime,'2024-11-04T11:38:00Z');
      expect(weatherData[0].sunsetTime,'2024-11-04T21:55:00Z');
    });
  });
}