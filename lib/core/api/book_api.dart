
import 'package:dio/dio.dart';

class BookApi {
  final _dio = Dio(BaseOptions(
    baseUrl: 'https://run.mocky.io/v3/',
    validateStatus: (status) => true
  ));

  Future<List> getList() async {
    final response = await _dio.get('1d5d1164-0961-45a9-bb55-f12c7708000e');
    return response.data['books'];
  }

  Future<Map> getBookById(String id) async{
    final response = await _dio.get(id);
    return response.data;
  }
}