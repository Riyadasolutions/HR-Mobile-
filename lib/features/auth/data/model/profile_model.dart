import 'package:base_app/features/auth/domain/entity/profile_entity.dart';

class ProfileModel {

  final int _id;
  final String _email;
  final String _name;
  final String _title;
  final String _address;
  final String _mobile;
  final String _mobileCode;
  final String _image;
  final String _appLanguage;
  final String _faceToken;
  final List<ProfileModel> _providerTeam;
  final String _gender;
  final String _dateOfBirth;

  ProfileEntity toEntity() => ProfileEntity(
    id: this._id,
    email: this._email,
    name: this._name,
    title: this._title,
    address: this._address,
    mobile: this._mobile,
    mobileCode: this._mobileCode,
    image: this._image,
    appLanguage: this._appLanguage,
    faceToken: this._faceToken,
    providerTeam: this._providerTeam.map((model) => model.toEntity()).toList(),
    gender: this._gender,
    dateOfBirth: this._dateOfBirth,
  );

  const ProfileModel({
    required int id,
    required String email,
    required String name,
    required String title,
    required String address,
    required String mobile,
    required String mobileCode,
    required String image,
    required String appLanguage,
    required String faceToken,
    required List<ProfileModel> providerTeam,
    required String gender,
    required String dateOfBirth,
  })  : _id = id,
        _email = email,
        _name = name,
        _title = title,
        _address = address,
        _mobile = mobile,
        _mobileCode = mobileCode,
        _image = image,
        _appLanguage = appLanguage,
        _faceToken = faceToken,
        _providerTeam = providerTeam,
        _gender = gender,
        _dateOfBirth = dateOfBirth;

  factory ProfileModel.fromJson(Map<String, dynamic>? json) {

    return ProfileModel(
      id: json?["id"]??0,
      name: json?["name"] ?? '',
      title: json?["title"] ?? '',
      email: json?["email"]??'',
      dateOfBirth: json?["date_of_birth"]??'',
      gender: json?["gender"]??'',
      address: json?["full_address"]??'',
      appLanguage: json?["app_language"] ?? 'ar',
      image: json?["profile_picture_url"] ?? '',
      faceToken: json?["face_token"] ?? '',
      mobile: json?["phone"] ?? '',
      mobileCode: json?["country_code"] ?? '',
      providerTeam: List<ProfileModel>.from((json?["provider_team"]??[]).map((x) => ProfileModel.fromJson(x))),
    );
  }
}
