import 'dart:convert';

import 'chart_data.dart';
import 'daily_completion.dart';
import 'filters_applied.dart';
import 'overview_cards.dart';

class AdminHomeStatisticsModel {
  OverviewCards? overviewCards;
  ChartData? chartData;
  DailyCompletion? dailyCompletion;
  FiltersApplied? filtersApplied;

  AdminHomeStatisticsModel({
    this.overviewCards,
    this.chartData,
    this.dailyCompletion,
    this.filtersApplied,
  });

  @override
  String toString() {
    return 'AdminHomeStatisticsModel(overviewCards: $overviewCards, chartData: $chartData, dailyCompletion: $dailyCompletion, filtersApplied: $filtersApplied)';
  }

  factory AdminHomeStatisticsModel.fromMap(Map<String, dynamic> data) {
    return AdminHomeStatisticsModel(
      overviewCards:
          data['overview_cards'] == null
              ? null
              : OverviewCards.fromMap(
                data['overview_cards'] as Map<String, dynamic>,
              ),
      chartData:
          data['chart_data'] == null
              ? null
              : ChartData.fromMap(data['chart_data'] as Map<String, dynamic>),
      dailyCompletion:
          data['daily_completion'] == null
              ? null
              : DailyCompletion.fromMap(
                data['daily_completion'] as Map<String, dynamic>,
              ),
      filtersApplied:
          data['filters_applied'] == null
              ? null
              : FiltersApplied.fromMap(
                data['filters_applied'] as Map<String, dynamic>,
              ),
    );
  }

  Map<String, dynamic> toMap() => {
    'overview_cards': overviewCards?.toMap(),
    'chart_data': chartData?.toMap(),
    'daily_completion': dailyCompletion?.toMap(),
    'filters_applied': filtersApplied?.toMap(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AdminHomeStatisticsModel].
  factory AdminHomeStatisticsModel.fromJson(String data) {
    return AdminHomeStatisticsModel.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// `dart:convert`
  ///
  /// Converts [AdminHomeStatisticsModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
