
import 'package:book_app_flutter/core/api/book_api.dart';
import 'package:flutter/cupertino.dart';

class BookProvider extends ChangeNotifier {
  final BookApi _api;

  BookProvider(this._api);


}