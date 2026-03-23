import 'package:auto_size_text/auto_size_text.dart';
import 'package:base_app/core/constants/constants.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../../../base/presentation/component/component.dart';



class ServiceItem extends StatelessWidget {
  final String _image;
  final String _title;
  final String _desc;
  final VoidCallback? _onTap;


  const ServiceItem({
    required String image,
    required String title,
    required String desc,
    required VoidCallback? onTap,
  })  : _image = image,
        _title = title,
        _desc = desc,
        _onTap = onTap;

  @override
  Widget build(BuildContext context) {
    return CustomTapEffect(
      onTap: _onTap ,
      child: CustomCard(
        child: Padding(
          padding: kCardPadding,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomImage(imageUrl: _image,height: 80.r,width: 80.r,showBorder: false,radius: kFormRadiusSmall,),
              ),


              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(kFormPaddingAllNormal.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(_title,style: const TextStyle().semiBoldStyle().primaryTextColor().ellipsisStyle(),maxLines: 1,),
                      Text(_desc,style: const TextStyle().regularStyle(fontSize: 14).primaryTextColor()),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


}
