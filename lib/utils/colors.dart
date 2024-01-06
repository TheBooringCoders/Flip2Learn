import 'package:flutter/material.dart';

const MaterialColor primary = MaterialColor(_primaryPrimaryValue, <int, Color>{
  50: Color(0xFFFDEFEA),
  100: Color(0xFFFBD6C9),
  200: Color(0xFFF9BBA6),
  300: Color(0xFFF6A082),
  400: Color(0xFFF48B67),
  500: Color(_primaryPrimaryValue),
  600: Color(0xFFF06F45),
  700: Color(0xFFEE643C),
  800: Color(0xFFEC5A33),
  900: Color(0xFFE84724),
});
const int _primaryPrimaryValue = 0xFFF2774C;

const MaterialColor primaryAccent =
    MaterialColor(_primaryAccentValue, <int, Color>{
  100: Color(0xFFFFFFFF),
  200: Color(_primaryAccentValue),
  400: Color(0xFFFFC7BC),
  700: Color(0xFFFFB1A2),
});
const int _primaryAccentValue = 0xFFFFF1EF;
