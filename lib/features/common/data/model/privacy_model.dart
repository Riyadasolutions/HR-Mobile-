import 'package:base_app/features/common/domain/entity/privacy_entity.dart';

class PrivacyModel {
  final String _headerTitle;
  final String _headerSubTerm;
  final String _welcomeMessage;
  final List<PrivacySectionModel> _sections;
  final String _footerTitle;
  final String _footerText;
  final String? _effectiveDate;

  const PrivacyModel({
    required String headerTitle,
    required String headerSubTerm,
    required String welcomeMessage,
    required List<PrivacySectionModel> sections,
    required String footerTitle,
    required String footerText,
    String? effectiveDate,
  })  : _headerTitle = headerTitle,
        _headerSubTerm = headerSubTerm,
        _welcomeMessage = welcomeMessage,
        _sections = sections,
        _footerTitle = footerTitle,
        _footerText = footerText,
        _effectiveDate = effectiveDate;

  factory PrivacyModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return PrivacyModel(
        headerTitle: '',
        headerSubTerm: '',
        welcomeMessage: '',
        sections: [],
        footerTitle: '',
        footerText: '',
      );
    }

    return PrivacyModel(
      headerTitle: json['header_title'] ?? '',
      headerSubTerm: json['header_sub_term'] ?? '',
      welcomeMessage: json['welcome_message'] ?? '',
      sections: (json['sections'] as List<dynamic>?)
              ?.map((item) => PrivacySectionModel.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      footerTitle: json['footer_title'] ?? '',
      footerText: json['footer_text'] ?? '',
      effectiveDate: json['effective_date'],
    );
  }

  String get headerTitle => _headerTitle;
  String get headerSubTerm => _headerSubTerm;
  String get welcomeMessage => _welcomeMessage;
  List<PrivacySectionModel> get sections => _sections;
  String get footerTitle => _footerTitle;
  String get footerText => _footerText;
  String? get effectiveDate => _effectiveDate;

  PrivacyEntity toEntity() => PrivacyEntity(
        headerTitle: _headerTitle,
        headerSubTerm: _headerSubTerm,
        welcomeMessage: _welcomeMessage,
        sections: _sections.map((e) => e.toEntity()).toList(),
        footerTitle: _footerTitle,
        footerText: _footerText,
        effectiveDate: _effectiveDate,
      );
}

class PrivacySectionModel {
  final String _title;
  final String _content;

  const PrivacySectionModel({
    required String title,
    required String content,
  })  : _title = title,
        _content = content;

  factory PrivacySectionModel.fromJson(Map<String, dynamic>? json) {
    return PrivacySectionModel(
      title: json?['title'] ?? '',
      content: json?['content'] ?? '',
    );
  }

  String get title => _title;
  String get content => _content;

  PrivacySectionEntity toEntity() => PrivacySectionEntity(
        title: _title,
        content: _content,
      );
}
