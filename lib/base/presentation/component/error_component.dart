import 'package:base_app/base/data/datasource/remote/exception/error_model.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/generated/assets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:base_app/generated/locale_keys.g.dart';


class CustomErrorView extends StatelessWidget {
  final ErrorModel? _errorModel;
  final VoidCallback? _onRetry;
  final String? _image;
  final String _imageSvg;

  const CustomErrorView({super.key,
    ErrorModel? errorModel,
    VoidCallback? onRetry,
    String? image,
    String imageSvg=Assets.emptyStateErrorImage,
  })  : _errorModel = errorModel,
        _onRetry = onRetry,
        _image = image,
        _imageSvg = imageSvg;

  @override
  Widget build(BuildContext context) {
    return ErrorView(message: _errorModel?.errorMessage??'Error',onRetry: _onRetry,imageSvg: _imageSvg,image: _image,);

  }


}

class ErrorView extends StatelessWidget {
  final String? _message;
  final VoidCallback? _onRetry;
  final String? _image;
  final String _imageSvg;

  const ErrorView({super.key,
    String? message,
    VoidCallback? onRetry,
    String? image,
    String imageSvg=Assets.emptyStateErrorImage,
  })  : _message = message,
        _onRetry = onRetry,
        _image = image,
        _imageSvg = imageSvg;




  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              (_image != null)? Image.asset(_image) : SvgPicture.asset(_imageSvg, width: 200.w, height: 200.h, fit: BoxFit.fill),

              Text(_message ?? '',style: const TextStyle().regularStyle(fontSize: 12),textAlign: TextAlign.center),
              SizedBox(height: 20.h,),
              if(_onRetry != null)
                TextButton(
                  onPressed: _onRetry,
                  style: TextButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0), side: const BorderSide(color: Colors.grey)),),
                  child: Text(
                    tr(LocaleKeys.retry),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),

                ),
            ],
          ),
        )
    );
  }
}