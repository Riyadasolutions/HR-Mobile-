import 'package:base_app/core/api_helper/api_result.dart';
import 'package:base_app/features/common/domain/parameters/contact_us_parameters.dart';
import 'package:base_app/features/common/domain/repository/common_repo.dart';

class ContactUsUseCase {
  final CommonRepository _repository;

  ContactUsUseCase({
    required CommonRepository repository,
  }) : _repository = repository;

  Future<ApiResult> call({required ContactUsParameters parameters}) async =>
      _repository.contactUs(parameters: parameters);
}
