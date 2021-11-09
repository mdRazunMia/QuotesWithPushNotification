// ignore_for_file: unused_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../services/local_notification_service.dart';
import '../models/quote_model.dart';
import '../screens/edit_quote_screen.dart';
import '../provider/quote_provider.dart';

// ignore: import_of_legacy_library_into_null_safe
// import 'package:firebase_messaging/firebase_messaging.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    //open the app which is in the background and terminated and then open the app after tap on the notification.
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final routeFromMessage = message.data["route"];
        Navigator.of(context).pushNamed(routeFromMessage);
        // ignore: avoid_print
        print(routeFromMessage);
      }
    });

    //For the forground state of the app
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        // ignore: avoid_print
        print(message.notification!.title);
        // ignore: avoid_print
        print(message.notification!.body);
      }
      LocalNotificationService.display(message);
    });

    //app in background and  open and user tap on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeFromMessage = message.data["route"];
      // ignore: avoid_print
      Navigator.of(context).pushNamed(routeFromMessage);
      //for displaying headsup notification when the app in foreground
      // ignore: avoid_print
      print(routeFromMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<QuoteModel> demoList = Provider.of<Quotelist>(context).quoteList;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Quotes App"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/addQuoteScreen");
            },
            icon: const Icon(Icons.add),
            tooltip: "Add New Quote",
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemCount: demoList.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              margin: const EdgeInsets.only(left: 5, top: 10),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF3366FF),
                                      Color(0xFF00CCFF),
                                    ],
                                    begin: FractionalOffset(0.0, 0.0),
                                    end: FractionalOffset(1.0, 0.0),
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.mirror),
                              ),
                              width: 358,
                              child: Card(
                                margin: const EdgeInsets.all(10),
                                child: Text(
                                  "\"" + demoList[index].quote + "\"",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              "By: " + demoList[index].writer,
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.brown),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              color: Colors.red,
                              onPressed: () {
                                Provider.of<Quotelist>(context, listen: false)
                                    .deleteQuote(
                                  QuoteModel(demoList[index].quote,
                                      demoList[index].writer),
                                );
                              },
                              icon: const Icon(Icons.delete),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            IconButton(
                              color: Colors.blue,
                              onPressed: () {
                                // Provider.of<Quotelist>(context, listen: false)
                                //     .deleteQuote(
                                //   QuoteModel(demoList[index].quote,
                                //       demoList[index].writer),
                                // );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const EditQuoteScreen(),
                                    settings: RouteSettings(
                                      arguments: QuoteModel(
                                          demoList[index].quote,
                                          demoList[index].writer),
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.edit),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(
                      height: 5,
                      thickness: 2,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
