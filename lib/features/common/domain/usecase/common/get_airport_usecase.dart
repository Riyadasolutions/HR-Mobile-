

import 'package:base_app/base/domain/entities/drop_down_entity.dart';
import 'package:base_app/core/api_helper/api_result.dart';
import 'package:base_app/features/common/domain/repository/common_repo.dart';



class GetAirportsUseCase{

  final CommonRepository _repository;

  const GetAirportsUseCase({
    required CommonRepository repository,
  }) : _repository = repository;

  Future<ApiResult<List<DropDownEntity>>> call({required int countryId}) async => await _repository.getAirport(countryId: countryId);

}
