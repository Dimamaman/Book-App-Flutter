part of 'book_bloc.dart';

@immutable
class BookState {
  final List<BookModel> list;
  final EnumStatus status;
  final String message;

  const BookState({
    this.list = const [],
    this.status = EnumStatus.initial,
    this.message = "",
  });

  BookState copyWith({
    List<BookModel>? list,
    EnumStatus? status,
    String? message,
}) {
    return BookState(
      list: list ?? this.list,
      status: status ?? this.status,
      message: message ?? this.message
    );
  }
}

enum EnumStatus { initial, loading, success, error }
