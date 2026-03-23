import 'package:base_app/base/presentation/component/component.dart';
import 'package:base_app/core/constants/constants.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/core/routing/navigation_services.dart';
import 'package:base_app/core/utils/logger.dart';
import 'package:base_app/features/auth/presentation/modules/register/register_view_model.dart';
import 'package:base_app/features/auth/route_generator.dart';
import 'package:base_app/generated/assets.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _mobileController;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  RegisterViewModel get _viewModel => Provider.of<RegisterViewModel>(context,listen: false);







  void _onSubmit(context) async {
    // NavigationService.pushNamedAndRemoveUntil( CommonRoutes.layoutScreen);
    // // NavigationService.push(AuthRoutes.otpScreen, arguments: {'parameters':_viewModel.parameters});
    //
    // return;
    if (_formKey.currentState != null) {

      if (_formKey.currentState!.validate()) {

        _formKey.currentState!.save();

        String mobile = _mobileController.text;
        String email = _emailController.text;
        String password = _passwordController.text;
        String name = _nameController.text;
        var response = await _viewModel.register(name: name,email: email, mobile: mobile, password: password);

          log('RegisterScreen', response.toString());

        if (response.isSuccess) {

          NavigationService.push(AuthRoutes.loginScreen);
          // NavigationService.push(AuthRoutes.otpScreen, arguments: {'parameters':_viewModel.parameters});
          // NavigationService.push(AuthRoutes.otpScreen, arguments: {'parameters': ForgetPasswordParameters( mobile: mobile,mobileCountry: _viewModel.parameters.mobileCountry,fcmToken: fcmToken, authMethodTypes: AuthMethodTypes.login)});
        }
      }
    }
  }


  @override
  void initState() {
    _viewModel.init();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _mobileController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    super.initState();
  }
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    bool isLoading = context.watch<RegisterViewModel>().isLoading;
    return CustomScaffold(
      image: Assets.imagesSplashBackground,
        body: SingleChildScrollView(

          child: Container(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                      Text(tr(LocaleKeys.register),style: TextStyle().titleStyle(fontSize: 26).colorWhite(),),
                      Text(tr(LocaleKeys.shareYourDetailsToEnjoySpecialBookingBenefits),style: TextStyle().semiBoldStyle(fontSize: 14).colorWhite(),),

                      VerticalSpace(kFormPaddingAllLarge.h),
                      _buildForm(),
                      VerticalSpace(kScreenPaddingLarge.h),

                      // SizedBox(height: 20.h),

                      CustomButton(
                        onTap: () => _onSubmit(context),
                        loading: isLoading,
                        title: tr(LocaleKeys.register),
                      ),
                      VerticalSpace(kFormPaddingAllLarge.h),



                        VerticalSpace(kFormPaddingAllLarge.h),
                        CustomTextClickWidget(text: tr(LocaleKeys.alreadyHaveAnAccount),subText: tr(LocaleKeys.login),onTap: () => NavigationService.goBack()),




                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  _buildForm(){
    var parameters = context.watch<RegisterViewModel>().parameters;
    final labelColor = Theme.of(context).hintColor;
    return Form(
      key: _formKey,

      child: Column(
        children: [
          VerticalSpace(kFormPaddingAllLarge.h),
          // Row(
          //   children: [
          //     Expanded(child: CustomTextFieldNormal(label: tr(LocaleKeys.firstName),hint: tr(LocaleKeys.firstName),labelColor: labelColor,controller: _nameController,)),
          //     HorizontalSpace(kFormPaddingAllLarge.w),
          //     Expanded(child: CustomTextFieldNormal(label: tr(LocaleKeys.familyName),hint: tr(LocaleKeys.familyName),labelColor: labelColor,controller: _nameController,)),
          //   ],
          // ),
          CustomTextFieldNormal(label: tr(LocaleKeys.name),hint: tr(LocaleKeys.name),labelColor: labelColor,controller: _nameController,),

          VerticalSpace(kFormPaddingAllLarge.h),

          CustomTextFieldEmail(label: tr(LocaleKeys.email),hint: tr(LocaleKeys.email),labelColor: labelColor,controller: _emailController ,),
          VerticalSpace(kFormPaddingAllLarge.h),

          CustomTextFieldPhoneCode(
            label: tr(LocaleKeys.mobile),
            hint: tr(LocaleKeys.mobile),
            controller: _mobileController,
            labelColor: labelColor,
            initialCountry: parameters.mobileCountry,
            onCountryChanged: _viewModel.onUpdateMobileCountryCode,
            textInputAction: TextInputAction.done,
          ),

          VerticalSpace(kFormPaddingAllLarge.h),
          CustomTextFieldPassword(label: tr(LocaleKeys.passwordHint),labelColor: labelColor,hint: tr(LocaleKeys.passwordHint),controller: _passwordController,),
          VerticalSpace(kFormPaddingAllLarge.h),
          CustomTextFieldPassword(
            labelColor: labelColor,
            hint:tr(LocaleKeys.confirmPassword),
            label:tr(LocaleKeys.confirmPassword),
            textInputAction: TextInputAction.done,
            controller: _confirmPasswordController,
            validateFunc:(value){
              if (_confirmPasswordController.text != value && (value ?? '').isNotEmpty) {
                return tr(LocaleKeys.confirmPasswordDoesNotMatchPassword);
              }
              if (value.toString().length <= 5) {
                return tr(LocaleKeys.msgConfirmPasswordRequired);
              }
              return null;
            },
          ),

        ],
      ),
    );
  }
}
