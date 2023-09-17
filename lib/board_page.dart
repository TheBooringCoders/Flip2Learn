import 'package:flutter/material.dart';

class BoardPage extends StatefulWidget {
  const BoardPage({super.key});

  @override
  State<BoardPage> createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 75),
        Card(
            margin: const EdgeInsets.only(left: 30, right: 30),
            child: Container(
              //padding: const EdgeInsets.all(75),
              width: 400,
              height: 200,
              color: Colors.white,
              child: const Center(
                  child: Text(
                'Norsk',
                textScaleFactor: 2,
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
            )),
        const SizedBox(height: 75),
        ElevatedButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(const Size(325, 50)),
            ),
            onPressed: () {
              debugPrint('I Know this');
            },
            child: const Text('I Know this')),
        const SizedBox(height: 25),
        ElevatedButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(const Size(325, 50)),
            ),
            onPressed: () {
              debugPrint('Don\'t know');
            },
            child: const Text('Don\'t know'))
      ],
    );
  }
}
