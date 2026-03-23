import 'package:base_app/core/api_helper/api_result.dart';
import 'package:base_app/base/data/datasource/remote/exception/error_model.dart';
import 'package:base_app/features/auth/domain/repository/local_repo.dart';

class GetIsFirstTimeUseCase {
  final LocalRepository _repository;
  GetIsFirstTimeUseCase({
    required LocalRepository repository,
  }) : _repository = repository;

  ApiResult call()  {
    bool isFirstTime =  _repository.getIsFirstTime();

    if (isFirstTime) {
      return ApiResult.success(true);
    } else {
      return ApiResult.failure(const ErrorModel(code: ErrorEnum.messRequestData, errorMessage: 'error'));
    }
  }
}
