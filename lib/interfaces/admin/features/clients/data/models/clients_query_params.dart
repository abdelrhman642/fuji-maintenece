class ClientsQueryParams {
  final int? cityId;
  final int? neighborhoodId;

  ClientsQueryParams({required this.cityId, required this.neighborhoodId});

  Map<String, dynamic> toJson() {
    return {'city_id': cityId, 'neighborhood_id': neighborhoodId};
  }
}
