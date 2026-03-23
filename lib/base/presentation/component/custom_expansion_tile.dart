import 'package:auto_size_text/auto_size_text.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:flutter/material.dart';

class CustomExpansionTile extends StatefulWidget {
  final String _title;
  final List<Widget> _children;
  final bool _initiallyExpanded;
  final bool _enable;

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();

  const CustomExpansionTile({
    required String title,
    required List<Widget> children,
     bool initiallyExpanded= true,
     bool enable= true,
  })  : _title = title,
        _enable= enable,
        _children = children,
        _initiallyExpanded = initiallyExpanded;
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget._enable ==true?widget._initiallyExpanded:true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: widget._enable?() => setState(() => _isExpanded = !_isExpanded):null,
          child: Row(
            children: [
              Expanded(
                child: AutoSizeText(
                  widget._title,
                  style: const TextStyle().titleStyle(fontSize: 14).primaryTextColor(),
                  maxLines: 1,
                ),
              ),
              if(widget._enable)Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
            ],
          ),
        ),
        //
        // AnimatedCrossFade(
        //   firstChild: const SizedBox.shrink(),
        //   secondChild: Column(children: widget._children),
        //   crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        //   duration: const Duration(milliseconds: 300),
        // ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: ConstrainedBox(
            constraints: _isExpanded
                ? const BoxConstraints()
                : const BoxConstraints(maxHeight: 0),
            child: Column(children: widget._children),
          ),
        ),


      ],
    );
  }
}
