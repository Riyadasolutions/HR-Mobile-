import 'package:base_app/base/presentation/component/component.dart';
import 'package:base_app/base/presentation/component/inputs/country/phone_number_model.dart';
import 'package:base_app/core/constants/constants.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/core/routing/navigation_services.dart';
import 'package:base_app/features/common/presentation/modules/contact_us/contact_us_view_model.dart';
import 'package:base_app/generated/assets.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _formKey = GlobalKey<FormState>();
late ContactUsViewModel _viewModel ;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _subjectController;
  late TextEditingController _messageController;


  void _onSubmit(BuildContext context) async {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();



        await _viewModel.contactUsRequest(
          name: _nameController.text,
          email: _emailController.text,
          phone: _phoneController.text,
          subject: _subjectController.text,
          message: _messageController.text,
        );

        if (_viewModel.responseModel?.isSuccess == true) {
          NavigationService.goBack();
        }
      }
    }
  }

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _subjectController = TextEditingController();
    _messageController = TextEditingController();
    super.initState();
    _viewModel = Provider.of<ContactUsViewModel>(context, listen: false);
    _viewModel.init();

  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = context.watch<ContactUsViewModel>().isLoading;
    return CustomScaffold(
      appBar: CustomAppBar(title: tr(LocaleKeys.contactUs)),
      body: Padding(
        padding: kScreenPadding,
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SvgPicture.asset(Assets.imagesContactUsImage),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  VerticalSpace(kScreenPaddingNormal.h),
                  Expanded(child: _buildForm()),
                  VerticalSpace(kScreenPaddingNormal.h),
                ],
              ),
            ),
            Center(
              child: CustomButton(
                loading: isLoading,
                title: tr(LocaleKeys.submit),
                onTap: () => _onSubmit(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildForm() {
    return Form(
      key: _formKey,
      child: CustomListAnimator(
        children: [
          CustomTextFieldNormal(
            hint: tr(LocaleKeys.name),
            label: tr(LocaleKeys.name),
            controller: _nameController,
            textInputAction: TextInputAction.next,
          ),
          CustomTextFieldEmail(
            hint: tr(LocaleKeys.emailHint),
            label: tr(LocaleKeys.emailHint),
            controller: _emailController,
            textInputAction: TextInputAction.next,
          ),
          CustomTextFieldPhoneCode(
            hint: tr(LocaleKeys.mobile),
            label: tr(LocaleKeys.mobile),
            controller: _phoneController,
            textInputAction: TextInputAction.next,
            initialCountryCode: Constants.initMobileCountry.code,
            initialDialCode: Constants.initMobileCountry.dialCode,
            onCountryChanged: _viewModel.onUpdateMobileCountryCode,
          ),
          CustomTextFieldNormal(
            hint: tr(LocaleKeys.subject),
            label: tr(LocaleKeys.subject),
            controller: _subjectController,
            textInputAction: TextInputAction.next,
          ),
          CustomTextFieldArea(
            hint: tr(LocaleKeys.message),
            label: tr(LocaleKeys.message),
            controller: _messageController,
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }
}
