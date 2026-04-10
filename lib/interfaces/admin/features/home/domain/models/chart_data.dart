enum ChartType {
  customers,
  technicians,
  reports;

  String get title {
    switch (this) {
      case ChartType.customers:
        return 'customers';
      case ChartType.technicians:
        return 'technicians';
      case ChartType.reports:
        return 'reports';
    }
  }
}

class ChartData {
  final ChartType type;
  final List<double> data;

  const ChartData({required this.type, required this.data});

  static const List<ChartData> defaultData = [
    ChartData(
      type: ChartType.customers,
      data: [6, 7, 4, 3, 8, 7, 5, 6, 4, 9, 6, 8],
    ),
    ChartData(
      type: ChartType.technicians,
      data: [4, 5, 6, 2, 7, 5, 3, 4, 6, 7, 4, 6],
    ),
    ChartData(
      type: ChartType.reports,
      data: [8, 6, 5, 7, 9, 8, 7, 8, 5, 10, 7, 9],
    ),
  ];
}
