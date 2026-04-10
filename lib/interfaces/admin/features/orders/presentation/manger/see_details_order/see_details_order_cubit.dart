import 'package:bloc/bloc.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/orders/data/repositories/see_details_repositories.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/orders/presentation/manger/see_details_order/see_details_order_state.dart';

class SeeDetailsOrderCubit extends Cubit<SeeDetailsOrderState> {
  SeeDetailsOrderCubit(this._repo) : super(SeeDetailsOrderInitial());

  final SeeDetailsRepository _repo;

  Future<void> fetchOrderDetails(int orderId) async {
    emit(SeeDetailsOrderLoading());
    final response = await _repo.fetchOrderDetails(orderId);
    response.fold(
      (failure) => emit(SeeDetailsOrderError(failure.message)),
      (orderDetails) => emit(SeeDetailsOrderLoaded(orderDetails)),
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

  Future<void> approveOrder(int orderId, String note) async {
    emit(SeeDetailsOrderApproveInProgress());

    final response = await _repo.approveOrder(orderId, note);
    return response.fold(
      (failure) {
        emit(SeeDetailsOrderApproveFailure(failure.message));
      },
      (result) {
        emit(SeeDetailsOrderApproveSuccess(result));
      },
    );
  }

  Future<void> rejectOrder(int orderId, String reason) async {
    emit(SeeDetailsOrderRejectInProgress());

    final response = await _repo.rejectOrder(orderId, reason);
    return response.fold(
      (failure) {
        emit(SeeDetailsOrderRejectFailure(failure.message));
      },
      (result) {
        emit(SeeDetailsOrderRejectSuccess(result));
      },
    );
  }
}
