import 'package:base_app/core/api_helper/api_result.dart';
import 'package:base_app/features/common/domain/entity/home_data_entity.dart';
import 'package:base_app/features/common/domain/entity/home_entity.dart';
import 'package:base_app/features/common/domain/repository/common_repo.dart';

class GetHomeUseCase {
  final CommonRepository _repository;

  GetHomeUseCase({
    required CommonRepository repository,
  }) : _repository = repository;

  Future<ApiResult<List<HomeEntity>>> call() async => _repository.getHome();
}
