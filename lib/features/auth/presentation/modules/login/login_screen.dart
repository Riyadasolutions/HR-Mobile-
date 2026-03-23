import 'package:base_app/base/presentation/component/component.dart';
import 'package:base_app/core/constants/constants.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/core/routing/navigation_services.dart';
import 'package:base_app/core/utils/logger.dart';
import 'package:base_app/features/auth/core/auth/auth_helper.dart';
import 'package:base_app/features/auth/presentation/modules/login/login_view_model.dart';
import 'package:base_app/features/auth/presentation/modules/login/widgets/social_icons.dart';
import 'package:base_app/features/auth/route_generator.dart';
import 'package:base_app/features/common/route_generator.dart';
import 'package:base_app/generated/assets.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  LoginViewModel get _viewModel => Provider.of<LoginViewModel>(context,listen: false);



  // final _email  =kDebugMode?'ahmed12@gmail.com':'';
  // final _password  =kDebugMode?'ahmed12@gmail.com':'';



  final _email  =kDebugMode?'admin@abrajstay.com':'';
  final _password  =kDebugMode?'Admin@1234':'';



  // final _email  =kDebugMode?'test21@example.com':'';
  // final _password  =kDebugMode?'password123':'';


  // final _phone  =kDebugMode?'1020139072':'';
  // final _phone  =kDebugMode?'1020193020':'';


  final _formKey = GlobalKey<FormState>();



  void _onSubmit(context) async {
    // if(kDemoMode){
    //   kUser = demoProfile;
    //   NavigationService.pushNamedAndRemoveUntil( CommonRoutes.layoutScreen);
    //   return;
    // }

    if (_formKey.currentState != null) {

      if (_formKey.currentState!.validate()) {

        _formKey.currentState!.save();

        // String? fcmToken = await getDeviceToken();
        String email = _emailController.text;
        String password = _passwordController.text;
        var response = await _viewModel.login( email: email,password: password);

          log('LoginScreen', response.isSuccess.toString());
          log('LoginScreen', response.data.toString());
          // log('LoginScreen', response.isSuccess.toString());

        if (response.isSuccess) {

          NavigationService.pushNamedAndRemoveUntil( CommonRoutes.layoutScreen);
        }
      }
    }
  }

  void _onPressSocialLogin(context, AuthType authType) async {
    NavigationService.pushNamedAndRemoveUntil( CommonRoutes.layoutScreen);
    return;

    var response = await _viewModel.socialSignIn(context,authType);
    if (response?.isSuccess==true) {
      NavigationService.pushNamedAndRemoveUntil( CommonRoutes.layoutScreen);
    }
  }

  @override
  void initState() {
    _viewModel.init();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    // if(context.read<LocalAuthProvider>().faceIdToken!=null && kIsAuth )_onFaceId(context.read<LocalAuthProvider>().faceIdToken!);

    super.initState();
  }
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    bool isLoading = context.watch<LoginViewModel>().isLoading;
    // String? faceIdToken = context.watch<LocalAuthProvider>().faceIdToken;
    // bool isFaceIdLoginLoading = context.watch<LoginViewModel>().isFaceIdLoginLoading;
    return CustomScaffold(
      image: Assets.imagesSplashBackground,
        body: SingleChildScrollView(

          child: SafeArea(
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
                        // VerticalSpace(kFormPaddingAllLarge.h),
                        Text(tr(LocaleKeys.login),style: TextStyle().titleStyle(fontSize: 26).colorWhite(),),
                        Text(tr(LocaleKeys.hiWelcomeBackWeHaveBeenMissed),style: TextStyle().semiBoldStyle(fontSize: 14).colorWhite(),),

                        VerticalSpace(kFormPaddingAllLarge.h),
                        _buildForm(),
                        VerticalSpace(kFormPaddingAllLarge.h),
                        Align(alignment: AlignmentDirectional.centerEnd,child: GestureDetector(onTap: ()=>NavigationService.push(AuthRoutes.forgetPasswordScreen),child: Text(tr(LocaleKeys.aryYouForgetPassword),style: TextStyle().semiBoldStyle().activeColor(),))),

                        VerticalSpace(kScreenPaddingLarge.h),

                        // SizedBox(height: 20.h),

                        CustomButton (
                          onTap: () => _onSubmit(context),
                          loading: isLoading,
                          title: tr(LocaleKeys.login),
                        ),
                        // VerticalSpace(kFormPaddingAllLarge.h),
                        // CustomSocialMediaLoginWidget(
                        //   loginByGoogle: () => _onPressSocialLogin(context, AuthType.google),
                        //   loginByApple: () => _onPressSocialLogin(context, AuthType.apple),
                        //   loginWithApple: true,
                        //   loginWithFaceBook: false,
                        //   // loginByFacebook: () => _onPressSocialLogin(context, AuthType.facebook),
                        // ),
                        //


                        // if(faceIdToken!=null)...[
                        // CustomButton(
                        //   onTap: () => _onFaceId(faceIdToken),
                        //   color: Theme.of(context).primaryColorLight,
                        //   textColor: Theme.of(context).primaryColor,
                        //   loading: isFaceIdLoginLoading,
                        //   child: CustomIconText(title: tr(LocaleKeys.authenticateUsingFaceID),icon: Assets.iconsFaceIdIcon,textColor: Theme.of(context).primaryColor,mainAxisAlignment: MainAxisAlignment.center,),
                        // ),
                        // ],
                          VerticalSpace(kFormPaddingAllLarge.h),
                          CustomTextClickWidget(text: tr(LocaleKeys.youDoNotHaveAnAccount),subText: tr(LocaleKeys.register),onTap: () => NavigationService.push(AuthRoutes.registerScreen)),
                        Align(alignment: Alignment.center,child: TextButton(onPressed: () =>NavigationService.push( CommonRoutes.layoutScreen), child: Text(tr(LocaleKeys.asAGuest),style: const TextStyle().regularStyle(fontSize: 14).activeColor()),)),




                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  _buildForm(){
    var parameters = context.watch<LoginViewModel>().parameters;
    final labelColor = Theme.of(context).hintColor;

    return Form(
      key: _formKey,

      child: Column(
        children: [
          VerticalSpace(kFormPaddingAllLarge.h),
          // CustomTextFieldPhoneCode(
          //   label: tr(LocaleKeys.mobile),
          //   hint: tr(LocaleKeys.mobile),
          //   controller: _mobileController,
          //   defaultValue: _phone,
          //   initialCountry: parameters.mobileCountry,
          //   onCountryChanged: _viewModel.onUpdateMobileCountryCode,
          //   textInputAction: TextInputAction.done,
          // ),

          VerticalSpace(kFormPaddingAllLarge.h),

          CustomTextFieldEmail(label: tr(LocaleKeys.email),defaultValue: _email,labelColor: labelColor,hint: tr(LocaleKeys.email),controller: _emailController,),
          VerticalSpace(kFormPaddingAllLarge.h),
          CustomTextFieldPassword(label: tr(LocaleKeys.passwordHint),defaultValue: _password,hint: tr(LocaleKeys.passwordHint),labelColor: labelColor,controller: _passwordController,),


        ],
      ),
    );
  }
}
