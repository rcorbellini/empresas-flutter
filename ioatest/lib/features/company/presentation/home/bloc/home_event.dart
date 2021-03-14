abstract class HomeEvent {}

class HomeDetailEvent extends HomeEvent {
  final int id;

  HomeDetailEvent(this.id);
}
