import 'package:practice_app/core/error/exceptions.dart';
import 'package:practice_app/features/auth/data/models/profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthSupabaseSource {
  Future<ProfileModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<ProfileModel> loginWithEmailPassword({
    required String email,
    required String password,
  });
}

class AuthSupabaseSourceImpl implements AuthSupabaseSource {
  final SupabaseClient supabaseClient;

  AuthSupabaseSourceImpl(this.supabaseClient);

  @override
  Future<ProfileModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw const ServerException("User is null");
      }

      return ProfileModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<ProfileModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {
          'name': name,
        },
      );

      if (response.user == null) {
        throw const ServerException("User is null");
      }

      return ProfileModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
