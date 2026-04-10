part of 'visits_cubit.dart';

/// Base state class for visits feature
abstract class VisitsState extends Equatable {
  const VisitsState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class VisitsInitial extends VisitsState {
  const VisitsInitial();
}
