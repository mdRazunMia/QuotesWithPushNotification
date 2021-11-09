import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import './services/local_notification_service.dart';
import './provider/quote_provider.dart';
import './screens/add_quote_screen.dart';
import './screens/home_screen.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  // ignore: avoid_print
  print(message.data.toString());
  // ignore: avoid_print
  print(message.notification!.title);
  // ignore: avoid_print
  print(message.notification!.body);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Initializing the flutter notification plugin for showing headup message when app in foreground
  LocalNotificationService.initialize();

  await Firebase.initializeApp();
  //app in the background but not opened
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(
    ChangeNotifierProvider(
      create: (_) => Quotelist(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quote App',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      // home: const HomeScreen(),
      routes: {
        '/': (context) => const HomeScreen(),
        '/addQuoteScreen': (context) => const AddQuoteScreen(),
      },
    );
  }
}
