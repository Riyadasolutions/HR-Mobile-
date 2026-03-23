
import 'package:base_app/base/data/model/base/response_model.dart';

import '../../../repository/local_repo.dart';

class GetUserCurrencyUseCase {
  final LocalRepository _repository;
  GetUserCurrencyUseCase({
    required LocalRepository repository,
  }) : _repository = repository;

  ResponseModel call()  {
    String symbol =  _repository.getCurrency();

    return ResponseModel(true, 'successful',data: symbol);

  }


}
