import 'package:flutter/material.dart';

Image getWeatherImage(int weatherCode){

    String imagePath;
    if(weatherCode == 1000 || weatherCode == 1100){
      imagePath = "assets/images/6.png";  // Güneşli
    }
    else if(weatherCode==1001 || weatherCode==1101 || weatherCode==1102){
      imagePath = 'assets/images/8.png';   // bulutlu
    }
    else if(weatherCode>=2000 && weatherCode<4000){
      imagePath = 'assets/images/5.png';  // sisli
    }
    else if(weatherCode>=4000 && weatherCode<5000){
      imagePath = 'assets/images/3.png';  // Yağmurlu
    }
    else if(weatherCode>=5000 && weatherCode<8000){
      imagePath = 'assets/images/4.png';   // Karlı
    }
    else if(weatherCode>=8000){
      imagePath = 'assets/images/9.png';   // Fırtına
    }
    else{
      imagePath = 'assets/images/1.png';  //Bilinmeyen hava durumu
    }

    return Image.asset(imagePath, width: 50,height: 50,);
}