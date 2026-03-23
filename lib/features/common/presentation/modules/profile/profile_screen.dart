import 'package:base_app/base/presentation/component/component.dart';
import 'package:base_app/base/presentation/component/selector/gender_selector_widget.dart';
import 'package:base_app/core/constants/constants.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/core/routing/navigation_services.dart';
import 'package:base_app/features/auth/domain/parameters/profile_parameters.dart';
import 'package:base_app/features/common/presentation/modules/profile/profile_view_model.dart';

import 'package:base_app/generated/locale_keys.g.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileViewModel _viewModel;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController ;
  late TextEditingController _emailController ;
  late TextEditingController _mobileController ;



  void _onSubmit(context) async {
    // bool country = _viewModel.checkCountryError();
    // bool city = _viewModel.checkCityError();
    // bool region = _viewModel.checkRegionError();
    // bool isValid = country && city && region;

    if (_formKey.currentState != null ) {
      if (_formKey.currentState!.validate() /*&&  isValid*/) {
        _formKey.currentState!.save();
        String mobile = _mobileController.text;
        String email = _emailController.text;
        String name = _nameController.text;
        var response = await _viewModel.updateProfile(email: email ,mobile: mobile,name: name);

        if (response.isSuccess) {
          NavigationService.goBack();
        }
      }
    }
  }

  @override
  void initState() {
    _viewModel = Provider.of<ProfileViewModel>(context,listen: false);
    _viewModel.init();
    _nameController = TextEditingController(text: _viewModel.parameters.name);
    _mobileController = TextEditingController(text: _viewModel.parameters.mobile);
    _emailController = TextEditingController(text: _viewModel.parameters.email);

    super.initState();


  }

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();

    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var parameters = context.watch<ProfileViewModel>().parameters;
    var isLoading = context.watch<ProfileViewModel>().isLoading;


    return CustomScaffold(
      appBar: CustomAppBar(title: tr(LocaleKeys.personalData)),
      body: SafeArea(
        child: Padding(
          padding: kScreenPadding,
          child: Form(
            child: Column(
              children: [
        
        
                Expanded(child: _buildForm(parameters)),
                VerticalSpace(kScreenPaddingNormal.h),
                
        
                CustomButton(loading: isLoading,title: tr(LocaleKeys.save), onTap: ()=> _onSubmit(context)),

              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildForm(ProfileParameters parameters) {
    bool isUploadImageLoading = context.watch<ProfileViewModel>().isUploadImageLoading;

    return Form(
      key: _formKey,
      child: CustomListAnimator(
        children: [
          Column(
            children: [
              Center(
                child: CustomPersonImage(
                  isLoading: isUploadImageLoading,

                  imageUrl: parameters.image,
                  onAttachImage: _viewModel.upLoadAttachment,
                  showShadow: true,
                  canEdit: true,
                  size: 140.r,
                  title: tr(LocaleKeys.personalData),
                ),
              ),
              // VerticalSpace(kScreenPaddingNormal.h),
              // Text('+02 012345678911',style: TextStyle().regularStyle()),
              VerticalSpace(kScreenPaddingNormal.h),
            ],
          ),
          CustomTextFieldNormal(
            hint: tr(LocaleKeys.fullName),
            label: tr(LocaleKeys.fullName),
            defaultValue: parameters.name,
            controller: _nameController,
            textInputAction: TextInputAction.next,
          ),

          CustomTextFieldEmail(
            hint: tr(LocaleKeys.email),
            label: tr(LocaleKeys.email),
            controller: _emailController,
            defaultValue: parameters.email,
            textInputAction: TextInputAction.next,
          ),

          CustomTextFieldPhoneCode(
            defaultValue: parameters.mobile,
            hint: tr(LocaleKeys.mobile),
            label: tr(LocaleKeys.mobile),
            controller: _mobileController,
            initialCountry: parameters.mobileCountry,
            textInputAction: TextInputAction.next,
          ),
          // GenderSelectorWidget(onSelected: _viewModel.onUpdateGender, selectedValue: parameters.gender),


          const VerticalSpace(kFormPaddingAllLarge),

        ],
      ),
    );
  }



}
