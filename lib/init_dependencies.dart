import 'package:get_it/get_it.dart';
import 'package:practice_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:practice_app/core/secrets/supabase_secrets.dart';
import 'package:practice_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:practice_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:practice_app/features/auth/domain/repository/auth_repository.dart';
import 'package:practice_app/features/auth/domain/usecases/current_user.dart';
import 'package:practice_app/features/auth/domain/usecases/user_login.dart';
import 'package:practice_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:practice_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();

  final supabase = await Supabase.initialize(
    url: SupabaseSecrets.supabaseUrl,
    anonKey: SupabaseSecrets.anonKey,
  );

  serviceLocator.registerLazySingleton(() => supabase.client);

  // core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  serviceLocator
    // Data source
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )

    // Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
      ),
    )

    // Use cases
    ..registerFactory(
      () => UserSignUp(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserLogin(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => CurrentUser(
        serviceLocator(),
      ),
    )

    // Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}
