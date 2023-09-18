import 'package:flip2learn/home_page.dart';
import 'package:flip2learn/colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: primary,
      ),
      home: const RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/firstPage.png'), fit: BoxFit.cover)),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 150),
          child: Image.asset(
            'images/text.png', // Replace 'your_image.png' with the actual image asset path
            width: 200.0, // Adjust the width as needed
            height: 200.0, // Adjust the height as needed
          ),
        )),
      ),
    );
  }
}
