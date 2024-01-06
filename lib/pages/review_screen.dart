import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  List<dynamic> unknownWords = [];
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _loadUnknownWords();
  }

  Future<void> _loadUnknownWords() async {
    setState(() {
      isLoading = true; // Set loading state to true
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      // Retrieve existing unknown words as a JSON list
      unknownWords = jsonDecode(prefs.getString('unknownWord') ?? '[]');
    } catch (error) {
      // Handle any errors during loading
      debugPrint('Error loading unknown words: $error');
    } finally {
      setState(() {
        isLoading = false; // Set loading state to false
      });
    }
  }

  Future<void> _removeFromUnknownWords(dynamic wordKnown) async {
    final prefs = await SharedPreferences.getInstance();
    // Save the updated list
    List<dynamic> existingUnknownWords =
        jsonDecode(prefs.getString('unknownWord') ?? '[]');
    existingUnknownWords.removeWhere((word) => word['EN'] == wordKnown['EN']);

    // Convert the updated list back to JSON
    final newUnknownWordsJson = jsonEncode(existingUnknownWords);

    // Save the JSON string to SharedPreferences
    await prefs.setString('unknownWord', newUnknownWordsJson);
    setState(() {
      unknownWords = existingUnknownWords;
    });
  }

  dynamic showAlertDialog(BuildContext context, dynamic words) {
    // set up the buttons
    Widget remindButton = TextButton(
      child: const Text("Yes"),
      onPressed: () {
        _removeFromUnknownWords(words);
        Navigator.pop(context);
      },
    );
    Widget cancelButton = TextButton(
      child: const Text("No"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Alert"),
      content: const Text(
          "Did you learn these words? If yes, please click 'Yes'. If no, please click 'No'."),
      actions: [remindButton, cancelButton],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget _renderBody() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (unknownWords.isNotEmpty) {
      return ListView.builder(
        itemCount: unknownWords.isEmpty ? 1 : unknownWords.length,
        itemBuilder: (context, index) {
          final words = unknownWords[index];
          final noword = words['NO'];
          final enword = words['EN'];
          return ListTile(
            title: Text('$enword: $noword'),
            leading: const Icon(Icons.checklist_rtl),
            trailing: null,
            onTap: () {
              showAlertDialog(context, words);
            },
          );
        },
      );
    } else {
      return const Center(
        child: Text("You have no word to review. Good job!"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _renderBody());
  }
}
