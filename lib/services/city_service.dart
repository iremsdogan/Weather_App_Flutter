import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;

class CityService {
  late List<dynamic> _cities = [];

  Future<void> loadCities() async{
    if(_cities.isEmpty){
      final String response = await rootBundle.loadString('assets/cities.json');
    final Map<String, dynamic> jsonData = jsonDecode(response);
    _cities = jsonData['data'];
    }
  }

  Future<String> getCityName(double latitude, double longitude) async{
    if(_cities.isEmpty){
      await loadCities(); 
    }
    print('Loaded cities: ${_cities.length}');
    double closestDistance = double.infinity;
    String closestCity = "";

    for(final city in _cities){
      final cityLat = (city['coordinates']['latitude'] as num).toDouble();
      final double cityLon = (city['coordinates']['longitude'] as num).toDouble();

      final distance = _calculateDistance(latitude, longitude, cityLat, cityLon);
      print('Calculated distance: $distance');

      if(distance<closestDistance){
        closestDistance = distance;
        closestCity = city['name'];
        print('New closest city: $closestCity');
      }
    }
    print('City Name: $closestCity');
    
    return closestCity;
  }

  double _calculateDistance(double lat1, double lon1, double lat2, double lon2){
    const double radiusOfEarth = 6371.0;

    double dLat = _degreesToRadians(lat2-lat1);
    double dLon = _degreesToRadians(lon2-lon1);

    double a = pow(sin(dLat/2),2) + cos(_degreesToRadians(lat1))*cos(_degreesToRadians(lat2)) * pow(sin(dLon/2),2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return radiusOfEarth * c;
  }
  double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }
}