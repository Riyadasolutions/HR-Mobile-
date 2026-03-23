
import 'dart:ui' as ui;

import 'package:base_app/base/presentation/component/component.dart';
import 'package:base_app/core/api_helper/api_result.dart';
import 'package:base_app/core/constants/constants.dart';
import 'package:base_app/core/constants/enums.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/core/routing/navigation_services.dart';
import 'package:base_app/features/auth/domain/parameters/forget_password_parameters.dart';
import 'package:base_app/features/auth/route_generator.dart';
import 'package:base_app/generated/assets.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import 'otp_view_model.dart';

class OTPScreen extends StatefulWidget {
  final ForgetPasswordParameters _parameters;

  @override
  _OTPScreenState createState() => _OTPScreenState();

  const OTPScreen({super.key,
    required ForgetPasswordParameters parameters,
  }) : _parameters = parameters;
}

class _OTPScreenState extends State<OTPScreen> {
  late TextEditingController _codeController ;
  final _formKey = GlobalKey<FormState>();
   OTPViewModel get  _viewModel => Provider.of<OTPViewModel>(context,listen: false);

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


  void _onResendCode(bool notify) async =>
    await _viewModel.reSendCode(notify,widget._parameters);

  void _onSubmit(context) async {
    FocusScope.of(context).unfocus();
    String code = _codeController.text;

    // if(widget._parameters.authMethodTypes == AuthMethodTypes.reset){
    //   NavigationService.push( AuthRoutes.resetPasswordScreen, arguments: {'parameters': widget._parameters});
    //
    // }else{
    //   NavigationService.pushNamedAndRemoveUntil( CommonRoutes.layoutScreen);
    //
    // }

    // return ;
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        if (code.length ==4) {
          widget._parameters.setOtp(code);
          ApiResult response = await _viewModel.checkOtpCode(parameters: widget._parameters);
          if (response.isSuccess) {
            NavigationService.push( AuthRoutes.resetPasswordScreen, arguments: {'parameters': widget._parameters});
            // NavigationService.pushNamedAndRemoveUntil( CommonRoutes.layoutScreen);

          } else {
            _codeController.clear();
          }
        }
      }
    }
  }

  @override
  void initState() {
    // if(widget._parameters.checkOTPType != CheckOTPType.reset){
    //   _onResendCode(false);
    // }

    _codeController = TextEditingController();
    super.initState();
  }
  // @override
  // void dispose() {
  //   super.dispose();
  //
  //   _codeController.dispose();
  //
  // }

  @override
  Widget build(BuildContext context) {
    // ResponseModel<String>? responseModel = context.watch<OTPViewModel>().responseModel;
    bool isLoading = context.watch<OTPViewModel>().isLoading;
    return CustomScaffold(
      image: Assets.imagesSplashBackground,
      extendBodyBehindAppBar: true,
      appBar:  CustomAppBar(
        titleColor: Theme.of(context).cardColor,
        color: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[

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
                      Text(tr(LocaleKeys.hi),style: TextStyle().titleStyle(fontSize: 26).colorWhite(),),
                      Text(tr(LocaleKeys.otpMessage,namedArgs: {'email': widget._parameters.email??''}),style: TextStyle().semiBoldStyle(fontSize: 14).colorWhite(),),


                      VerticalSpace(kScreenPaddingLarge.h),

                      _buildForm(),
                      VerticalSpace(kFormPaddingAllLarge.h),

                      CustomButton(
                        onTap: () => _onSubmit(context),
                        loading: isLoading,
                        title: tr(LocaleKeys.verify),
                      ),
                      VerticalSpace(kFormPaddingAllLarge.h),

                      _buildResendCode(),
                      // Text('+${widget._parameters.email}',style: const TextStyle().regularStyle().activeColor(),textDirection:  ui.TextDirection.ltr,),
                      // Text('+${widget._parameters.mobileCountry.dialCode}-xxxxx ${  ((widget._parameters.mobile??'').substring((widget._parameters.mobile??'').length - 4, (widget._parameters.mobile??'').length))}',style: const TextStyle().regularStyle().activeColor(),textDirection:  ui.TextDirection.ltr,),

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
  _buildResendCode(){
    bool isLoading = context.watch<OTPViewModel>().isResendLoading;
    bool isTimerDone = context.watch<OTPViewModel>().isTimerDone;

    if (isLoading) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomLoadingSpinner(size: 20.r),
        ],
      );
    }
    else if(isTimerDone/* && isLoading*/){
      return  Container(
        margin: const EdgeInsetsDirectional.only(top: 16, bottom: 16),
        child: Center(
          child: GestureDetector(
            onTap: ()=> (!isTimerDone && !isLoading) ?{}:_onResendCode(true),
            child: Text(tr(LocaleKeys.resendCode),style: const TextStyle().regularStyle().activeColor()),

          ),
        ),
      );

    }else if(!isTimerDone && !isLoading) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text( '${tr(LocaleKeys.youCanResendTheCodeIn)} ' ,style: const TextStyle().regularStyle().colorWhite(),textAlign: TextAlign.center),

          TimerCountdown(
            format: CountDownTimerFormat.secondsOnly,
            enableDescriptions: false,
            endTime: DateTime.now().add(const Duration(minutes: 1)),
            spacerWidth: 1.0,
            timeTextStyle: const TextStyle().regularStyle(fontSize: 16).activeColor(),
            onEnd: () =>_viewModel.onTimerEnd(),
          ),
          Text( ' ${tr(LocaleKeys.seconds)}' ,style: const TextStyle().regularStyle().colorWhite(),textAlign: TextAlign.center),

        ],
      );
    }else{
      return const SizedBox();
    }
  }
  _buildForm(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kFormPaddingAllNormal),
      child: Form(
        key: _formKey,
        child: Directionality(
          // textDirection: TextDirection.LTR,
          textDirection: ui.TextDirection.ltr ,
          child: PinCodeTextField(
            appContext: context,
            length: 4,

            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
            obscureText: false,
            showCursor: false,
            enableActiveFill: true,
            animationType: AnimationType.fade,
            pinTheme: PinTheme(

              shape: PinCodeFieldShape.box,
              borderWidth: 1,
              inactiveColor:AppColor.fieldFillColor.themeColor,
              disabledColor: AppColor.fieldFillColor.themeColor,
              activeColor:  AppColor.fieldFillColor.themeColor,
              selectedColor:  AppColor.fieldFillColor.themeColor,

              errorBorderColor: Theme.of(context).colorScheme.error,
              inactiveFillColor: AppColor.fieldFillColor.themeColor,
              selectedFillColor: AppColor.fieldFillColor.themeColor,
              borderRadius: BorderRadius.circular(kFormRadius),

              fieldHeight: 54.r,
              fieldWidth: 54.r,

              activeFillColor: AppColor.fieldFillColor.themeColor,
            ),
            animationDuration: const Duration(milliseconds: 300),
            backgroundColor: Colors.transparent,
            textStyle: const TextStyle().semiBoldStyle().primaryTextColor(),

            // boxShadows: const [ BoxShadow(color: grayScaleLiteColor, spreadRadius: 1, blurRadius: 5)],
            controller: _codeController,

            beforeTextPaste: (text) {return true;}, onChanged: (String value) {},
          ),
        ),
      ),
    );
  }}
