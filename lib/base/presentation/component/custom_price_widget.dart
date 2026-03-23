import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/price_converter.dart';
import 'component.dart';

class CustomPriceWithDepositWidget extends StatelessWidget {
  final num _price;
  final num _deposit;
  final bool _isOfferEnable ;

  const CustomPriceWithDepositWidget({
    super.key,
    required num price,
    required num deposit,
    required bool isOfferEnable,
  })  : _price = price,
        _isOfferEnable = isOfferEnable,
        _deposit = deposit;

  @override
  Widget build(BuildContext context) {



    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if(_price != _deposit && _deposit!=0)...[

                CustomPriceView(value: _price,maxLines: 1 ),
                HorizontalSpace(kFormPaddingAllSmall.h),

                CustomPriceView(
                    value: _deposit,
                    maxLines: 1,
                    oldPrice: true,
                    numberStyle: TextStyle().regularStyle(fontSize: 14).semiBoldStyle().customColor(AppColor.hintColor.themeColor).heightStyle().copyWith(decoration: TextDecoration.lineThrough),
                    currencyStyle: TextStyle().regularStyle(fontSize: 14).semiBoldStyle().customColor(AppColor.hintColor.themeColor).heightStyle().copyWith(decoration: TextDecoration.lineThrough),
                ),

                // Text(PriceConverter.convertPrice(_deposit),style: const TextStyle().regularStyle(fontSize: 16).semiBoldStyle().customColor( AppColor.hintColor.themeColor ).heightStyle().copyWith(decoration: TextDecoration.lineThrough),),
              ] else ...[
                CustomPriceView(value: _price, maxLines: 1,),
              ],
            ],
          ),
        ),

        // if(_endDate.isNotEmpty&&_isOfferEnable)...[
        //   Text('${tr(LocaleKeys.offerEndAt)} ${DateConverter.isoStringToDateToDomain(_endDate)}',style: const TextStyle().descriptionStyle().errorStyle().semiBoldStyle()),
        // ],
      ],
    );
  }



}
