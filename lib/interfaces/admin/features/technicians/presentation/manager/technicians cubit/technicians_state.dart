part of 'technicians_cubit.dart';

abstract class TechniciansState extends Equatable {
  const TechniciansState();

  @override
  List<Object> get props => [];
}

class TechniciansInitial extends TechniciansState {}

class TechniciansLoading extends TechniciansState {}

class TechniciansLoaded extends TechniciansState {
  final List<TechnicianModel> technicians;

  const TechniciansLoaded(this.technicians);

  @override
  List<Object> get props => [technicians];
}

class TechniciansError extends TechniciansState {
  final String message;

  const TechniciansError(this.message);

  @override
  List<Object> get props => [message];
}

class TechniciansUpdateLoading extends TechniciansState {
  const TechniciansUpdateLoading();

  @override
  List<Object> get props => [];
}

class TechniciansUpdateSuccess extends TechniciansState {
  final String message;

  const TechniciansUpdateSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class TechniciansUpdateError extends TechniciansState {
  final String message;

  const TechniciansUpdateError(this.message);

  @override
  List<Object> get props => [message];
}

class TechniciansEditLoading extends TechniciansState {
  const TechniciansEditLoading();

  @override
  List<Object> get props => [];
}

class TechniciansEditSuccess extends TechniciansState {
  final String message;

  const TechniciansEditSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class TechniciansEditError extends TechniciansState {
  final String message;

  const TechniciansEditError(this.message);

  @override
  List<Object> get props => [message];
}
