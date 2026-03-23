import 'package:base_app/base/presentation/component/component.dart';
import 'package:base_app/core/constants/constants.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/features/common/presentation/modules/privacy/privacy_view_model.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> _getData(BuildContext context, bool reload) async =>
    await Provider.of<PrivacyViewModel>(context, listen: false).getPrivacy(reload: reload);

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  @override
  void initState() {
    _getData(context, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var responseModel = context.watch<PrivacyViewModel>().responseModel;
    return CustomScaffold(
      appBar: CustomAppBar(title: tr(LocaleKeys.privacyPolicy)),
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

                // Sections
                ...data.sections.map((section) => Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: CustomCard(
                        child: Padding(
                          padding: kScreenPadding,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (section.title.isNotEmpty)
                                Text(
                                  section.title,
                                  style: const TextStyle().titleStyle(fontSize: 18).primaryTextColor(),
                                ),
                              VerticalSpace(8.h),
                              if (section.content.isNotEmpty)
                                CustomHTMLTextWidget(
                                  section.content,
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

                // Effective Date
                if (data.effectiveDate != null && data.effectiveDate!.isNotEmpty) ...[
                  VerticalSpace(16.h),
                  Text(
                    data.effectiveDate!,
                    style: const TextStyle().regularStyle(fontSize: 12).colorHint(),
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
}
