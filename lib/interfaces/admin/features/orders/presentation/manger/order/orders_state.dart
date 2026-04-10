import 'package:equatable/equatable.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/orders/data/models/order_model.dart';

class OrdersState extends Equatable {
  const OrdersState();
  @override
  List<Object?> get props => [];
}

class OrdersInitial extends OrdersState {}

class OrdersLoading extends OrdersState {}

class OrdersLoaded extends OrdersState {
  final OrdersModel orders;

  const OrdersLoaded(this.orders);

  @override
  List<Object?> get props => [orders];
}

class OrdersError extends OrdersState {
  final String message;

  const OrdersError(this.message);

  @override
  List<Object?> get props => [message];
}

class ReportPdfLoading extends OrdersState {}

class ReportPdfLoaded extends OrdersState {
  final String filePath;

  const ReportPdfLoaded(this.filePath);

  @override
  List<Object?> get props => [filePath];
}

class ReportPdfError extends OrdersState {
  final String message;

  const ReportPdfError(this.message);

  @override
  List<Object?> get props => [message];
}

class OrdersCreateInProgress extends OrdersState {}

class OrdersCreateSuccess extends OrdersState {
  final dynamic result;

  const OrdersCreateSuccess(this.result);

  @override
  List<Object?> get props => [result];
}

class OrdersCreateFailure extends OrdersState {
  final String error;

  const OrdersCreateFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class OrdersUpdateInProgress extends OrdersState {}

class OrdersUpdateSuccess extends OrdersState {
  final dynamic result;

  const OrdersUpdateSuccess(this.result);

  @override
  List<Object?> get props => [result];
}

class OrdersUpdateFailure extends OrdersState {
  final String error;

  const OrdersUpdateFailure(this.error);

  @override
  List<Object?> get props => [error];
}
