import 'package:flutter/material.dart';
import '../models/weather_data.dart';
import '../services/weather_service.dart';

// viewmodels veriyi çekme ve kullanıcı arayüzü için hazırlama görevini üstlenir

class WeatherViewModel extends ChangeNotifier { // ChangeNotifier durum değişikliklerini dinleyiciye bildirir, böylece UI güncellenir

  final WeatherService _weatherService = WeatherService();

  WeatherData? _currentWeatherData; // Bugünün verisi
  WeatherData? get currentWeatherData => _currentWeatherData;

  List<WeatherData>? _weatherList; // 5 günlük veri
  List<WeatherData>? get weatherList => _weatherList;

  String? _cityName;
  String? get cityName => _cityName;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchWeatherData() async {
    _isLoading = true;
    notifyListeners();

    try{
      
      final data = await _weatherService.fetchWeatherData();
      print('data');
      _cityName = data['cityName'];
      _currentWeatherData = data['weatherList'].first;
      _weatherList = data['weatherList'].sublist(1);
      _errorMessage = null;
    }
    catch (e) {
      _errorMessage = 'Hava Durumu Verisi Yüklenemedi: $e';
    }
    finally{
      _isLoading = false;
      notifyListeners();  //yükleme durumunun sona erdiğini UI a bildirir
    }
  }
}