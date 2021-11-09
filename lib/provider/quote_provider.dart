import 'package:flutter/widgets.dart';
import '../models/quote_model.dart';

class Quotelist extends ChangeNotifier {
  List<QuoteModel> quoteList = [];

  addQuote(QuoteModel quoteModel) {
    quoteList.add(quoteModel);
    notifyListeners();
  }

  deleteQuote(QuoteModel deleteModel) {
    quoteList.removeWhere((deleteItem) =>
        deleteItem.quote == deleteModel.quote &&
        deleteItem.writer == deleteModel.writer);
    notifyListeners();
  }

  editQuote(QuoteModel edited, QuoteModel original) {
    for (var element in quoteList) {
      if (element.quote == original.quote &&
          element.writer == original.writer) {
        element.quote = edited.quote;
        element.writer = edited.writer;
      }
    }
    notifyListeners();
  }
}
