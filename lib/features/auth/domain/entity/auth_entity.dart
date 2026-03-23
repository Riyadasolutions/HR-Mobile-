import 'package:base_app/features/auth/domain/entity/profile_entity.dart';
import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String _token;
  final ProfileEntity _user;

  @override
  List<Object> get props => [
        _token,
        _user,
      ];

  const AuthEntity({
    required String token,
    required ProfileEntity user,
  })  : _token = token,
        _user = user;

  ProfileEntity get user => _user;

  String get token => _token;
}
