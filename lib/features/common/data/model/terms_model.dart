import 'package:base_app/features/common/domain/entity/terms_entity.dart';

class TermsModel {
  final String _headerTitle;
  final String _headerSubTerm;
  final String _welcomeMessage;
  final List<TermSectionModel> _terms;
  final String _footerTitle;
  final String _footerText;
  final ContactDetailsModel? _contactDetails;
  final String? _thankYouMessage;

  const TermsModel({
    required String headerTitle,
    required String headerSubTerm,
    required String welcomeMessage,
    required List<TermSectionModel> terms,
    required String footerTitle,
    required String footerText,
    ContactDetailsModel? contactDetails,
    String? thankYouMessage,
  })  : _headerTitle = headerTitle,
        _headerSubTerm = headerSubTerm,
        _welcomeMessage = welcomeMessage,
        _terms = terms,
        _footerTitle = footerTitle,
        _footerText = footerText,
        _contactDetails = contactDetails,
        _thankYouMessage = thankYouMessage;

  factory TermsModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return TermsModel(
        headerTitle: '',
        headerSubTerm: '',
        welcomeMessage: '',
        terms: [],
        footerTitle: '',
        footerText: '',
      );
    }

    return TermsModel(
      headerTitle: json['header_title'] ?? '',
      headerSubTerm: json['header_sub_term'] ?? '',
      welcomeMessage: json['welcome_message'] ?? '',
      terms: (json['terms'] as List<dynamic>?)
              ?.map((item) => TermSectionModel.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      footerTitle: json['footer_title'] ?? '',
      footerText: json['footer_text'] ?? '',
      contactDetails: json['contact_details'] != null
          ? ContactDetailsModel.fromJson(json['contact_details'] as Map<String, dynamic>)
          : null,
      thankYouMessage: json['thank_you_message'],
    );
  }

  String get headerTitle => _headerTitle;
  String get headerSubTerm => _headerSubTerm;
  String get welcomeMessage => _welcomeMessage;
  List<TermSectionModel> get terms => _terms;
  String get footerTitle => _footerTitle;
  String get footerText => _footerText;
  ContactDetailsModel? get contactDetails => _contactDetails;
  String? get thankYouMessage => _thankYouMessage;

  TermsEntity toEntity() => TermsEntity(
        headerTitle: _headerTitle,
        headerSubTerm: _headerSubTerm,
        welcomeMessage: _welcomeMessage,
        terms: _terms.map((e) => e.toEntity()).toList(),
        footerTitle: _footerTitle,
        footerText: _footerText,
        contactDetails: _contactDetails?.toEntity(),
        thankYouMessage: _thankYouMessage,
      );
}

class TermSectionModel {
  final String _title;
  final String _content;

  const TermSectionModel({
    required String title,
    required String content,
  })  : _title = title,
        _content = content;

  factory TermSectionModel.fromJson(Map<String, dynamic>? json) {
    return TermSectionModel(
      title: json?['title'] ?? '',
      content: json?['content'] ?? '',
    );
  }

  String get title => _title;
  String get content => _content;

  TermSectionEntity toEntity() => TermSectionEntity(
        title: _title,
        content: _content,
      );
}

class ContactDetailsModel {
  final String _email;
  final String _phone;
  final String _address;

  const ContactDetailsModel({
    required String email,
    required String phone,
    required String address,
  })  : _email = email,
        _phone = phone,
        _address = address;

  factory ContactDetailsModel.fromJson(Map<String, dynamic>? json) {
    return ContactDetailsModel(
      email: json?['email'] ?? '',
      phone: json?['phone'] ?? '',
      address: json?['address'] ?? '',
    );
  }

  String get email => _email;
  String get phone => _phone;
  String get address => _address;

  ContactDetailsEntity toEntity() => ContactDetailsEntity(
        email: _email,
        phone: _phone,
        address: _address,
      );
}
