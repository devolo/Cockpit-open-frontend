/*
Copyright (c) 2021, devolo AG
All rights reserved.

This source code is licensed under the BSD-style license found in the
LICENSE file in the root directory of this source tree.
*/

import 'package:cockpit_devolo/views/appBuilder.dart';
import 'package:flutter/material.dart';

Color mainColor= Colors.white;// = Colors.grey[850]; //Colors.blue[700]; // Colors.grey[850];
Color backgroundColor= Colors.white;// = Colors.grey[850];//Colors.blue[700]; //
Color secondColor= Colors.white;// = Colors.grey[400];//Colors.blue[100];
Color accentColor= Colors.white;// = Colors.grey[400];//Colors.blue[100];
Color drawingColor= Colors.white;// = Colors.white;
Color fontColorLight= Colors.white;// = Colors.white;
Color fontColorMedium= Colors.white;// = Colors.grey[800];
Color fontColorDark= Colors.white ;// = Colors.black;
Color fontColorNotAvailable= Colors.white ; // if button can´t be klicked for example

Color devoloBlue = Color.fromARGB(255, 0, 114, 180);
Color devoloBlueMedium = Color.fromARGB(255, 81, 154, 207);
Color devoloBlueLight = Color.fromARGB(255, 177, 203, 232);
Color devoloGreen = Color.fromARGB(255, 149, 193, 31);
Color devoloOrange = Color.fromARGB(255, 243, 146, 0);
Color devoloRed = Color.fromARGB(255, 199, 20, 61);

double fontSizeFactor = 1.0;
double fontSizeDelta = 3.0;

var theme_list = [theme_dark, theme_devolo, theme_light, theme_highContrast];

//void setTheme(Map<String,dynamic> theme) {
void setTheme(String theme_name) {
  dynamic theme;
  bool themeExists = false;
  print("Set Theme Name: " + theme_name);
  for(var elem in theme_list) {
    if(elem["name"] == theme_name) {
      theme = elem;
      themeExists = true;
    }
  }

  if(themeExists){
    mainColor = theme["mainColor"];
    backgroundColor = theme["backgroundColor"];
    secondColor = theme["secondColor"];
    accentColor = theme["accentColor"];
    drawingColor = theme["drawingColor"];
    fontColorLight = theme["fontColorLight"];
    fontColorMedium = theme["fontColorMedium"];
    fontColorDark = theme["fontColorDark"];
    fontColorNotAvailable = theme["fontColorNotAvailable"];
  }
}

Map<String, dynamic> theme_dark = {
  "name": "Dark Theme",
  "mainColor" : Colors.grey[850], //Colors.blue[700]; // Colors.grey[850];
  "backgroundColor" : Colors.grey[850], //Colors.blue[700]; //
  "secondColor" : Colors.grey[400], //Colors.blue[100];
  "accentColor" : Colors.grey[700], //Colors.blue[100];
  "drawingColor" : Colors.white,
  "fontColorLight" : Colors.white,
  "fontColorMedium" : Colors.grey[800],
  "fontColorDark" : Colors.black,
  "fontColorNotAvailable" : Colors.grey,
};


Map<String, dynamic> theme_devolo = {
  "name": "Standard",
  "mainColor" : devoloBlue,
  "backgroundColor" : devoloBlue,
  "secondColor" : devoloBlueLight,//Colors.blue[100],
  "accentColor" : devoloBlueMedium,//Colors.blue[100],
  "drawingColor" : Colors.white,
  "fontColorLight" : Colors.white,
  "fontColorMedium" : Colors.grey[800],
  "fontColorDark" : Colors.black,
  "fontColorNotAvailable" : Colors.grey[800],
};

Map<String, dynamic> theme_highContrast = {
  "name": "High Contrast",
  "mainColor" : Colors.black,
  "backgroundColor" : Colors.black,
  "secondColor" : Colors.white,
  "accentColor" : Colors.white,
  "drawingColor" : Colors.white,
  "fontColorLight" : Colors.yellowAccent,
  "fontColorMedium" : Colors.black,
  "fontColorDark" : Colors.black,
  "fontColorNotAvailable" : Colors.orange[900],
};

Map<String, dynamic> theme_light = {
  "name": "Light Theme",
  "mainColor" : Colors.white,
  "backgroundColor" : Colors.white,
  "secondColor" : Colors.grey[300],
  "accentColor" : Colors.grey[300],
  "drawingColor" : Colors.grey,
  "fontColorLight" : Colors.black,
  "fontColorMedium" : Colors.grey[800],
  "fontColorDark" : Colors.black,
  "fontColorNotAvailable" : Colors.grey[800],
};

