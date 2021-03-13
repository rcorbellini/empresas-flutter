import 'package:ioatest/features/company/domain/models/company.dart';

abstract class HomeEvent {}

class HomeDetailEvent extends HomeEvent {
  final int id;

  HomeDetailEvent(this.id);
} 