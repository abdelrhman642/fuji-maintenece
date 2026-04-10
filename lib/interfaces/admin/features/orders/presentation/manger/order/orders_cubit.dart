import 'package:bloc/bloc.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/orders/data/repositories/order_repositories.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/orders/presentation/manger/order/orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit(this._repo) : super(OrdersInitial());

  final OrderRepository _repo;

  Future<void> fetchOrders() async {
    emit(OrdersLoading());
    final response = await _repo.fetchOrders();
    response.fold(
      (failure) => emit(OrdersError(failure.message)),
      (orders) => emit(OrdersLoaded(orders)),
    );
  }

  Future<void> exportReportAsPdf(int reportId) async {
    emit(ReportPdfLoading());
    final response = await _repo.exportReportAsPdf(reportId);
    response.fold(
      (failure) => emit(ReportPdfError(failure.message)),
      (filePath) => emit(ReportPdfLoaded(filePath)),
    );
  }

  Future<void> createOrder(Map<String, dynamic> orderData) async {
    emit(OrdersCreateInProgress());

    final response = await _repo.createOrder(orderData);
    return response.fold(
      (failure) {
        emit(OrdersCreateFailure(failure.message));
      },
      (result) {
        emit(OrdersCreateSuccess(result));
      },
    );
  }

  Future<void> updateOrder(Map<String, dynamic> orderData) async {
    emit(OrdersUpdateInProgress());

    final response = await _repo.updateOrder(orderData);
    return response.fold(
      (failure) {
        emit(OrdersUpdateFailure(failure.message));
      },
      (result) {
        emit(OrdersUpdateSuccess(result));
      },
    );
  }
}
