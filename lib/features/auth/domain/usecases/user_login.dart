import 'package:fpdart/fpdart.dart';
import 'package:practice_app/core/error/failures.dart';
import 'package:practice_app/core/usecase/usecase.dart';
import 'package:practice_app/core/common/entities/profile.dart';
import 'package:practice_app/features/auth/domain/repository/auth_repository.dart';

class UserLogin implements UseCase<Profile, UserLoginParams> {
  final AuthRepository authRepository;

  const UserLogin(this.authRepository);

  @override
  Future<Either<Failure, Profile>> call(UserLoginParams params) async {
    return await authRepository.loginWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({required this.email, required this.password});
}
