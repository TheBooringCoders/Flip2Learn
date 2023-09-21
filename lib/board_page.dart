import 'package:flutter/material.dart';
import 'package:flip2learn/colors.dart';
import 'package:flutter_tts/flutter_tts.dart';

class BoardPage extends StatefulWidget {
  const BoardPage({super.key});

  @override
  State<BoardPage> createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  int currentIndex = 0;
  bool isBack = false;
  final List<Map<String, String>> dict = [
    {"Norsk": "norwegian"},
    {"Jeg Heter": "My Name is"},
    {"hallo": "hello"},
    {"hvor mye": "how much"},
    {"hvor er": "where is"},
    {"jeg vil": "i would like"},
    {"takk": "thank you"},
  ];

  void _speak() async {
    FlutterTts flutterTts = FlutterTts();
    Future.delayed(const Duration(milliseconds: 500));
    await flutterTts.setLanguage('nb-NO');
    await flutterTts.speak(dict[currentIndex].keys.first);
  }

  String getValue() {
    return dict[currentIndex].values.first;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 25),
        const Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text('Header'),
          Text('Current Score'),
          Text('Total Score')
        ]),
        const SizedBox(height: 25),
        Card(
          margin: const EdgeInsets.only(left: 30, right: 30),
          child: isBack
              ? Container(
                  width: 400,
                  height: 200,
                  color: Colors.white,
                  child: Center(
                      child: Text(
                    getValue(),
                    textScaleFactor: 2,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )),
                )
              : Container(
                  width: 400,
                  height: 200,
                  color: Colors.white,
                  child: Center(
                      child: Text(
                    dict[currentIndex].keys.first,
                    textScaleFactor: 2,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )),
                ),
        ),
        const SizedBox(height: 25),
        IconButton(
          onPressed: _speak,
          icon: const Icon(Icons.volume_up),
          color: primary,
          iconSize: 32,
          splashColor: primaryAccent,
        ),
        const SizedBox(height: 25),
        ElevatedButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(const Size(325, 50)),
            ),
            onPressed: () {
              // var val = getValue();
              // debugPrint(val);
              setState(() {
                currentIndex++;
                if (currentIndex >= dict.length) {
                  currentIndex = 0;
                }
              });
            },
            child: const Text('I Know this')),
        const SizedBox(height: 25),
        ElevatedButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(const Size(325, 50)),
            ),
            onPressed: () {
              //debugPrint('Don\'t know');
              setState(() {
                currentIndex++;
                if (currentIndex >= dict.length) {
                  currentIndex = 0;
                }
              });
            },
            child: const Text('Don\'t know'))
      ],
    );
  }
}
