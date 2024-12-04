import 'package:flutter/material.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/viewmodels/weather_viewmodel.dart';
import 'package:weather_app/views/home_page.dart';

void main() {
  runApp(const MyApp()); // MyApp kök widget
}
//extend miras almak
class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
   
    return MultiProvider( 
      providers: [
        Provider(create: (_) => WeatherService()), 
        ChangeNotifierProvider(create: (_) => WeatherViewModel()),
      ],
      child: const MaterialApp(
        home: MyHomePage(),

      ),
    );
  }
}