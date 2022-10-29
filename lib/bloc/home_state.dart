part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoaded extends HomeState{
  List<Topic> topic;

  HomeLoaded({required this.topic});
  @override
  List<Object?> get props => [topic];

}