import 'package:flutter/cupertino.dart';

class AnimatedRoute<T> extends CupertinoPageRoute<T> {
  AnimatedRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(
            builder: builder,
            maintainState: maintainState,
            settings: settings,
            fullscreenDialog: fullscreenDialog);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    const begin = Offset(1, 0);
    const end = Offset.zero;
    final tween = Tween(begin: begin, end: end);

    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeIn, // You can change the curve as needed
      reverseCurve:
          Curves.easeInOut, // You can change the reverse curve as needed
    );

    return SlideTransition(
      position: tween.animate(curvedAnimation),
      child: child,
    );
  }
}
