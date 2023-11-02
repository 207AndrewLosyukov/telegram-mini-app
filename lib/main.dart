import 'dart:async';
import 'dart:convert';
import 'dart:js' as js;
import 'package:flutter/material.dart';
import 'package:hibye_mini_app/main_screen.dart';
import 'package:hibye_mini_app/meet_item.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const TelegramMiniApp());
}

Future<String> retrieveUserId() async {
  // Load the Telegram WebApp JavaScrip

  js.context.callMethod('eval', [
    '''
    const script = document.createElement('script');
    script.src = 'https://telegram.org/js/telegram-web-app.js';
    document.head.appendChild(script);
  '''
  ]);

  // Use a Completer to wait for the asynchronous script load
  final completer = Completer<String>();

  js.context.callMethod('eval', [
    '''
    script.onload = () => {
      Telegram.WebApp.ready();
      const userId = Telegram.WebApp.initDataUnsafe.user.id;
      window.dispatchEvent(new CustomEvent('telegramUserId', { detail: userId }));
    };
  '''
  ]);

  // Listen for the custom event to receive the user ID
  js.context['window'].callMethod('addEventListener', [
    'telegramUserId',
    js.allowInterop((js.JsObject event) {
      completer.complete(event['detail'].toString());
    }),
  ]);

  
  print("yay");
  return completer.future;
}

class TelegramMiniApp extends StatelessWidget {
  const TelegramMiniApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(
        // circle: getCurrUser(),
      ),
    );
  }

  Future<CircleModel> getCurrUser() async {
    var dict = jsonDecode((await http.get(Uri.parse(""))).body);

    return CircleModel(
        dict["url"], dict['text'], int.tryParse(dict[""]) ?? 0xFF2FFFFF);
  }
}
