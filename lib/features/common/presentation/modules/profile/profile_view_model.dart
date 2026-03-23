
import 'package:base_app/core/api_helper/api_result.dart';
import 'package:base_app/base/presentation/component/inputs/country/countries.dart';
import 'package:base_app/core/constants/constants.dart';
import 'package:base_app/core/constants/enums.dart';
import 'package:base_app/core/constants/globals.dart';
import 'package:base_app/core/utils/logger.dart';
import 'package:base_app/features/auth/domain/entity/profile_entity.dart';

import 'package:base_app/features/auth/domain/parameters/profile_parameters.dart';
import 'package:base_app/features/common/domain/usecase/profile/update_profile_usecase.dart';
import 'package:flutter/material.dart';




class ProfileViewModel extends ChangeNotifier {
  final UpdateProfileUseCase _updateProfileUseCase;

  ProfileViewModel({
    required UpdateProfileUseCase updateProfileUseCase,
  })  :
        _updateProfileUseCase = updateProfileUseCase;

  ///Variables
 late ProfileParameters _parameters;
  bool _isLoading = false;
  bool _isUploadImageLoading = false;

  ///Getters
  ProfileParameters get parameters => _parameters;
  bool get isLoading => _isLoading;
  bool get isUploadImageLoading => _isUploadImageLoading;

  void init() {
  var ss =  countries.firstWhere((item) => item.dialCode == (kUser?.mobileCode ?? '966'), orElse: () => Constants.initMobileCountry);
  log('ProfileParameters', '${ss.dialCode} , ${kUser?.mobileCode}');
  _parameters=ProfileParameters.initUser();
  }

  ///On update/change
  // onUpdateImage(String? value){_parameters.image = value; notifyListeners();}
  onUpdateMobileCountryCode(Country value){_parameters.mobileCountry = value; notifyListeners();}
  onUpdateGender(GenderType gender) {_parameters.gender=gender;notifyListeners();}


  //UpLoad image
  upLoadAttachment(String path) async {_parameters.setImage(path);notifyListeners();}

  // Update User Profile
  Future<ApiResult<ProfileEntity>> updateProfile({required String email,required String mobile,required String name}) async {
    _parameters.setData(email: email, mobile: mobile, name: name);
    _isLoading = true;
    notifyListeners();
    ApiResult<ProfileEntity> responseModel = await _updateProfileUseCase.call(parameters: _parameters);
    if (responseModel.isSuccess) {
      kUser = (responseModel as Success<ProfileEntity>).data;
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }


}
