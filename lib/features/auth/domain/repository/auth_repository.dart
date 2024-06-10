import 'package:fpdart/fpdart.dart';
import 'package:practice_app/core/error/failures.dart';
import 'package:practice_app/core/common/entities/profile.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, Profile>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, Profile>> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, Profile>> currentUser();
}
