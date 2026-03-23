
import 'package:base_app/core/api_helper/api_result.dart';
import 'package:base_app/base/data/datasource/remote/exception/error_model.dart';
import '../../../../auth/domain/repository/local_repo.dart';

class GetUserTokenUseCase {
  // final _tag = 'GetUserTokenDataUseCase';
  final LocalRepository _repository;

  GetUserTokenUseCase({
    required LocalRepository repository,
  }) : _repository = repository;
  Future<ApiResult<String>> call() async {
    String token =await _repository.getUserToken();

    if (token.isNotEmpty) {
      return ApiResult.success(token);
    } else {
      return ApiResult.failure(ErrorModel(code: ErrorEnum.other, errorMessage: 'error'));
    }
  }

}
