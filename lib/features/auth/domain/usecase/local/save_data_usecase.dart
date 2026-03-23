import 'package:base_app/core/utils/logger.dart';
import 'package:base_app/core/api_helper/api_result.dart';
import 'package:base_app/base/data/datasource/remote/exception/error_model.dart';
import '../../../../auth/domain/repository/local_repo.dart';

class SaveUserDataUseCase {

  final LocalRepository _repository;

  const SaveUserDataUseCase({

    required LocalRepository repository,
  }) : _repository = repository;


  Future<ApiResult> call({required String token}) async {

    bool? isSaveToken = await _repository.saveSecuredData(token);
    log('SaveUserDataUseCase', 'isSaveToken==>$isSaveToken==>$token');
    if (isSaveToken ) {
      return ApiResult.success(null);
    } else {
      return ApiResult.failure(ErrorModel(code: ErrorEnum.other, errorMessage: 'error'));
    }
  }


}
