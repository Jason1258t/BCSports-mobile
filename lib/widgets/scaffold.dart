import 'package:bcsports_mobile/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold(
      {super.key,
      required this.body,
      this.color,
      this.padding,
      this.appBar,
      this.bottomNavBar,
      this.floatingButton,
      this.canPop = true,
      this.resize = false,
      this.onPopInvoked,
      this.isSafeArea = true, this.onTap});

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavBar;
  final Widget? floatingButton;
  final bool canPop;
  final bool resize;
  final bool isSafeArea;
  final void Function(bool)? onPopInvoked;
  final Function()? onTap;

  final Color? color;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final child = Scaffold(
      resizeToAvoidBottomInset: resize,
      backgroundColor: Colors.transparent,
      floatingActionButton: floatingButton,
      body: Padding(
        padding: padding ?? const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: body,
      ),
      appBar: appBar,
      bottomNavigationBar: bottomNavBar,
    );

    return PopScope(
      canPop: canPop,
      onPopInvoked: onPopInvoked,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          if (onTap != null) {
            onTap!();
          }
        },
        child: Container(
            color: color ?? AppColors.background,
            child: isSafeArea ? SafeArea(child: child) : child),
      ),
    );
  }
}
