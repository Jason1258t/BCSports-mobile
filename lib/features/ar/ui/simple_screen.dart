import 'package:bcsports_mobile/widgets/appBar/empty_app_bar.dart';
import 'package:bcsports_mobile/widgets/buttons/button_back.dart';
import 'package:bcsports_mobile/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

class UnityViewScreen extends StatefulWidget {
  const UnityViewScreen({Key? key, this.scene}) : super(key: key);

  final String? scene;

  @override
  State<UnityViewScreen> createState() => _UnityViewScreenState();
}

class _UnityViewScreenState extends State<UnityViewScreen> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();

  UnityWidgetController? _unityWidgetController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _unityWidgetController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScaffold(
        padding: EdgeInsets.zero,
        appBar: EmptyAppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ButtonBack(onTap: () {
                Navigator.pop(context);
              })
            ],
          ),
        ),
        body: UnityWidget(
          onUnityCreated: _onUnityCreated,
          onUnityMessage: onUnityMessage,
          onUnitySceneLoaded: onUnitySceneLoaded,
          useAndroidViewSurface: true,
          fullscreen: false,
          borderRadius: const BorderRadius.all(Radius.circular(70)),
        ),
      ),
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
