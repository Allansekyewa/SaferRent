import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:saferent/views/components/constants/strings.dart';
import 'package:saferent/views/components/loading/loading_screen_controller.dart';

class LoadingScreen {
  LoadingScreen._sharedInstance();
  static final LoadingScreen _shared = LoadingScreen._sharedInstance();
  factory LoadingScreen.instance() => _shared;
  LoadingScreenController? _controller;

  void show({
    required BuildContext context,
    String text = Strings.loading,
  }) {
    if (_controller?.update(text) ?? false) {
      return;
    } else {
      _controller = showOverlay(context: context, text: text);
    }
  }

  void hide() {
    _controller?.close();
    _controller = null;
  }

  LoadingScreenController? showOverlay({
    required BuildContext context,
    required String text,
  }) {
    final state = Overlay.of(context);
    // ignore: unnecessary_null_comparison
    if (state == null) {
      return null;
    }
    final textController = StreamController<String>();
    textController.add(text);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final overLay = OverlayEntry(builder: (context) {
      return Material(
        color: Colors.black.withAlpha(150),
        child: Center(
          child: Container(
            constraints: BoxConstraints(
                maxWidth: size.width * 0.5,
                maxHeight: size.height * 0.5,
                minWidth: size.width * 0.5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const CupertinoActivityIndicator(
                      color: Colors.black,
                      radius: 6,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    StreamBuilder(
                      stream: textController.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.requireData,
                            style: const TextStyle(
                                fontSize: 10, color: Colors.red),
                          );
                        } else {
                          return Container();
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
    state.insert(overLay);
    return LoadingScreenController(close: () {
      textController.close();
      overLay.remove();
      return true;
    }, update: (text) {
      textController.add(text);
      return true;
    });
  }
}
