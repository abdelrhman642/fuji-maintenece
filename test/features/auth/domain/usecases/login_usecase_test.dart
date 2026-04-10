import 'package:dartz/dartz.dart';
import 'package:flutter_project/core/error/failures.dart';
import 'package:flutter_project/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_project/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_usecase_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late LoginUseCase usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = LoginUseCase(mockAuthRepository);
  });

  const tPhoneNumber = '1234567890';
  const tPassword = 'password';

  test('should get void from the repository', () async {
    // arrange
    when(
      mockAuthRepository.login(any, any),
    ).thenAnswer((_) async => const Right(null));
    // act
    final result = await usecase(tPhoneNumber, tPassword);
    // assert
    expect(result, const Right(null));
    verify(mockAuthRepository.login(tPhoneNumber, tPassword));
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should get server failure from the repository', () async {
    // arrange
    when(
      mockAuthRepository.login(any, any),
    ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    final result = await usecase(tPhoneNumber, tPassword);
    // assert
    expect(result, Left(ServerFailure('Server Failure')));
    verify(mockAuthRepository.login(tPhoneNumber, tPassword));
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
