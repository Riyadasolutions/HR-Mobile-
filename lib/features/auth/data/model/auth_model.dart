
import 'package:base_app/features/auth/data/model/profile_model.dart';
import 'package:base_app/features/auth/domain/entity/auth_entity.dart';

class AuthModel {

  final String _token;
  final ProfileModel _user;

  factory AuthModel.fromJson(Map<String, dynamic>? json) {
    return AuthModel(
      token: (json?["data"] ?? {})["token"] ?? '',
      user: ProfileModel.fromJson(json?["data"] ?? {}),
    );
  }

  AuthEntity toEntity() => AuthEntity(token: this._token, user: this._user.toEntity());

  const AuthModel({
    required String token,
    required ProfileModel user,
  })  : _token = token,
        _user = user;
}
