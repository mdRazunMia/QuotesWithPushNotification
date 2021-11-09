import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/quote_model.dart';
import '../provider/quote_provider.dart';

class EditQuoteScreen extends StatelessWidget {
  const EditQuoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuoteModel editableQqotemodel =
        ModalRoute.of(context)!.settings.arguments as QuoteModel;
    final String editableQuote = editableQqotemodel.quote;
    final String editableWriter = editableQqotemodel.writer;

    TextEditingController editQuoteController =
        TextEditingController(text: editableQuote);
    TextEditingController editWriterController =
        TextEditingController(text: editableWriter);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit quote"),
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
              controller: editQuoteController,
              decoration: const InputDecoration(
                  hintText: "Edit Quote",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.00),
                    ),
                  ),
                  labelText: "Edit Quote"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: editWriterController,
              decoration: const InputDecoration(
                  hintText: "Edit Writer",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.00),
                    ),
                  ),
                  labelText: "Edit Writer"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              style: const ButtonStyle(
                animationDuration: Duration(microseconds: 10),
              ),
              onPressed: () {
                Provider.of<Quotelist>(context, listen: false).editQuote(
                  QuoteModel(
                      editQuoteController.text, editWriterController.text),
                  QuoteModel(editableQuote, editableWriter),
                );
                Navigator.of(context).pushReplacementNamed('/');
              },
              // ignore: avoid_unnecessary_containers
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
                  "Edit",
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
