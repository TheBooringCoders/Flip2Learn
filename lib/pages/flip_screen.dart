import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flip2learn/utils/colors.dart';
import 'package:flip2learn/utils/json_helper.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FlipScreen extends StatefulWidget {
  const FlipScreen({super.key});

  @override
  State<FlipScreen> createState() => _FlipScreenState();
}

class _FlipScreenState extends State<FlipScreen> {
  final con = FlipCardController();
  final Future<List<dynamic>> _wordsData =
      loadAndDecodeJsonData(); // Load and decode data
  int _currentWordIndex = 0;
  int _totalWords = 0;

  void knownWord() {
    setState(() {
      _currentWordIndex =
          ((_currentWordIndex + 1) % _totalWords); // Move to next word
    });
  }

  Future<void> _unknownWord() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final wordsData = await _wordsData; // Await the completion of the Future
      final currentWord = wordsData[_currentWordIndex];
      final currentWordEN = currentWord['EN']; // Extract the EN value

      // Retrieve existing unknown words as a JSON list
      List<dynamic> existingUnknownWords =
          jsonDecode(prefs.getString('unknownWord') ?? '[]');

      // Check if a word with the same EN value already exists
      final existingWordWithSameEN = existingUnknownWords.firstWhere(
        (word) => word['EN'] == currentWordEN,
        orElse: () => null, // Return null if not found
      );

      if (existingWordWithSameEN == null) {
        // Add the word only if its EN value is not present
        existingUnknownWords.add(currentWord);
        debugPrint('New word added: $currentWord');

        // Save the updated list
        final newUnknownWordsJson = jsonEncode(existingUnknownWords);
        await prefs.setString('unknownWord', newUnknownWordsJson);
      } else {
        debugPrint('Word with same EN value already exists: $currentWordEN');
      }
    } catch (error) {
      debugPrint('Error loading data: $error'); // Handle errors
    }

    setState(() {
      _currentWordIndex =
          ((_currentWordIndex + 1) % _totalWords); // Move to next word
    });
  }

  Future<void> speak() async {
    try {
      FlutterTts flutterTts = FlutterTts();

      final List<dynamic> wordsData = await _wordsData;
      final currentWord = wordsData[_currentWordIndex]['NO'];
      await flutterTts.setLanguage('nb-NO');
      await flutterTts.speak(currentWord);
      debugPrint(currentWord);
    } catch (error) {
      // Handle any errors during loading or accessing the list
      debugPrint('Error accessing words data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build $_currentWordIndex');
    double deviceWidth = MediaQuery.of(context).size.width;
    double fontSize = deviceWidth / 12; // Adjust the divisor as needed

    return Scaffold(
        body: Center(
      child: Column(children: [
        FutureBuilder<List<dynamic>>(
          future: _wordsData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List? words = snapshot.data;
              _totalWords = words!.length;
              String currentWordNO =
                  words[_currentWordIndex]['NO']; // Get first word's NO text
              String currentWordEN =
                  words[_currentWordIndex]['EN']; // Get first word's EN text
              //debugPrint(currentWordNO);
              return FlipCard(
                controller: con,
                rotateSide: RotateSide.right,
                onTapFlipping: true,
                axis: FlipAxis.vertical,
                frontWidget: Card(
                  color: primary.shade500,
                  child: SizedBox(
                    height: 200,
                    width: 300,
                    child: Center(
                      child: Text(
                        currentWordNO, // Display NO text on front
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: Colors.white, fontSize: fontSize),
                      ),
                    ),
                  ),
                ),
                backWidget: Card(
                  color: primary.shade100,
                  child: SizedBox(
                    height: 200,
                    width: 300,
                    child: Center(
                      child: Text(
                        currentWordEN, // Display EN text on back
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: Colors.white, fontSize: fontSize),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return const Center(
                  child: CircularProgressIndicator()); // Show loading indicator
            }
          },
        ),
        const SizedBox(height: 50),
        ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStatePropertyAll<Color>(primary.shade500),
            ),
            onPressed: () {
              speak();
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Icon(Icons.campaign, color: Colors.white),
                  Text(
                    'Speak',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            )),
        const SizedBox(height: 100),
        SizedBox(
            width: 200,
            height: 50,
            child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(primary.shade500),
                ),
                onPressed: knownWord,
                child: const Text('I know this word',
                    style: TextStyle(color: Colors.white)))),
        const SizedBox(height: 20),
        SizedBox(
            width: 200,
            height: 50,
            child: ElevatedButton(
                onPressed: _unknownWord,
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(primary.shade500)),
                child: const Text(
                  'I don\'t know',
                  style: TextStyle(color: Colors.white),
                ))),
      ]),
    ));
  }
}
