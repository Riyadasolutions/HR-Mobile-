import 'package:base_app/base/presentation/component/component.dart';
import 'package:base_app/core/constants/constants.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/features/common/presentation/modules/terms/terms_view_model.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> _getData(BuildContext context, bool reload) async =>
    await Provider.of<TermsViewModel>(context, listen: false).getTerms(reload: reload);

class TermsScreen extends StatefulWidget {
  const TermsScreen({super.key});

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  @override
  void initState() {
    _getData(context, true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var responseModel = context.watch<TermsViewModel>().responseModel;
    return CustomScaffold(
      appBar: CustomAppBar(title: tr(LocaleKeys.termsAndConditions)),
      body: CustomScreenStateLayout(
        isLoading: responseModel == null,
        isEmpty: responseModel?.data == null,
        error: responseModel?.error,
        onRetry: () => _getData(context, true),
        builder: (context) {
          final data = responseModel!.data!;
          return SingleChildScrollView(
            padding: kScreenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                if (data.headerTitle.isNotEmpty)
                  Text(
                    data.headerTitle,
                    style: const TextStyle().titleStyle(fontSize: 24).primaryTextColor(),
                  ),
                VerticalSpace(8.h),
                if (data.headerSubTerm.isNotEmpty)
                  Text(
                    data.headerSubTerm,
                    style: const TextStyle().regularStyle(fontSize: 14).colorHint(),
                  ),
                VerticalSpace(16.h),

                // Welcome Message
                if (data.welcomeMessage.isNotEmpty)
                  CustomCard(
                    child: Padding(
                      padding: kScreenPadding,
                      child: CustomHTMLTextWidget(
                        data.welcomeMessage,
                        style: const TextStyle().regularStyle(fontSize: 14).primaryTextColor(),
                      ),
                    ),
                  ),
                VerticalSpace(16.h),

                // Terms Sections
                ...data.terms.map((term) => Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: CustomCard(
                        child: Padding(
                          padding: kScreenPadding,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (term.title.isNotEmpty)
                                Text(
                                  term.title,
                                  style: const TextStyle().titleStyle(fontSize: 18).primaryTextColor(),
                                ),
                              VerticalSpace(8.h),
                              if (term.content.isNotEmpty)
                                CustomHTMLTextWidget(
                                  term.content,
                                  style: const TextStyle().regularStyle(fontSize: 14).primaryTextColor(),
                                ),
                            ],
                          ),
                        ),
                      ),
                    )),

                // Footer
                VerticalSpace(16.h),
                if (data.footerTitle.isNotEmpty)
                  Text(
                    data.footerTitle,
                    style: const TextStyle().titleStyle(fontSize: 18).primaryTextColor(),
                  ),
                VerticalSpace(8.h),
                if (data.footerText.isNotEmpty)
                  CustomHTMLTextWidget(
                    data.footerText,
                    style: const TextStyle().regularStyle(fontSize: 14).primaryTextColor(),
                  ),

                // Contact Details
                if (data.contactDetails != null) ...[
                  VerticalSpace(16.h),
                  CustomCard(
                    child: Padding(
                      padding: kScreenPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr(LocaleKeys.contactUs),
                            style: const TextStyle().titleStyle(fontSize: 18).primaryTextColor(),
                          ),
                          VerticalSpace(8.h),
                          if (data.contactDetails!.email.isNotEmpty)
                            _buildContactItem(Icons.email, data.contactDetails!.email),
                          if (data.contactDetails!.phone.isNotEmpty)
                            _buildContactItem(Icons.phone, data.contactDetails!.phone),
                          if (data.contactDetails!.address.isNotEmpty)
                            _buildContactItem(Icons.location_on, data.contactDetails!.address),
                        ],
                      ),
                    ),
                  ),
                ],

                // Thank You Message
                if (data.thankYouMessage != null && data.thankYouMessage!.isNotEmpty) ...[
                  VerticalSpace(16.h),
                  CustomHTMLTextWidget(
                    data.thankYouMessage!,
                    style: const TextStyle().regularStyle(fontSize: 14).primaryTextColor(),
                  ),
                ],
                VerticalSpace(24.h),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20.r, color: Theme.of(context).primaryColor),
          HorizontalSpace(8.w),
          Expanded(
            child: Text(
              text,
              style: const TextStyle().regularStyle(fontSize: 14).primaryTextColor(),
            ),
          ),
        ],
      ),
    );
  }
}
