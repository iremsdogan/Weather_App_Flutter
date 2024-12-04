import 'package:flutter/material.dart';
import 'list_page.dart';
import 'grid_page.dart';
import '../models/weather_data.dart';
import '../viewmodels/weather_code.dart';
import '../viewmodels/weather_viewmodel.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();

    // fetchWeatherData çağrısını doğru bağlamda yapmak için
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeatherViewModel>().fetchWeatherData();
    });
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Arkaplan resmi
          Container(
            width: screenWidth,
            height: screenHeight,

            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background1.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Blur efekti
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.black.withOpacity(0.1),
            ),
          ),
          // İçerik alanı
          Container(
            margin: EdgeInsets.only(top: screenHeight * 0.09),
            child: Consumer<WeatherViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (viewModel.errorMessage != null) {
                  return Center(
                    child: Text(
                      'Hata: ${viewModel.errorMessage}',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  );
                } else if (viewModel.currentWeatherData != null &&viewModel.weatherList!= null) {
                  
                  final WeatherData currentWeather = viewModel.currentWeatherData!;
                  final List<WeatherData> nextDaysWeather = viewModel.weatherList!;
            
                  String cityName = viewModel.cityName??"Unknown City";
                  String formattedDate = currentWeather.formattedDate;
                  String formattedSunrise = currentWeather.formattedSunriseTime;
                  String formattedSunset = currentWeather.formattedSunsetTime;
            
                  String avgTemp = currentWeather.avgTemp.toString();
                  String minTemp = currentWeather.minTemp.toString();
                  String maxTemp = currentWeather.maxTemp.toString();
            
                  Image currentWeatherImage = getWeatherImage(currentWeather.weatherCode);
            
                  return SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          // Şehir ismi ve hava durumu resmi
                          Column(
                            children: [
                              Text(
                                cityName,
                                style: const TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: screenHeight * 0.02),
                                width: screenWidth * 0.4,
                                height: screenWidth * 0.4,
                                child: currentWeatherImage,
                              ),
                              Text(
                                '$avgTemp°C',
                                style: const TextStyle(fontSize: 50, color: Colors.white),
                              ),
                            ],
                          ),
                          // Tarih
                          Text(
                            formattedDate,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          customDivider(),
                          // Gün doğumu, gün batımı ve sıcaklık bilgileri
                          SizedBox(
                            height: screenHeight * 0.15,
                            child: MyGridPage(
                              formattedSunriseTime: formattedSunrise,
                              formattedSunsetTime: formattedSunset,
                              maxTemp: maxTemp,
                              minTemp: minTemp,
                            ),
                          ),
                          customDivider(),
                          // 5 günlük hava durumu başlığı
                          Container(
                            margin: EdgeInsets.only(top: screenHeight * 0.01),
                            child: const Text(
                              '5-DAY FORECAST',
                              style: TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                          // 5 günlük hava durumu listesi
                         DailyWeatherList(weatherDataList: nextDaysWeather),
                        ],
                      ),
                    ),
                  );
                }
                return const Center(
                  child: Text(
                    'Veri bulunamadı.',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Ayraç widget'ı
  Widget customDivider() {
    return const Divider(
      color: Colors.white30,
      thickness: 2,
      indent: 20,
      endIndent: 20,
    );
  }
}
