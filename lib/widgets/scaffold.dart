import 'package:bcsports_mobile/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold(
      {super.key,
      required this.body,
      this.color,
      this.padding,
      this.appBar,
      this.canPop = true,
      this.resize = false,
      this.onPopInvoked});

  final Widget body;
  final PreferredSizeWidget? appBar;
  final bool canPop;
  final bool resize;
  final void Function(bool)? onPopInvoked;

  final Color? color;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      onPopInvoked: onPopInvoked,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
            color: color ?? AppColors.background,
            child: SafeArea(
                child: Scaffold(
                  resizeToAvoidBottomInset: resize,
                  backgroundColor: Colors.transparent,
                  body: Padding(
                    padding: padding ?? const EdgeInsets.fromLTRB(20,20,20,0),
                    child: body,
                  ),
                  appBar: appBar,
                ))),
      ),
    );
  }
}
