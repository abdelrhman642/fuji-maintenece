import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fuji_maintenance_system/core/models/report_model/report_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/contracts/data/models/contract_model/contract_model.dart';
import 'package:fuji_maintenance_system/interfaces/client/features/home/data/repositories/client_home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._repo) : super(HomeInitial());
  final ClientHomeRepo _repo;

  Future<void> fetchContracts() async {
    emit(HomeLoading());
    final result = await _repo.getMyContracts();
    result.fold(
      (failure) => emit(HomeError(failure.message)),
      (contracts) => emit(HomeContractsLoaded(contracts)),
    );
  }

  Future<void> fetchReports() async {
    emit(HomeLoading());
    final result = await _repo.getMyReports();
    result.fold(
      (failure) => emit(HomeError(failure.message)),
      (reports) => emit(HomeReportsLoaded(reports)),
    );
  }

  Future<void> fetchAllData() async {
    emit(HomeLoading());
    final contractsResult = await _repo.getMyContracts();
    final reportsResult = await _repo.getMyReports();

    contractsResult.fold((failure) => emit(HomeError(failure.message)), (
      contracts,
    ) {
      reportsResult.fold(
        (failure) => emit(HomeError(failure.message)),
        (reports) => emit(HomeLoaded(contracts: contracts, reports: reports)),
      );
    });
  }
}
