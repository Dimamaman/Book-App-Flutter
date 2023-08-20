
import 'package:book_app_flutter/core/api/book_api.dart';
import 'package:book_app_flutter/core/api/book_model.dart';
import 'package:flutter/cupertino.dart';

class BookProvider extends ChangeNotifier {
  final BookApi _api;

  BookProvider(this._api);

  var _list = <BookModel>[];
  var _loading = false;
  var _error = "";

  Future<void> loadData(String? searchValue) async {
    if(_loading) {
      return;
    }

    _loading = true;
    notifyListeners();

    try{
      if(searchValue != null) {
        _list = await _api.searchBook(searchValue);
        notifyListeners();
      } else {
        _list = await _api.getList();
        notifyListeners();
      }
      _loading = false;
    }catch(e) {
      _error = e.toString();
    }
    notifyListeners();
  }

  List<BookModel> get list => _list;
  bool get loading => _loading;
  String get error => _error;

}