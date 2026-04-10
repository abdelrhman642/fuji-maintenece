import 'package:bloc/bloc.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/home/data/repositories/admin_home_repo.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/home/domain/models/chart_data.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/home/domain/models/home_statistics.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/home/presentation/cubit/home_state.dart';

/// A Cubit responsible for loading admin home data from the [AdminHomeRepo]
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._repo) : super(HomeState.initial());

  final AdminHomeRepo _repo;

  /// Load home data from repository and emit corresponding states.
  Future<void> loadHomeData() async {
    emit(HomeState.loading());

    try {
      final result = await _repo.getAdminHomeStatistics();
      result.fold((failure) => emit(HomeState.error(failure.message)), (model) {
        final overview = model.overviewCards;

        final statistics = HomeStatistics(
          technicians: overview?.technicians?.count ?? 0,
          requests: overview?.requests?.count ?? 0,
          reports: overview?.reports?.count ?? 0,
          customers: overview?.clients?.count ?? 0,
        );

        // Map backend chart structure to domain ChartData
        final chartDatasets = model.chartData?.datasets ?? [];
        final List<ChartData> chartData = [];

        // Process each dataset from backend
        for (final ds in chartDatasets) {
          final label = (ds.label ?? '').toLowerCase();
          ChartType? type;

          if (label.contains('تقارير') || label.contains('report')) {
            type = ChartType.reports;
          } else if (label.contains('فني') || label.contains('technician')) {
            type = ChartType.technicians;
          } else if (label.contains('عميل') ||
              label.contains('عملاء') ||
              label.contains('client') ||
              label.contains('customer')) {
            type = ChartType.customers;
          }

          if (type != null) {
            final dataList =
                (ds.data ?? <dynamic>[]).map<double>((e) {
                  if (e is num) return e.toDouble();
                  final parsed = double.tryParse(e?.toString() ?? '0');
                  return parsed ?? 0.0;
                }).toList();

            chartData.add(ChartData(type: type, data: dataList));
          }
        }

        // Ensure we have data for all chart types (use default if missing)
        for (final type in ChartType.values) {
          if (!chartData.any((chart) => chart.type == type)) {
            chartData.add(ChartData(type: type, data: List.filled(7, 0.0)));
          }
        }

        double visitsProgress = 0.0;
        double reportsProgress = 0.0;

        final visitsVal = model.dailyCompletion?.visits?.value;
        if (visitsVal != null) {
          visitsProgress = (visitsVal / 100).clamp(0.0, 1.0);
        }

        final reportsVal = model.dailyCompletion?.reports?.count;
        if (reportsVal != null) {
          reportsProgress = (reportsVal / 100).clamp(0.0, 1.0);
        }

        // Extract chart labels from backend
        final chartLabels = model.chartData?.labels;

        emit(
          HomeState.loaded(
            statistics: statistics,
            chartData: chartData,
            selectedChartType: ChartType.customers,
            visitsProgress: visitsProgress,
            reportsProgress: reportsProgress,
            chartLabels: chartLabels,
          ),
        );
      });
    } catch (e) {
      emit(HomeState.error(e.toString()));
    }
  }

  void selectChartType(ChartType type) {
    final current = state;
    if (current is HomeLoadedState) {
      emit(current.copyWith(selectedChartType: type));
    }
  }

  Future<void> refreshData() async {
    await loadHomeData();
  }
}
