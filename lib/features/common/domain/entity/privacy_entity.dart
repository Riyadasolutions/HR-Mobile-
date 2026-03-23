class PrivacyEntity {
  final String headerTitle;
  final String headerSubTerm;
  final String welcomeMessage;
  final List<PrivacySectionEntity> sections;
  final String footerTitle;
  final String footerText;
  final String? effectiveDate;

  const PrivacyEntity({
    required this.headerTitle,
    required this.headerSubTerm,
    required this.welcomeMessage,
    required this.sections,
    required this.footerTitle,
    required this.footerText,
    this.effectiveDate,
  });
}

class PrivacySectionEntity {
  final String title;
  final String content;

  const PrivacySectionEntity({
    required this.title,
    required this.content,
  });
}
