import 'package:base_app/base/data/datasource/remote/exception/error_model.dart';
import 'package:base_app/base/data/datasource/remote/exception/error_model.dart';
import 'package:flutter/material.dart';

import 'component.dart';

class CustomScreenStateLayout extends StatelessWidget {
  final bool _isEmpty;
  final bool _isLoading;
  final ErrorModel? _error;
  final WidgetBuilder? _errorBuilder;
  final WidgetBuilder? _loadingBuilder;
  final VoidCallback? _onRetry;
  final WidgetBuilder _builder ;
  final WidgetBuilder? _noDataBuilder ;

  const CustomScreenStateLayout({super.key,
    required  WidgetBuilder builder,
    bool isEmpty = false,
    ErrorModel? error,
    bool isLoading = false,
    WidgetBuilder? errorBuilder,
    WidgetBuilder? loadingBuilder,
    WidgetBuilder? noDataBuilder,
    VoidCallback? onRetry,
  })
      :_isEmpty = isEmpty,_isLoading = isLoading,_error= error,
        _errorBuilder = errorBuilder,
        _loadingBuilder = loadingBuilder,
        _noDataBuilder = noDataBuilder,
        _builder = builder,
        _onRetry = onRetry;

  @override
  Widget build(BuildContext context) {
    if(_onRetry!=null){
      return RefreshIndicator(
        onRefresh: ()async {_onRetry();},
        child: _buildView(context),
      );
    }else{
      return _buildView(context);
    }

  }



  Widget _buildView(BuildContext context) {
    if (_isLoading) {
      return _loadingBuilder!=null? _loadingBuilder(context):const Center(child: CustomLoadingSpinner());
    }   else if(_error != null){

      return _errorBuilder!=null? _errorBuilder(context): CustomErrorView(errorModel: _error, onRetry: _onRetry,);
    } else if(_isEmpty){
      return _noDataBuilder!=null? _noDataBuilder(context):  CustomNoDataView(onReload:_onRetry);
    } else{
      return _builder(context);
    }
  }
}
