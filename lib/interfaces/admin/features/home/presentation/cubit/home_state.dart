import 'package:fuji_maintenance_system/interfaces/admin/features/home/domain/models/chart_data.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/home/domain/models/home_statistics.dart';

abstract class HomeState {
  const HomeState();

  static HomeState initial() => const HomeInitialState();
  static HomeState loading() => const HomeLoadingState();
  static HomeState loaded({
    required HomeStatistics statistics,
    required List<ChartData> chartData,
    required ChartType selectedChartType,
    required double visitsProgress,
    required double reportsProgress,
    List<String>? chartLabels,
  }) => HomeLoadedState(
    statistics: statistics,
    chartData: chartData,
    selectedChartType: selectedChartType,
    visitsProgress: visitsProgress,
    reportsProgress: reportsProgress,
    chartLabels: chartLabels,
  );
  static HomeState error(String message) => HomeErrorState(message);
}

class HomeInitialState extends HomeState {
  const HomeInitialState();
}

class HomeLoadingState extends HomeState {
  const HomeLoadingState();
}

class HomeLoadedState extends HomeState {
  final HomeStatistics statistics;
  final List<ChartData> chartData;
  final ChartType selectedChartType;
  final double visitsProgress;
  final double reportsProgress;
  final List<String>? chartLabels;

  const HomeLoadedState({
    required this.statistics,
    required this.chartData,
    required this.selectedChartType,
    required this.visitsProgress,
    required this.reportsProgress,
    this.chartLabels,
  });

  HomeLoadedState copyWith({
    HomeStatistics? statistics,
    List<ChartData>? chartData,
    ChartType? selectedChartType,
    double? visitsProgress,
    double? reportsProgress,
    List<String>? chartLabels,
  }) {
    return HomeLoadedState(
      statistics: statistics ?? this.statistics,
      chartData: chartData ?? this.chartData,
      selectedChartType: selectedChartType ?? this.selectedChartType,
      visitsProgress: visitsProgress ?? this.visitsProgress,
      reportsProgress: reportsProgress ?? this.reportsProgress,
      chartLabels: chartLabels ?? this.chartLabels,
    );
  }

  List<double> get currentChartData {
    return chartData
        .firstWhere((chart) => chart.type == selectedChartType)
        .data;
  }
}

class HomeErrorState extends HomeState {
  final String message;

  const HomeErrorState(this.message);
}
