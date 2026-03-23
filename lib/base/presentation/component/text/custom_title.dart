
import 'package:base_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:base_app/core/res/resources.dart';



class CustomTitle extends StatelessWidget {
  final String _title;
  final String? _desc;
  final String? _viewAllTitle;
  final GestureTapCallback? _onViewAllTap;
  final MainAxisAlignment _mainAxisAlignment;

  const CustomTitle({
    super.key,
    required String title,
     String? desc,
    String? viewAllTitle,
    GestureTapCallback? onViewAllTap,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
  })  : _title = title,
        _desc = desc,
        _viewAllTitle = viewAllTitle,
        _onViewAllTap = onViewAllTap,
        _mainAxisAlignment = mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: _mainAxisAlignment,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_title,
                      style: TextStyle().semiBoldStyle(fontSize: 16).primaryTextColor(),
                      maxLines: 1,
                    ),
                    if((_desc??'').isNotEmpty)
                      Text(_desc!,
                        style: TextStyle().regularStyle(fontSize: 14).primaryTextColor(),
                        maxLines: 1,
                      ),
                  ],
                ),
              ),
              if(_onViewAllTap!=null)
                GestureDetector(
                  onTap: _onViewAllTap ,
                  child: Row(
                    children: [
                      Text(
                        _viewAllTitle?? tr(LocaleKeys.seeAll),
                        style: const TextStyle().semiBoldStyle().activeColor(),
                        maxLines: 1,
                      ),

                    ],
                  ),
                ),

            ],
          ),
        ),

      ],
    );
  }
}
