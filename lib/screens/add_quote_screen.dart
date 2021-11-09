import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../models/quote_model.dart';
import '../provider/quote_provider.dart';

class AddQuoteScreen extends StatefulWidget {
  const AddQuoteScreen({Key? key}) : super(key: key);
  @override
  _AddQuoteScreenState createState() => _AddQuoteScreenState();
}

class _AddQuoteScreenState extends State<AddQuoteScreen> {
  TextEditingController quoteController = TextEditingController();
  TextEditingController writterController = TextEditingController();

  @override
  void dispose() {
    quoteController.dispose();
    writterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new quote"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: quoteController,
              decoration: const InputDecoration(
                  hintText: "Add Quote",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.00),
                    ),
                  ),
                  labelText: "Add New Quote"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: writterController,
              decoration: const InputDecoration(
                hintText: "Add Writer",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.00),
                  ),
                ),
                labelText: "Add Writer",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              style: const ButtonStyle(
                animationDuration: Duration(microseconds: 10),
              ),
              onPressed: () {
                if (quoteController.text.isNotEmpty &&
                    writterController.text.isNotEmpty) {
                  Provider.of<Quotelist>(context, listen: false).addQuote(
                      QuoteModel(quoteController.text, writterController.text));
                  Navigator.of(context).pushReplacementNamed('/');
                } else {}
              },
              child: Container(
                height: 50,
                width: 200,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: Colors.amber,
                ),
                alignment: Alignment.center,
                child: const Text(
                  "Add",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
