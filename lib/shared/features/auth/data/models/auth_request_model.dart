/// Login request model
class LoginRequestModel {
  final String phone;
  final String password;
  final String? userType;

  LoginRequestModel({
    required this.phone,
    required this.password,
    this.userType,
  });

  Map<String, dynamic> toJson() {
    final map = {'phone': phone, 'password': password};

    if (userType != null && userType!.isNotEmpty) {
      map['user_type'] = userType!;
    }

    return map;
  }
}

/// Register technician request model
class RegisterTechnicianRequestModel {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;
  final String phone;
  // final String? specialty;

  RegisterTechnicianRequestModel({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.phone,
    // this.specialty,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'phone': phone,
    };
  }
}
