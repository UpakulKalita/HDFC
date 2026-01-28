import 'package:insurance_flutter/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:insurance_flutter/features/auth/domain/entities/user.dart';
import 'package:insurance_flutter/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({required this.localDataSource});

  @override
  Future<User> login({
    required String email,
    required String password,
    String? captchaToken,
  }) async {
    return await localDataSource.login(
      email: email,
      password: password,
      captchaToken: captchaToken,
    );
  }

  @override
  Future<void> logout() async {
    await localDataSource.logout();
  }
}
