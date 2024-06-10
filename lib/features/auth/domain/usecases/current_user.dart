import 'package:fpdart/fpdart.dart';
import 'package:practice_app/core/error/failures.dart';
import 'package:practice_app/core/usecase/usecase.dart';
import 'package:practice_app/core/common/entities/profile.dart';
import 'package:practice_app/features/auth/domain/repository/auth_repository.dart';

class CurrentUser implements UseCase<Profile, NoParams> {
  final AuthRepository authRepository;

  CurrentUser(this.authRepository);

  @override
  Future<Either<Failure, Profile>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}