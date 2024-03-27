import 'package:bcsports_mobile/utils/animations.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/widgets/appBar/empty_app_bar.dart';
import 'package:bcsports_mobile/widgets/buttons/button_back.dart';
import 'package:bcsports_mobile/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

class UnityViewScreen extends StatefulWidget {
  const UnityViewScreen({Key? key, this.scene, this.title}) : super(key: key);

  final String? scene;
  final String? title;

  @override
  State<UnityViewScreen> createState() => _UnityViewScreenState();
}

class _UnityViewScreenState extends State<UnityViewScreen> {
  UnityWidgetController? _unityWidgetController;

  bool loaded = false;

  @override
  void initState() {
    super.initState();
    start();
  }

  void start() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      loaded = true;
    });
  }

  @override
  void dispose() {
    _unityWidgetController?.dispose();
    // _unityWidgetController?.unload();// TODO
    // _unityWidgetController?.quit();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScaffold(
          padding: EdgeInsets.zero,
          appBar: EmptyAppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonBack(onTap: () {
                  _unityWidgetController?.postMessage(
                    'MenuScenes',
                    'HandleScene',
                    'Back',
                  );
                  Navigator.pop(context);
                }),
                Text(
                  widget.title ?? '',
                  style: AppFonts.font18w600,
                ),
                const SizedBox(
                  width: 40,
                )
              ],
            ),
          ),
          body: loaded
              ? UnityWidget(
                  unloadOnDispose: false, // TODO что-то
                  onUnityCreated: _onUnityCreated,
                  onUnityMessage: onUnityMessage,
                  onUnitySceneLoaded: onUnitySceneLoaded,
                  useAndroidViewSurface: true,
                  fullscreen: false,
                  hideStatus: false,
                  placeholder: Center(
                    child: AppAnimations.circleIndicator,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(70)),
                )
              : Center(
                  child: AppAnimations.circleIndicator,
                )),
    );
  }

  void setScene(String sceneName) {
    _unityWidgetController?.postMessage(
      'MenuScenes',
      'HandleScene',
      sceneName,
    );
  }

  void onUnityMessage(message) {
    print('Received message from unity: ${message.toString()}');
  }

  void onUnitySceneLoaded(SceneLoaded? scene) {
    if (scene != null) {
      print('Received scene loaded from unity: ${scene.name}');
      print('Received scene loaded from unity buildIndex: ${scene.buildIndex}');
    } else {
      print('Received scene loaded from unity: null');
    }
  }

  // Callback that connects the created controller to the unity controller
  void _onUnityCreated(controller) {
    controller.resume();
    _unityWidgetController = controller;
    if (widget.scene != null) {
      setScene(widget.scene!);
    }
  }
}
