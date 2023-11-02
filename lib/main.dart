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

  // Define a callback for when the event is fired
  void onTelegramUserId(js.JsObject event) {
    final userId = event['detail'].toString();
    completer.complete(userId);
  }

  // Register the callback using dart:js interop
  js.context['onTelegramUserId'] = onTelegramUserId;

  // Inject and execute JavaScript code
  js.context.callMethod('eval', ['''
    (function() {
      var script = document.createElement('script');
      script.src = 'https://telegram.org/js/telegram-web-app.js';
      document.head.appendChild(script);

      script.onload = function() {
        try {
          Telegram.WebApp.ready();
          var userId = Telegram.WebApp.initData.user.id.toString();
          window.dispatchEvent(new CustomEvent('telegramUserId', { detail: userId }));
        } catch (e) {
          console.error('Error retrieving user ID:', e);
        }
      };

      script.onerror = function() {
        console.error('Error loading Telegram script.');
      };

      window.addEventListener('telegramUserId', onTelegramUserId);
    })();
  ''']);

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
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Text("data - " + snapshot.data);
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
