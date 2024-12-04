import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position> getCurrentLocation() async{

    //konum hizmeti etkin mi kontrol et
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      throw Exception("Konum servisi etkin değil.");
    }

    //Kullanıcıdan konum izni iste
    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        throw Exception("Konum izni tekrar reddedildi.");
      }
    }

    if(permission == LocationPermission.deniedForever){
      throw Exception("Konum izni kalıcı olarak reddedildi.");
    }

    // Kullanıcının mevcut konumunu al
    try {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
      
    } catch (e) {
      throw Exception("Konum alınırken bir hata oluştu: $e");
    }

  }
}