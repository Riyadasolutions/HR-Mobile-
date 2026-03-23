import 'package:base_app/base/presentation/component/spaces.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnimatedLogo extends StatefulWidget {
  final double? _size;
  final Color? _color;
  final bool _withName;
  final double? _nameSize;
  const AnimatedLogo({  
    
    required double? size,
    Color? color,
    bool withName = false,
    double? nameSize,
  }) : _size = size, _color = color,_withName = withName,_nameSize = nameSize;
  @override
  State<AnimatedLogo> createState() => _AnimatedLogoState();


}

class _AnimatedLogoState extends State<AnimatedLogo>  with SingleTickerProviderStateMixin   {

  late final AnimationController _animationController;
  late final Animation<double> _part1Turns;
  late final Animation<double> _part2Turns;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 14),)..repeat(); // .repeat(reverse: false)
    _part1Turns = _animationController;
    _part2Turns = ReverseAnimation(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
            height: widget._size,width: widget._size,
          child: Stack(
            children: [
        
              RotationTransition(
                  turns: _part1Turns, // 0..1 == 0..360°
                  child: SvgPicture.asset(Assets.logoSmallLogoPart1,height: widget._size,width: widget._size,colorFilter: widget._color==null?null:ColorFilter.mode(widget._color!, BlendMode.srcIn),)
              ),
        
              RotationTransition(
                  turns: _part2Turns, // 0..1 == 0..360°
        
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SvgPicture.asset(Assets.logoSmallLogoPart2,height: widget._size,width: widget._size,colorFilter: widget._color==null?null:ColorFilter.mode(widget._color!, BlendMode.srcIn),),
                  )
              ),
            ],
          ),
        ),
        if(widget._withName)...[
          VerticalSpace(kFormPaddingAllLarge.h),
          Text("CareConnect",style: TextStyle().titleStyle(fontSize: widget._nameSize??22).colorWhite(),),
        ]
      ],
    );
  }
}
