import 'package:base_app/core/api_helper/api_result.dart';
import 'package:base_app/base/data/datasource/remote/exception/error_model.dart';
import 'package:base_app/features/auth/domain/repository/local_repo.dart';

class ClearUserDataUseCase {
  // final _tag = 'UserSubCategoriesViewModel';
  final LocalRepository _repository;
  ClearUserDataUseCase({
    required LocalRepository repository,
  }) : _repository = repository;
  Future<ApiResult> call() async {
    bool isCleared = await _repository.clearSharedData();

    if (isCleared) {
      return ApiResult.success(null);
    } else {
      return ApiResult.failure(const ErrorModel(code: ErrorEnum.messRequestData, errorMessage: 'error'));
    }
  }
}
