import 'package:flutter/material.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'base_platform_widget.dart';

class CustomLoadingSpinner extends BasePlatformWidget<Center, Center> {
  final Color? _color;
  final double _size;

  @override
  Center createCupertinoWidget(BuildContext context) {
    return Center(child: SpinKitSpinningLines(size:  _size.r,color: _color??Theme.of(context).primaryColor));

    // return Center(child: SpinKitCubeGrid(size:  _size.r,color: _color??Theme.of(context).primaryColor));
    // return Center(child: CupertinoActivityIndicator(radius: 24.r));
  }

  @override
  Center createMaterialWidget(BuildContext context) {
    return Center(child: SpinKitSpinningLines(size:  _size.r,color: _color??Theme.of(context).primaryColor));

    // return Center(
    //   child: SizedBox(
    //     height: (size??24).r,
    //     width: (size??24).r,
    //     child:  CircularProgressIndicator(strokeWidth: 3.w,color: color,),
    //   ),
    // );
  }

  const CustomLoadingSpinner({super.key,
     Color? color,
     double size =60,
  })  : _color = color,
        _size = size;
}
