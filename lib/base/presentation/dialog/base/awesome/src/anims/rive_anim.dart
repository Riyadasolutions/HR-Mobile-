import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

///RiveRuntimeRender
class RiveAssetAnimation extends StatefulWidget {
  ///Constructor
  const RiveAssetAnimation({
    super.key,
    required this.assetPath,
    required this.animName,
  });

  ///Path of the .riv assets file
  final String assetPath;

  ///Name od the animation to load
  final String animName;
  @override
  State<RiveAssetAnimation> createState() => _RiveAnimationState();
}

class _RiveAnimationState extends State<RiveAssetAnimation> {
  @override
  Widget build(BuildContext context) {
    return RiveWidgetBuilder(
      fileLoader: FileLoader.fromAsset(
        widget.assetPath,
        riveFactory: Factory.rive,
      ),
      stateMachineSelector: StateMachineNamed(widget.animName),
      builder: (context, state) {
        if (state is RiveLoaded) {
          return RiveWidget(controller: state.controller);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
