import 'package:base_app/core/api_helper/api_result.dart';
import 'package:base_app/features/common/domain/entity/privacy_entity.dart';
import 'package:base_app/features/common/domain/repository/common_repo.dart';

class GetPrivacyUseCase {
  final CommonRepository _repository;

  GetPrivacyUseCase({
    required CommonRepository repository,
  }) : _repository = repository;

  Future<ApiResult<PrivacyEntity>> call() async => _repository.getPrivacy();
}
