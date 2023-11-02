import 'package:flutter/material.dart';
import 'package:hibye_mini_app/main_screen.dart';

void main() {
  runApp(const TelegramMiniApp());
}

class TelegramMiniApp extends StatelessWidget {
  const TelegramMiniApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(image: null,),
    );
  }
}
