import 'package:base_app/base/presentation/component/component.dart';
import 'package:base_app/core/constants/constants.dart';
import 'package:base_app/core/constants/enums.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/features/auth/domain/parameters/forget_password_parameters.dart';
import 'package:base_app/features/auth/presentation/modules/forget_password/forget_password_view_model.dart';
import 'package:base_app/features/auth/route_generator.dart';
import 'package:base_app/generated/assets.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../../core/routing/navigation_services.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController ;
  late TextEditingController _mobileController ;
  late ForgetPasswordViewModel _viewModel ;


  void _onSubmit(context) async {
    // NavigationService.push(AuthRoutes.otpScreen, arguments: {'parameters': ForgetPasswordParameters(email: 'email@gmail.com', mobileCountry: _viewModel.parameters.mobileCountry,authMethodTypes: AuthMethodTypes.reset)});


    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        String email = _emailController.text;
        String mobile = _mobileController.text;

        _viewModel.forgetPassword( email:email,mobile:mobile).then((value) {
          if(value.isSuccess && value.data != null){
            NavigationService.push(AuthRoutes.otpScreen, arguments: {'parameters': ForgetPasswordParameters(email: email, mobile: mobile,mobileCountry: _viewModel.parameters.mobileCountry,authMethodTypes: AuthMethodTypes.reset)});

          }
        });
      }
    }
  }

  @override
  void initState() {
    _viewModel = Provider.of<ForgetPasswordViewModel>(context,listen: false);
    _viewModel.init();
    _emailController = TextEditingController();
    _mobileController = TextEditingController();
    super.initState();

  }

  @override
  void dispose() {
    _emailController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = context.watch<ForgetPasswordViewModel>().isLoading;

    return CustomScaffold(
      image: Assets.imagesSplashBackground,

      extendBodyBehindAppBar: true,
      appBar:  CustomAppBar(
        titleColor: Theme.of(context).cardColor,
        color: Colors.transparent,
      ),


      body:Container(
        // padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),

        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  // width: 120.w,height: 120.h,
                  padding:  EdgeInsets.symmetric(vertical: 36.h),
                  alignment: Alignment.center,
                  // child: AnimatedLogo(size: 80.r,nameSize: 20,color: Colors.white,withName: true),
                  child: SvgPicture.asset(Assets.logoLogo,width: 60.w,height: 60.h,fit: BoxFit.fill,),
                ),

                Padding(
                  padding: kCardPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(tr(LocaleKeys.forgetPassword),style: TextStyle().titleStyle(fontSize: 26).colorWhite(),),
                      Text(tr(LocaleKeys.forgetPasswordMessage),style: TextStyle().semiBoldStyle(fontSize: 14).colorWhite(),),


                      VerticalSpace(kScreenPaddingLarge.h),

                      _buildForm(),

                      VerticalSpace(kScreenPaddingNormal.h),
                      Center(child: CustomButton(loading: isLoading,title: tr(LocaleKeys.submit), onTap: ()=> _onSubmit(context))),

                      VerticalSpace(kFormPaddingAllLarge.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }
  _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFieldEmail(
            hint: tr(LocaleKeys.email),
            label: tr(LocaleKeys.email),
            labelColor: Theme.of(context).hintColor,
            controller: _emailController,
            // validateFunc: (v) {
            //   log('CustomTextFieldEmail', _mobileController.text);
            //   if (_mobileController.text.isNotEmpty) return null;
            //   if ((v ?? '').isEmpty) {
            //     return tr(LocaleKeys.msgEmailRequired);
            //   } else if (Validators.isEmail(v!)) {
            //     return tr(LocaleKeys.msgInvalidEmailAddress);
            //   }
            //   return null;
            // },
          ),
          // VerticalSpace(kFormPaddingAllLarge.h),
          // CustomTextFieldPhoneCode(
          //   hint: tr(LocaleKeys.mobile),
          //   label: tr(LocaleKeys.mobile),
          //   onCountryChanged: _viewModel.onUpdateMobileCountryCode,
          //
          //   controller: _mobileController,
          //   // isRequired: _emailController.text.isNotEmpty,
          //
          // ),
        ],
      ),
    );
  }

}
