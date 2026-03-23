import 'package:equatable/equatable.dart';

ProfileEntity demoProfile = ProfileEntity(
  id: 1,
  name: 'Ahmed Ali',
  title: 'Guest User',
  email: 'user@example.com',
  mobileCode: '+966',
  mobile: '512345678',
  image: 'https://example.com/avatar.png',
  address: 'Al Ahsa, Saudi Arabia',
  appLanguage: 'ar',
  faceToken: 'sss',
  providerTeam: [],
  gender: 'male',
  dateOfBirth: '1995, 5, 12',
);

class ProfileEntity extends Equatable {
  final int _id;
  final String _name;
  final String _title;
  final String _email;
  final String _mobileCode;
  final String _mobile;
  final String _address;
  final String _image;
  final String _appLanguage;
  final String _faceToken;
  final List<ProfileEntity> _providerTeam;
  final String? _gender;
  final String? _dateOfBirth;
  @override
  List<Object> get props => [
        _name,
        _id,
        _name,
        _mobile,
        _mobileCode,
      ];


  String get title => _title;
  String get address => _address;
  String? get gender => _gender;
  String? get dateOfBirth => _dateOfBirth;

  String get faceToken => _faceToken;

  String get appLanguage => _appLanguage;

  String get image => _image;

  String get mobile => _mobile;

  String get mobileCode => _mobileCode;

  String get email => _email;

  String get name => _name;

  int get id => _id;

  List<ProfileEntity> get providerTeam => _providerTeam;

  const ProfileEntity({
    required int id,
    required String name,
    required String title,
    required String email,
    required String mobileCode,
    required String mobile,
    required String image,
    required String address,
    required String appLanguage,
    required String faceToken,
    required List<ProfileEntity> providerTeam,
    required String gender,
    required String dateOfBirth,

  })  : _id = id,
        _name = name,
        _title = title,
        _email = email,
        _address = address,
        _dateOfBirth = dateOfBirth,
        _gender = gender,

        _mobileCode = mobileCode,
        _mobile = mobile,
        _image = image,
        _appLanguage = appLanguage,
        _faceToken = faceToken,
        _providerTeam = providerTeam;
}
