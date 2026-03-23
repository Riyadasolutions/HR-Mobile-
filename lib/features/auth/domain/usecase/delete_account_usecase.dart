import 'package:base_app/core/api_helper/api_result.dart';
import 'package:base_app/features/auth/domain/repository/auth_repo.dart';

class DeleteAccountUseCase{
  final AuthRepository _repository;

  const DeleteAccountUseCase({
    required AuthRepository repository,
  }) : _repository = repository;

Future<ApiResult> call() async => await _repository.deleteAccount();

}
