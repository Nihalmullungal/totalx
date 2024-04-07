import 'package:cloud_firestore/cloud_firestore.dart';

abstract class HomeScreenEvent {}

class LogoutClickedEvent extends HomeScreenEvent {}

class ImageSelectedEvent extends HomeScreenEvent {
  // final String imgselected;
}

class HomeScreenStartedEvent extends HomeScreenEvent {}

class NameFieldErrorEvent extends HomeScreenEvent {}

class AgeFieldErrorEvent extends HomeScreenEvent {}

class ImageNotAddedEvent extends HomeScreenEvent {}

class SaveClickedEvent extends HomeScreenEvent {}

class ShowUserEvent extends HomeScreenEvent {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> val;
  ShowUserEvent({required this.val});
}

class SearchEvent extends HomeScreenEvent {}

class SortClickedEvent extends HomeScreenEvent {
  final int index;

  SortClickedEvent({required this.index});
}
