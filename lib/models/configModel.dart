import 'package:flutter/material.dart';

class ConfigModel {
  Color mainColor =Colors.grey[850]; //Colors.blue[700]; // Colors.grey[850];
  Color backgroundColor = Colors.grey[850];//Colors.blue[700]; //
  Color secondColor = Colors.grey[400];//Colors.blue[100];
  Color drawingColor = Colors.white;
  Color fontColorLight = Colors.white;
  Color fontColorMedium = Colors.grey[800];
  Color fontColorDark = Colors.black;

  double fontSizeFactor = 1.0;
  double fontSizeDelta = 3.0;

  bool ignore_updates = false;
  bool allow_data_collection = false;
  bool windows_network_throttling_disabled = true;
  bool internet_centered = true;
  bool show_other_devices = true;
  bool show_speeds_permanent = false;
  bool show_speeds = false;
  bool high_contrast = false;
  Map<String, dynamic> theme;
  String language =  "";

  ConfigModel() {
    this.theme = theme_dark;
  }

  Map<String, dynamic> theme_dark = {
    "name": "DarkTheme",
    "mainColor" : Colors.grey[850], //Colors.blue[700]; // Colors.grey[850];
    "backgroundColor" : Colors.grey[850], //Colors.blue[700]; //
    "secondColor" : Colors.grey[400], //Colors.blue[100];
    "drawingColor" : Colors.white,
    "fontColorLight" : Colors.white,
    "fontColorMedium" : Colors.grey[800],
    "fontColorDark" : Colors.black,
  };

  Map<String, dynamic> theme_devolo = {
    "name": "Standart",
    "mainColor" : Colors.blue[700],
    "backgroundColor" : Colors.blue[700],
    "secondColor" : Colors.blue[100],
    "drawingColor" : Colors.white,
    "fontColorLight" : Colors.white,
    "fontColorMedium" : Colors.grey[800],
    "fontColorDark" : Colors.black,
  };

  Map<String, dynamic> theme_highContrast = {
    "name": "High Contrast",
    "mainColor" : Colors.black, //Colors.blue[700]; // Colors.grey[850];
    "backgroundColor" : Colors.black, //Colors.blue[700]; //
    "secondColor" : Colors.white, //Colors.blue[100];
    "drawingColor" : Colors.white,
    "fontColorLight" : Colors.yellowAccent,
    "fontColorMedium" : Colors.black,
    "fontColorDark" : Colors.black,
  };

  Map<String,dynamic> config = {
    "ignore_updates": false,
    "allow_data_collection": false,
    "windows_network_throttling_disabled":true,
    "internet_centered": true,
    "show_other_devices": true,
    "show_speeds_permanent": false,
    "show_speeds": false,
    "high_contrast": false,
    "language": ""
  };


}
