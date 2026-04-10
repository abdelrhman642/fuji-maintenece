part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<ContractModel> contracts;
  final List<ReportModel> reports;

  const HomeLoaded({required this.contracts, required this.reports});

  @override
  List<Object> get props => [contracts, reports];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object> get props => [message];
}

class HomeContractsLoaded extends HomeState {
  final List<ContractModel> contracts;

  const HomeContractsLoaded(this.contracts);

  @override
  List<Object> get props => [contracts];
}

class HomeReportsLoaded extends HomeState {
  final List<ReportModel> reports;

  const HomeReportsLoaded(this.reports);
  @override
  List<Object> get props => [reports];
}
