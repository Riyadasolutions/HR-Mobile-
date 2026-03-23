import 'package:flutter/material.dart';

import '../component.dart';

class CustomPaginationListView<T> extends StatefulWidget {
  final Function _onLoadMore;

  final bool _isLoading;
  final bool _isMoreLoading;
  final List<Widget>? _slivers;
  final List<T> _list;
  final int _currentPage;
  final bool _hasMorePages;
  final bool? _isEmpty;
  final double _loadingHeight;
  final NullableIndexedWidgetBuilder _builder;
  final WidgetBuilder? _noDataBuilder ;
  final WidgetBuilder? _loadingBuilder ;
  final VoidCallback? _onRetry;
  final ScrollController? _controller ;

  @override
  _CustomPaginationListViewState createState() => _CustomPaginationListViewState();

  const CustomPaginationListView({super.key,
    required VoidCallback onLoadMore,
    required bool isMoreLoading,
    double loadingHeight=100,
    bool isLoading=false,
    List<Widget>? slivers,
    required List<T> list,
    required int currentPage,
    required bool hasMorePages,
     bool? isEmpty,
    WidgetBuilder? noDataBuilder,
    WidgetBuilder? loadingBuilder,
    VoidCallback? onRetry,
    ScrollController? controller ,

    required NullableIndexedWidgetBuilder builder,
  })  : _onLoadMore = onLoadMore,
        _isMoreLoading = isMoreLoading,
        _isLoading = isLoading,
        _noDataBuilder = noDataBuilder,
        _loadingBuilder = loadingBuilder,
        _loadingHeight= loadingHeight,
        _controller = controller,
        _isEmpty = isEmpty,
        _onRetry = onRetry,

        _slivers = slivers,
        _list = list,
        _currentPage = currentPage,
        _hasMorePages = hasMorePages,
        _builder = builder;
}

class _CustomPaginationListViewState extends State<CustomPaginationListView> {
  late ScrollController _scrollController;

  bool _canLoadMore = true;
  @override
  void dispose() {
    super.dispose();

    _scrollController.removeListener(() {});
  }

  @override
  void initState() {

    super.initState();
    _scrollController =ScrollController();
    if(widget._controller==null){
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

    // _scrollController.addListener(() {
    //   // Listening while at the bottom of the page
    //   if (_scrollController.position.pixels >= (_scrollController.position.maxScrollExtent-150.h) &&! widget._isLoading&&
    //   // if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent &&
    //       !_scrollController.position.outOfRange && widget._currentPage <= widget._hasMorePages
    //   ) {
    //     widget._onLoadMore();
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller:  widget._controller?? _scrollController,

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
            expandedHeight: widget._loadingHeight,
            backgroundColor: Colors.transparent,
            // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            flexibleSpace:  widget._loadingBuilder!=null? widget._loadingBuilder!(context): const CustomLoadingSpinner(),
          ),

        ]else if((widget._isEmpty==true)||widget._list.isEmpty)...[
          SliverAppBar(
            pinned: false,
            snap: false,
            floating: true,
            leadingWidth: 0,
            elevation: 0.0,
            leading: const SizedBox(),
            expandedHeight: 350.0,
            backgroundColor: Colors.transparent,
            // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            flexibleSpace: widget._noDataBuilder!=null? widget._noDataBuilder!(context):  CustomNoDataView(onReload:widget._onRetry),
          ),
        ]else...[
          SliverList(delegate: SliverChildBuilderDelegate(widget._builder, childCount: widget._list.length),),
        ],


        if(!widget._isLoading &&widget._isMoreLoading)
        SliverToBoxAdapter(
          child: SizedBox(
            height: 40,
            child: Center(child: !widget._isLoading &&widget._isMoreLoading ?  const CustomLoadingSpinner(size: 20,) :  const SizedBox(height: 40.0),),
          ),
        ),
      ],
    );
  }
}
