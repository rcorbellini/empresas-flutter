///Default (base) event of home
abstract class HomeEvent {}

///Event to call detail company
class HomeDetailEvent extends HomeEvent {
  ///Event to call detail company
  ///use [id] to open a company with that id.
  HomeDetailEvent(this.id);

  ///Id of Company
  final int id;
}
