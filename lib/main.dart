import 'package:flip2learn/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flip2learn/pages/level_screen.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(buildMainApp()));
}

MaterialApp buildMainApp() {
  return MaterialApp(
    theme: ThemeData(
      primarySwatch: primary,
    ),
    debugShowCheckedModeBanner: false,
    home: const MainApp(),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('image/splashScreen.png'),
          fit: BoxFit.none,
        )),
        child: const Center(
            child: Padding(
                padding: EdgeInsets.only(top: 150),
                child: Image(
                  image: AssetImage('image/title.png'),
                ))),
      ),
      floatingActionButton: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(primary.shade500),
        ),
        onPressed: () {
          debugPrint(context.toString());
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LevelScreen()),
          );
        },
        child: const Text(
          'Start Playing',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
