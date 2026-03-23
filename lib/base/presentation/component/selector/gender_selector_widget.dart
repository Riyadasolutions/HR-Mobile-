import 'package:base_app/base/presentation/component/component.dart';
import 'package:base_app/core/constants/enums.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/generated/assets.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';


class GenderSelectorWidget extends StatelessWidget {
  final _tag = 'GenderSelectorWidget';
  final Function(GenderType) _onSelected;
  final GenderType? _selectedValue;

  const GenderSelectorWidget({
    super.key,
    required Function(GenderType) onSelected,
    required GenderType? selectedValue,
  })  : _onSelected = onSelected,
        _selectedValue = selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(tr(LocaleKeys.gender),style:  Theme.of(context).inputDecorationTheme.labelStyle),
        VerticalSpace(kFormPaddingAllSmall.h),
        Row(
          children: [
            Expanded(child: _buildCard(context,GenderType.male)),
            HorizontalSpace(kFormPaddingAllLarge.w),
            Expanded(child: _buildCard(context,GenderType.female)),
          ],
        ),
      ],
    );
  }

  _buildCard(BuildContext context,GenderType type) {
    bool isSelected = _selectedValue == type;
    return CustomTapEffect(
      onTap: () => _onSelected(type),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          // SvgPicture.asset(type==GenderType.male?Assets.iconsUserIcon:Assets.iconsFemaleIcon ,height: 24.r,width: 24.r,color: isSelected?Theme.of(context).primaryColor:Theme.of(context).hintColor),

          Expanded(
            child: CustomCard(
              radius: kFormRadius,
              elevation:1,
              child: Container(
                height: 50.h,
                padding: EdgeInsets.all(kFormPaddingAllLarge.r),
                decoration: const BoxDecoration().radius().customColor(isSelected?Theme.of(context).primaryColorLight.withOpacity(0.2):Theme.of(context).cardColor ).borderStyle(color: isSelected?Theme.of(context).primaryColor:Colors.transparent),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomIconText(
                        mainAxisAlignment: MainAxisAlignment.center,
                          title: tr(type.name),
                          textStyle: const TextStyle().liteStyle(fontSize: 16).primaryTextColor().customColor(isSelected?const Color(0xff66232F):null),
                          icon: type == GenderType.male
                              ? Assets.iconsMaleIcon
                              : Assets.iconsFemaleIcon,
                      ),
                    ),
                    HorizontalSpace(kFormPaddingAllLarge.w),
                    CustomRadio(value: type, groupValue: _selectedValue, onChanged: (v){}),

                  ],
                ),
              ),
            ),
          )

        ],
      ),
    );
  }
}
