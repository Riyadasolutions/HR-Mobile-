import 'package:auto_size_text/auto_size_text.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/features/common/domain/entity/news_entity.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../../../base/presentation/component/component.dart';



class NewsItem extends StatelessWidget {

  final NewsEntity _entity;
  const NewsItem({super.key,
    required NewsEntity entity,
  })  : _entity = entity;



  @override
  Widget build(BuildContext context) {
    return CustomTapEffect(
      onTap:(){},
      // onTap: () => NavigationService.push(HotelRoutes.serviceDetailScreen,arguments: {'id':_entity.id}),
      child: CustomCard(
        child: Container(
          // decoration: const BoxDecoration().borderStyle().radius(),
          // width: 264.w,height: 228.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImage(imageUrl: _entity.image,height: 163.h,showHighlight: true,showBorder: true,radius: kFormRadiusSmall,),


              Padding(
                padding: EdgeInsets.all(kFormPaddingAllNormal.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(_entity.title,style: const TextStyle().semiBoldStyle().primaryTextColor().ellipsisStyle(),maxLines: 1,),
                    AutoSizeText(_entity.desc,style: const TextStyle().regularStyle().primaryTextColor().ellipsisStyle(),maxLines: 2,),

                  ],
                ),

              )


            ],
          ),
        ),
      ),
    );
  }

}
