import 'package:flutter/material.dart';

class MyGridPage extends StatelessWidget {

  final String formattedSunriseTime;
  final String formattedSunsetTime;  
  final String minTemp; 
  final String maxTemp;

  const MyGridPage({super.key, required this.formattedSunriseTime, required this.formattedSunsetTime, required this.maxTemp, required this.minTemp});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 3, //her hücrenin genişlik/yükseklik oranı
        children: [
          _buildItem('assets/images/11.png', 'Sunrise',formattedSunriseTime, ''),
          _buildItem('assets/images/12.png', 'Sunset',formattedSunsetTime, ''),
          _buildItem('assets/images/13.png', 'Temp Max', '', maxTemp),
          _buildItem('assets/images/14.png', 'Temp Min', '' , minTemp),
        ],
      ),
    );
  }
}

Widget _buildItem(String imagePath, String label, String time, String temp){
  return Container(
    padding: const EdgeInsets.all(8),
    child: Row(
      children: [
        Image.asset(imagePath, width: 50,height: 50,),
        const SizedBox(width: 10,),
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label, 
              style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
            if(time.isNotEmpty)
              Text(time,style: const TextStyle(fontSize: 14, color:Colors.white),),
            if(temp.isNotEmpty)
              Text('$temp°C', style: const TextStyle(fontSize: 14, color: Colors.white),)
          ],
        ),
        ),
    ],),
  );
}