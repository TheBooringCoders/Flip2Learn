import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<dynamic>> loadAndDecodeJsonData() async {
  final prefs = await SharedPreferences.getInstance();
  try {
    // Load the JSON string from the assets folder
    String jsonString = await rootBundle.loadString('assets/wordlist.json');
    debugPrint(jsonString);
    // Retrieve existing unknown words as a JSON list
    List<dynamic> existingUnknownWords =
        jsonDecode(prefs.getString('unknownWord') ?? '[]');
    debugPrint('Existing unknown words: $existingUnknownWords');
    // Decode the JSON string into a list of dynamic objects
    List<dynamic> decodedData = jsonDecode(jsonString);

    // Remove existing unknown words based on their EN values
    decodedData.removeWhere((word) => existingUnknownWords.any(
          (existingWord) => existingWord['EN'] == word['EN'],
        ));

    return decodedData;
  } catch (error) {
    // Handle any errors that might occur during loading or decoding
    // ignore: avoid_print
    print('Error loading or decoding JSON data: $error');
    rethrow; // Rethrow the error to allow for further handling
  }
}
