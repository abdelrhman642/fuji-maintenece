import 'package:equatable/equatable.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/orders/data/models/see_details_order_model.dart';

class SeeDetailsOrderState extends Equatable {
  const SeeDetailsOrderState();
  @override
  List<Object?> get props => [];
}

class SeeDetailsOrderInitial extends SeeDetailsOrderState {}

class SeeDetailsOrderLoading extends SeeDetailsOrderState {}

class SeeDetailsOrderLoaded extends SeeDetailsOrderState {
  final SeeDetailsOrderModel orderDetails;

  const SeeDetailsOrderLoaded(this.orderDetails);

  @override
  List<Object?> get props => [orderDetails];
}

class SeeDetailsOrderError extends SeeDetailsOrderState {
  final String message;

  const SeeDetailsOrderError(this.message);

  @override
  List<Object?> get props => [message];
}

class ReportPdfLoading extends SeeDetailsOrderState {}

class ReportPdfLoaded extends SeeDetailsOrderState {
  final String filePath;

  const ReportPdfLoaded(this.filePath);

  @override
  List<Object?> get props => [filePath];
}

class ReportPdfError extends SeeDetailsOrderState {
  final String message;

  const ReportPdfError(this.message);

  @override
  List<Object?> get props => [message];
}

class SeeDetailsOrderApproveInProgress extends SeeDetailsOrderState {}

class SeeDetailsOrderApproveSuccess extends SeeDetailsOrderState {
  final String message;

  const SeeDetailsOrderApproveSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class SeeDetailsOrderApproveFailure extends SeeDetailsOrderState {
  final String error;

  const SeeDetailsOrderApproveFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class SeeDetailsOrderRejectInProgress extends SeeDetailsOrderState {}

class SeeDetailsOrderRejectSuccess extends SeeDetailsOrderState {
  final String message;

  const SeeDetailsOrderRejectSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class SeeDetailsOrderRejectFailure extends SeeDetailsOrderState {
  final String error;

  const SeeDetailsOrderRejectFailure(this.error);

  @override
  List<Object?> get props => [error];
}
