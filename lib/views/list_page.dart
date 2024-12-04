import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/weather_data.dart';
import '../viewmodels/weather_code.dart';

class DailyWeatherList extends StatelessWidget{

  final List<WeatherData> weatherDataList;

  const DailyWeatherList ({super.key, required this.weatherDataList});

  @override
  Widget build(BuildContext context){
    return ListView.builder(
      shrinkWrap: true, // Bu önemli! SingleChildScrollView ile uyumlu olmasını sağlar
      physics: const NeverScrollableScrollPhysics(), // Kaydırma işlemi sadece ana ScrollView'de olacak
      itemCount: weatherDataList.length,
      itemBuilder: (context, index) {
        WeatherData dailyData = weatherDataList[index];
        Image dailyWeatherImage = getWeatherImage(dailyData.weatherCode);
        String day = DateFormat('EEEE | d MMMM').format(DateTime.parse(dailyData.date));
          
        return Column(
          children: [
            ListTile(
              title: Text(day, style: const TextStyle(fontSize: 18, color: Colors.white),),
              subtitle: Text('Min: ${dailyData.minTemp}°C | Max: ${dailyData.maxTemp}°C',style: const TextStyle(fontSize: 16, color: Colors.white),),
              leading: 
                dailyWeatherImage, 
            ),
            if(index != weatherDataList.length-1)
            const Divider(
              color: Colors.white12,
              thickness:1,
              indent:20,
              endIndent: 20,
            ),
          ],
        );
      },
    );
  }
}