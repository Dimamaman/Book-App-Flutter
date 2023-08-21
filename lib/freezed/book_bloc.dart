import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_app_flutter/block/book_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';

import '../core/api/book_api.dart';
import '../core/api/book_model.dart';

part 'book_event.dart';
part 'book_state.dart';
part 'book_bloc.freezed.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final BookApi _api;
  BookBloc(this._api) : super(BookState.state()) {
    on<BookEvent>((event, emit) async {
      switch(event) {
        case _loadData():
          await _onLoadData(event,emit,event.searchValue);
          break;
      }
    });
  }

  Future<void> _onLoadData(_loadData event, Emitter<BookState> emit, String? searchValue) async {
    if (state.status == EnumStatus.loading) return;

    emit(BookState.state(status: EnumStatus.loading));

    try {
      if (searchValue != null) {
        emit(BookState.state(list: await _api.searchBook(searchValue), status: EnumStatus.success));
      } else {
        emit(BookState.state(list: await _api.getList(), status: EnumStatus.success));
      }
    } catch (e) {
      emit(BookState.state(status: EnumStatus.error,error: "$e"));
    }

  }
}








