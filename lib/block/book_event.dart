part of 'book_bloc.dart';

@immutable
abstract class BookEvent {}

class LoadDataEvent extends BookEvent{
  String? searchValue;

  LoadDataEvent(this.searchValue);

}

class SearchEvent extends BookEvent {
  String searchValue;

  SearchEvent(this.searchValue);

}
