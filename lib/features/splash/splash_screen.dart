import 'package:bcsports_mobile/features/auth/ui/widgets/logo.dart';
import 'package:bcsports_mobile/utils/animations.dart';
import 'package:bcsports_mobile/widgets/scaffold.dart';
import 'package:flutter/cupertino.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const LogoWidget(),
            const SizedBox(
              height: 16,
            ),
            AppAnimations.circleIndicator
          ],
        ),
      ),
      canPop: false,
    );
  }
}
