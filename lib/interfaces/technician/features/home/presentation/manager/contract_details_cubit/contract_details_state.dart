part of 'contract_details_cubit.dart';

sealed class ContractDetailsState extends Equatable {
  const ContractDetailsState();

  @override
  List<Object> get props => [];
}

final class ContractDetailsInitial extends ContractDetailsState {}

final class ContractDetailsLoading extends ContractDetailsState {}

final class ContractDetailsLoaded extends ContractDetailsState {
  final ContractDetailsModel contractDetails;
  const ContractDetailsLoaded(this.contractDetails);
}

final class ContractDetailsError extends ContractDetailsState {
  final String message;
  const ContractDetailsError(this.message);
}
