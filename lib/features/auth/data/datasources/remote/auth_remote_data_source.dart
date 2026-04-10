abstract class AuthRemoteDataSource {
  Future<void> login(String phoneNumber, String password);
  Future<void> register({
    required String fullName,
    required String phoneNumber,
    required String password,
    String? email,
    String? address,
  });
}
