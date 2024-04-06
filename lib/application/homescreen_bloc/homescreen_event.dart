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

class SearchEvent extends HomeScreenEvent {}

class SortClickedEvent extends HomeScreenEvent {
  final int index;

  SortClickedEvent({required this.index});
}
