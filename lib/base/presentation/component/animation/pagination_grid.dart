import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:flutter/material.dart';

import '../component.dart';

class CustomPaginationGridview<T> extends StatefulWidget {
  final Function _onLoadMore;

  final bool _isLoading;
  final bool _isMoreLoading;
  final List<Widget>? _slivers;
  final List<T> _list;
  final bool _hasMorePages;
  final NullableIndexedWidgetBuilder _builder;
  final double _height;
  final double _width;
  final double _crossAxisSpacing;
  final double _mainAxisSpacing;

  @override
  _CustomPaginationGridviewState createState() => _CustomPaginationGridviewState();

  const CustomPaginationGridview({super.key,
    required VoidCallback onLoadMore,
    required bool isMoreLoading,
    bool isLoading = false,
    List<Widget>? slivers,
    required List<T> list,
    required int currentPage,
    required bool hasMorePages,
    required NullableIndexedWidgetBuilder builder,
    double height = 172,
    double width = 172,
    double crossAxisSpacing = kFormPaddingHorizontal,
    double mainAxisSpacing = kFormPaddingHorizontal,
  })  : _onLoadMore = onLoadMore,
        _isLoading = isLoading,
        _isMoreLoading = isMoreLoading,
        _slivers = slivers,
        _list = list,
        _hasMorePages = hasMorePages,
        _builder = builder,
        _height = height,
        _width = width,
        _crossAxisSpacing = crossAxisSpacing,
        _mainAxisSpacing = mainAxisSpacing;
}

class _CustomPaginationGridviewState extends State<CustomPaginationGridview> {
  final ScrollController _scrollController =  ScrollController();

  bool _canLoadMore = true;
  @override
  void dispose() {
    super.dispose();

    _scrollController.removeListener(() {});
  }

  @override
  void initState() {
    super.initState();

    if (!widget._hasMorePages) {
      _scrollController.removeListener(() {});
    }

    _scrollController.addListener(() async{
      // Listening while at the bottom of the page
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent-200 && !widget._isLoading &&
          /*!_scrollController.position.outOfRange &&*/ widget._hasMorePages&&_canLoadMore) {
        setState(() {_canLoadMore = false;});
        await widget._onLoadMore();
        setState(() {_canLoadMore = true;});

      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,

      slivers: [
        if (widget._slivers != null)...widget._slivers!,

        if(widget._isLoading)...[
          SliverAppBar(
            pinned: false,
            snap: false,
            floating: true,
            leadingWidth: 0,
            elevation: 0.0,
            leading: const SizedBox(),
            expandedHeight: 100.0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            flexibleSpace:  const CustomLoadingSpinner(),
          ),

        ]else if(widget._list.isEmpty)...[
          SliverAppBar(
            pinned: false,
            snap: false,
            floating: true,
            leadingWidth: 0,
            elevation: 0.0,
            leading: const SizedBox(),
            expandedHeight: 300.0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            flexibleSpace:   CustomNoDataView(),
          ),
        ]else...[
          SliverGrid(
            delegate: SliverChildBuilderDelegate(widget._builder,
                childCount: widget._list.length),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: widget._width,
              mainAxisSpacing: widget._mainAxisSpacing,
              childAspectRatio: 10,
              crossAxisSpacing: widget._crossAxisSpacing,
              mainAxisExtent: widget._height.h,
            ),
          ),
        ],


        SliverToBoxAdapter(
          child: SizedBox(
            height: 40,
            child: Center(
              child: !widget._isLoading &&widget._isMoreLoading
                  ?  const CustomLoadingSpinner(size: 20,)
                  :  const SizedBox(height: 40.0),
            ),
          ),
        ),
      ],
    );
  }
}
