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
  final completer = Completer<String>();

  js.context.callMethod('eval', [
    '''
    fetch('https://telegram.org/js/telegram-web-app.js')
      .then(response => response.text())
      .then(scriptText => {
        const script = document.createElement('script');
        script.textContent = scriptText;
        document.head.appendChild(script);

        script.onload = () => {
          Telegram.WebApp.ready();
          const userId = Telegram.WebApp.initData.user.id;
          window.dispatchEvent(new CustomEvent('telegramUserId', { detail: userId }));
        };
      })
      .catch(error => console.error('Error loading Telegram script:', error));
  '''
  ]);

  // Listen for the custom event to receive the user ID
  js.context['window'].callMethod('addEventListener', [
    'telegramUserId',
    js.allowInterop((js.JsObject event) {
      completer.complete(event['detail'].toString());
    }),
  ]);

  return completer.future;
}

class TelegramMiniApp extends StatelessWidget {
  const TelegramMiniApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: MainScreen(
      // circle: getCurrUser(),
      // ),
      home: Scaffold(
        body: FutureBuilder(
          future: retrieveUserId(),
          initialData: Container(
            color: Colors.red,
            height: 100,
            width: 100,
          ),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data);
            } else {
              return Text("error - ${snapshot.error}\ndata - ${snapshot.data}");
            }
          },
        ),
      ),
    );
  }

  Future<CircleModel> getCurrUser() async {
    var dict = jsonDecode((await http.get(Uri.parse(""))).body);

    return CircleModel(
        dict["url"], dict['text'], int.tryParse(dict[""]) ?? 0xFF2FFFFF);
  }
}
