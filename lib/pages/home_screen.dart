import 'package:flip2learn/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flip2learn/pages/flip_screen.dart';
import 'package:flip2learn/pages/review_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final int difficulty;

  const HomeScreen({Key? key, required this.difficulty}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    debugPrint(index.toString());
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _clearStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.clear();
      // Retrieve existing unknown words as a JSON list
    } catch (error) {
      // Handle any errors during loading
      debugPrint('Error loading unknown words: $error');
    } finally {}
  }

  static const List<Widget> _pages = <Widget>[FlipScreen(), ReviewScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            PopupMenuButton(onSelected: (item) {
              if (item == 'clear') {
                _clearStorage();
              }
            }, itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 'clear',
                  child: Text('clear'),
                )
              ];
            }),
          ],
        ),
        drawer: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: primary.shade500,
              ),
              child: const Text('Languages Settings'),
            ),
            const ListTile(
              title: Text('Norwegian'),
              shape: Border(
                  bottom: BorderSide(color: Color.fromARGB(255, 233, 132, 95))),
            )
          ]),
        ),
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: primary.shade100,
          selectedItemColor: primary.shade500,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: primary.shade500),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.checklist,
                color: primary.shade500,
              ),
              label: 'Reviews',
            ),
          ],
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
        ),
        body: Center(
          child: _pages.elementAt(_selectedIndex),
        ));
  }
}
