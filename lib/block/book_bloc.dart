import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/api/book_api.dart';
import '../core/api/book_model.dart';

part 'book_event.dart';

part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final BookApi _api;

  BookBloc(this._api) : super(BookState()) {
    on<BookEvent>((event, emit) async {
      switch (event) {
        case LoadDataEvent():
          await _onLoadData(event, emit, event.searchValue);
          break;
      }
    });
  }

  Future<void> _onLoadData(
      LoadDataEvent event, Emitter<BookState> emit, String? searchValue) async {
    if (state.status == EnumStatus.loading) return;

    emit(state.copyWith(status: EnumStatus.loading));

    try {
      if (searchValue != null) {
        emit(state.copyWith(
          status: EnumStatus.success,
          list: await _api.searchBook(searchValue),
        ));
      } else {
        emit(state.copyWith(
          status: EnumStatus.success,
          list: await _api.getList(),
        ));
      }
    } catch (e) {
      emit(state.copyWith(status: EnumStatus.error, message: "$e"));
    }
  }

/*Future<void> _onSearchData(String searchValue, SearchEvent event, Emitter<BookState> emit) async {
    if (state.status == EnumStatus.loading) return;
    emit(state.copyWith(status: EnumStatus.loading));
    try {
      final list = <BookModel>[];
      list.addAll(state.list);
      list.addAll(await _api.getList());

      final result = list;

      for(BookModel bookModel in list) {
        if(bookModel.name.toLowerCase().contains(searchValue) || bookModel.author.toLowerCase().contains(searchValue)) {
          result.add(bookModel);
        }
      }

      print("List -> $result");
      print("BBBBBBBBBBB -> $searchValue");

      emit(state.copyWith(
        status: EnumStatus.success,
        list: result,
      ));
    } catch (e) {
      emit(state.copyWith(status: EnumStatus.error, message: "$e"));
    }
  }*/
}
