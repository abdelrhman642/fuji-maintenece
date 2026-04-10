class HomeStatistics {
  final int technicians;
  final int requests;
  final int reports;
  final int customers;

  const HomeStatistics({
    required this.technicians,
    required this.requests,
    required this.reports,
    required this.customers,
  });

  static const empty = HomeStatistics(
    technicians: 0,
    requests: 0,
    reports: 0,
    customers: 0,
  );

  HomeStatistics copyWith({
    int? technicians,
    int? requests,
    int? reports,
    int? customers,
  }) {
    return HomeStatistics(
      technicians: technicians ?? this.technicians,
      requests: requests ?? this.requests,
      reports: reports ?? this.reports,
      customers: customers ?? this.customers,
    );
  }
}
