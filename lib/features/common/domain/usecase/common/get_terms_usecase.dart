import 'package:base_app/core/api_helper/api_result.dart';
import 'package:base_app/features/common/domain/entity/terms_entity.dart';
import 'package:base_app/features/common/domain/repository/common_repo.dart';

class GetTermsUseCase {
  final CommonRepository _repository;

  GetTermsUseCase({
    required CommonRepository repository,
  }) : _repository = repository;

  Future<ApiResult<TermsEntity>> call() async => _repository.getTerms();
}
