part of 'book_bloc.dart';

@freezed
class BookState with _$BookState{

  factory BookState.state({
    @Default([]) List<BookModel> list,
    @Default(EnumStatus.initial) EnumStatus status,
    @Default("") String error}) = _state;
}

enum EnumStatus { initial, loading, success, error }
