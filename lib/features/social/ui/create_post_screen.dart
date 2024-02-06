import 'package:bcsports_mobile/features/social/ui/widgets/small_text_button.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/widgets/scaffold.dart';
import 'package:flutter/material.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  bool buttonActive = false;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SmallTextButton(
              text: 'Discard',
              onTap: () => Navigator.pop(context),
              type: SmallTextButtonType.withoutBackground,
            ),
            Text('CREATE', style: AppFonts.font14w400,),

            SmallTextButton(
              text: 'Publish',
              onTap: () {},
              active: buttonActive,
            ),
          ],
        ),
      ),
    );
  }
}
