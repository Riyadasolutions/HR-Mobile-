
import 'package:base_app/base/data/model/base/response_model.dart';

import '../../../repository/local_repo.dart';

class SaveUserCurrencyUseCase {

  final LocalRepository _repository;

  const SaveUserCurrencyUseCase({
    required LocalRepository repository,
  }) : _repository = repository;

  Future<ResponseModel> call({required String symbol}) async {

    bool? isSave = await _repository.saveCurrency(symbol);
    if (isSave ) {
      return ResponseModel(true, 'successful');
    } else {
      return ResponseModel(false, 'error');
    }
  }


}
