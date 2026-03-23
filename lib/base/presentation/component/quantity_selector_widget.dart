import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:flutter/material.dart';
import 'spaces.dart';

class QuantitySelectorWidget extends StatelessWidget {
  final int _value;
  final ValueChanged<int>? _onChanged;
  final int _minValue;
  final int _maxValue;
  final String? _label;
  final String? _error;

  const QuantitySelectorWidget({
    super.key,
    required int value,
    ValueChanged<int>? onChanged,
    int minValue = 0,
    int? maxValue,
    String? label,
    String? error,
  })  : _value = value,
        _onChanged = onChanged,
        _minValue = minValue,
        _maxValue = maxValue ?? 999,
        _label = label,
        _error = error;

  @override
  Widget build(BuildContext context) {
    final canDecrement = _value > _minValue;
    final canIncrement = _value < _maxValue;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_label != null) ...[
          Text(
            _label!,
            style: Theme.of(context).inputDecorationTheme.labelStyle!,
          ),
          VerticalSpace(kFormPaddingAllSmall.h),
        ],
        Container(
          decoration: BoxDecoration(
            color: AppColor.cardColor.themeColor,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: _error != null
                  ? AppColor.errorColor.themeColor
                  : AppColor.borderColor.themeColor,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Minus button
              InkWell(
                onTap: canDecrement && _onChanged != null
                    ? () => _onChanged!(_value - 1)
                    : null,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.r),
                  bottomLeft: Radius.circular(12.r),
                ),
                child: Container(
                  padding: EdgeInsets.all(12.w),
                  child: Icon(
                    Icons.remove,
                    color: canDecrement
                        ? AppColor.textColor.themeColor
                        : AppColor.unselectedWidgetColor.themeColor,
                    size: 20.r,
                  ),
                ),
              ),
              // Value display
              Expanded(
                child: Center(
                  child: Text(
                    _value.toString(),
                    style: const TextStyle()
                        .semiBoldStyle(fontSize: 16)
                        .customColor(AppColor.textColor.themeColor),
                  ),
                ),
              ),
              // Plus button
              InkWell(
                onTap: canIncrement && _onChanged != null
                    ? () => _onChanged!(_value + 1)
                    : null,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12.r),
                  bottomRight: Radius.circular(12.r),
                ),
                child: Container(
                  padding: EdgeInsets.all(12.w),
                  child: Icon(
                    Icons.add, 
                    color: canIncrement
                        ? AppColor.primaryColorLight.themeColor
                        : AppColor.unselectedWidgetColor.themeColor,
                    size: 20.r,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (_error != null) ...[
          VerticalSpace(kFormPaddingAllSmall.h),
          Padding(
            padding: EdgeInsets.only(left: 12.w),
            child: Text(
              _error!,
              style: Theme.of(context).inputDecorationTheme.errorStyle,
            ),
          ),
        ],
      ],
    );
  }
}
