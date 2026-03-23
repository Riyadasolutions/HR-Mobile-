import 'package:base_app/base/presentation/component/component.dart';
import 'package:base_app/core/constants/constants.dart';
import 'package:base_app/features/common/domain/entity/news_entity.dart';
import 'package:base_app/features/common/presentation/modules/layout/children/news/widget/news_item.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';

class NewsScreen extends StatefulWidget {

  @override
  State<NewsScreen> createState() => _NewsScreenState();

  const NewsScreen({super.key,
  }) ;
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(title: tr(LocaleKeys.news),isBackButtonExist: false,),
      body: Padding(padding: kScreenPadding,
        child: CustomScreenStateLayout(
          isEmpty: true,
          builder:(context) =>  CustomListAnimatorData(

            itemCount: 0/*dummyNews.length*/,

            itemBuilder: (context, index) => NewsItem(entity: dummyNews[index] ),
          ),
        ),
      ),
    );
  }
}
