import 'package:base_app/base/presentation/component/component.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LocationFiled extends StatelessWidget {
  final String _address;
  final ValueChanged<String> _onUpdate;

  const LocationFiled({
    super.key,
    required String address,
    required ValueChanged<String> onUpdate,
  })  : _address = address,
        _onUpdate = onUpdate;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(tr(LocaleKeys.location), style: const TextStyle().regularStyle()),
        CustomCard(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Padding(
            padding:EdgeInsets.all(kFormPaddingAllLarge.r),
            child: Column(
              children: [
                Container(
                  padding:EdgeInsets.all(kFormPaddingAllLarge.r),
                  decoration: const BoxDecoration().radius().customColor(const Color(0xffF9F8FF)),
                  child: Text(_address, style: const TextStyle().liteStyle(fontSize: 16).primaryTextColor()),
                ),
                VerticalSpace(kFormPaddingAllLarge.h),
                CustomButton(title: tr(LocaleKeys.changeLocation),onTap: (){},color: Theme.of(context).cardColor,textColor:  Theme.of(context).primaryColor)
              ],
            ),
          ),
        )
      ],
    );
  }
}
