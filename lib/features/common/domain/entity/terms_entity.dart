class TermsEntity {
  final String headerTitle;
  final String headerSubTerm;
  final String welcomeMessage;
  final List<TermSectionEntity> terms;
  final String footerTitle;
  final String footerText;
  final ContactDetailsEntity? contactDetails;
  final String? thankYouMessage;

  const TermsEntity({
    required this.headerTitle,
    required this.headerSubTerm,
    required this.welcomeMessage,
    required this.terms,
    required this.footerTitle,
    required this.footerText,
    this.contactDetails,
    this.thankYouMessage,
  });
}

class TermSectionEntity {
  final String title;
  final String content;

  const TermSectionEntity({
    required this.title,
    required this.content,
  });
}

class ContactDetailsEntity {
  final String email;
  final String phone;
  final String address;

  const ContactDetailsEntity({
    required this.email,
    required this.phone,
    required this.address,
  });
}
