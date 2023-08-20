
import 'package:book_app_flutter/core/api/book_model.dart';
import 'package:dio/dio.dart';

class BookApi {
  final _dio = Dio(BaseOptions(
    baseUrl: 'https://run.mocky.io/v3/',
    validateStatus: (status) => true
  ));

  Future<List<BookModel>> getList() async {
    final response = await _dio.get('1d5d1164-0961-45a9-bb55-f12c7708000e');
    return (response.data['books'] as List).map((e) => BookModel.fromJson(e)).toList();
  }

  Future<BookModel> getBookById(String id) async {
    final response = await _dio.get(id);
    return BookModel.fromJson(response.data);
  }

  Future<List<BookModel>> searchBook(String searchValue) async {

    var result = <BookModel>[];
    final response = await _dio.get('1d5d1164-0961-45a9-bb55-f12c7708000e');
    var list = (response.data['books'] as List).map((e) => BookModel.fromJson(e)).toList();

    for(BookModel bookModel in list) {
      if(bookModel.name.toLowerCase().contains(searchValue) || bookModel.author.toLowerCase().contains(searchValue)) {
        result.add(bookModel);
      }
    }

    return result;
  }
}