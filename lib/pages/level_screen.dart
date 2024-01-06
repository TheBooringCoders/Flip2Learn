import 'package:flip2learn/pages/home_screen.dart';
import 'package:flip2learn/utils/colors.dart';
import 'package:flutter/material.dart';

class LevelScreen extends StatelessWidget {
  const LevelScreen({super.key});

  static const List<int> levels = [1, 2, 3];
  String getButtonText(int level) {
    switch (level) {
      case 1:
        return 'Beginner';
      case 2:
        return 'Intermediate';
      case 3:
        return 'Hard';
      default:
        return 'Unknown Level';
    }
  }

  void navigateToHomeScreen(BuildContext context, int difficulty) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(difficulty: difficulty),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //create a button generator
    List<Widget> buttons = List.generate(
      levels.length,
      (index) => SizedBox(
        width: 200,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(primary.shade500)),
            onPressed: () => navigateToHomeScreen(context, levels[index]),
            child: Text(
              getButtonText(levels[index]),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('image/levelScreen.png'), fit: BoxFit.none)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: buttons,
          ),
        ),
      ),
    );
  }
}
