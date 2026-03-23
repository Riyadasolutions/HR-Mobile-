
import 'package:base_app/base/presentation/component/component.dart';
import 'package:base_app/core/constants/constants.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/core/routing/navigation_services.dart';
import 'package:base_app/features/auth/domain/parameters/forget_password_parameters.dart';
import 'package:base_app/features/auth/presentation/modules/reset_password/reset_password_view_model.dart';
import 'package:base_app/features/common/route_generator.dart';
import 'package:base_app/generated/assets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../../generated/locale_keys.g.dart';


class ResetPasswordScreen extends StatefulWidget {
  final ForgetPasswordParameters _forgetPasswordParameters;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();

  const ResetPasswordScreen({super.key,
    required ForgetPasswordParameters parameters,
  })  :_forgetPasswordParameters = parameters;
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _newPasswordController ;
  late TextEditingController _confirmNewPasswordController ;
  late ResetPasswordViewModel _viewModel;


  void _onSubmit(context) async {
    NavigationService.pushNamedAndRemoveUntil(CommonRoutes.layoutScreen);
    return ;
    FocusScope.of(context).unfocus();
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        String password = _newPasswordController.text;
        widget._forgetPasswordParameters.setPassword(password: password);
        var response = await _viewModel.resetPassword(parameters: widget._forgetPasswordParameters);

        if (response.isSuccess) {
          NavigationService.pushNamedAndRemoveUntil(CommonRoutes.layoutScreen);

          // if(widget._forgetPasswordParameters.userType == UserType.customer){
          //   NavigationService.pushNamedAndRemoveUntil(Routes.customerLayoutScreen);
          // }else{
          //   NavigationService.pushNamedAndRemoveUntil(Routes.contractorLayoutScreen);
          // }
        }
      }
    }
  }

  @override
  void initState() {
    _newPasswordController = TextEditingController();
    _confirmNewPasswordController = TextEditingController();
    _viewModel = Provider.of<ResetPasswordViewModel>(context,listen: false);
    super.initState();
  }
  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    bool isLoading = context.watch<ResetPasswordViewModel>().isLoading;
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
                  child: CustomListAnimator(
                    children: [

                      Text(tr(LocaleKeys.createNewPassword),style: TextStyle().titleStyle(fontSize: 26).colorWhite(),),
                      Text(tr(LocaleKeys.resetPasswordMessage),style: TextStyle().semiBoldStyle(fontSize: 14).colorWhite(),),

                      VerticalSpace(kScreenPaddingNormal.h),

                      Form(
                        key: _formKey,
                        child: Column(
                          children: [

                            CustomTextFieldPassword(
                              label:tr(LocaleKeys.passwordHint),
                              hint:tr(LocaleKeys.passwordHint),
                              textInputAction: TextInputAction.done,
                              controller: _newPasswordController,
                              labelColor: Theme.of(context).hintColor,
                            ),

                            VerticalSpace( kFormPaddingAllLarge.h),

                            CustomTextFieldPassword(

                              hint:tr(LocaleKeys.confirmPassword),
                              label:tr(LocaleKeys.confirmPassword),
                              textInputAction: TextInputAction.done,
                              controller: _confirmNewPasswordController,
                              labelColor: Theme.of(context).hintColor,
                              validateFunc:(value){
                                if (_newPasswordController.text != value && (value ?? '').isNotEmpty) {
                                  return tr(LocaleKeys.confirmPasswordDoesNotMatchPassword);
                                }
                                if (value.toString().length <= 5) {
                                  return tr(LocaleKeys.msgConfirmPasswordRequired);
                                }
                                return null;
                              },
                            ),
                            VerticalSpace(32.h),
                            CustomButton(
                              loading: isLoading,
                              title: tr(LocaleKeys.submit),
                              onTap: () async => _onSubmit(context),
                            ),
                            VerticalSpace(32.h),
                          ],
                        ),
                      ),
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
}
