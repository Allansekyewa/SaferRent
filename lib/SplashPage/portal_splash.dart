import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saferent/SplashPage/Splashs/text_splash.dart';
import 'package:saferent/SplashPage/splash_type_enum.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:saferent/views/login/login.dart';
import 'package:saferent/views/main/portal_main.dart';

typedef AsyncCallback = Future Function();

class PortalsSplash extends StatefulWidget {
  PortalsSplash({
    Key? key,
    this.nextScreen,
    this.duration,
    this.setStateTimer = const Duration(milliseconds: 100),
    this.setStateCallback,
    this.onInit,
    this.backgroundcolor,
    this.text,
    this.backgroundImage,
    this.onEnd,
    this.gradient,
    this.asyncNavigationCallBack,
    this.useImmersiveMode = false,
  }) : super(key: key);

  Duration? duration;
  Color? backgroundcolor;
  Text? text;
  Duration setStateTimer;
  AsyncCallback? asyncNavigationCallBack;
  VoidCallback? onInit;
  VoidCallback? onEnd;
  Widget? nextScreen;
  Image? backgroundImage;
  bool useImmersiveMode;
  SplashType splashType = SplashType.custom;
  VoidCallback? setStateCallback;
  Gradient? gradient;

  @override
  State<PortalsSplash> createState() => _PortalsSplashState();

  PortalsSplash.text({
    Key? key,
    required this.text,
    required this.nextScreen,
    required this.duration,
    required this.setStateTimer,
    required this.setStateCallback,
    required this.onEnd,
    required this.onInit,
    required this.backgroundImage,
    required this.useImmersiveMode,
  }) {
    splashType = SplashType.text;
  }
}

class _PortalsSplashState extends State<PortalsSplash> {
  bool isUserAlreadyLoggedIn = false;

  @override
  void initState() {
    super.initState();
    if (widget.useImmersiveMode) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    }
    widget.onInit = () async {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        isUserAlreadyLoggedIn = true;
      } else {
        isUserAlreadyLoggedIn = false;
      }
    };
    widget.onInit?.call();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    Future.delayed(widget.setStateTimer, () {
      if (mounted) {
        widget.setStateCallback?.call();
        setState(() {});
      }
    });
    if (widget.asyncNavigationCallBack != null) {
      assert(widget.duration == null,
          await widget.asyncNavigationCallBack?.call());
    } else {
      widget.duration ??= const Duration(seconds: 5);
    }
    Future.delayed(widget.duration ?? const Duration(), () {
      if (mounted) {
        widget.onEnd = () async {
          if (isUserAlreadyLoggedIn) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return const PortalsMain();
            }));
          } else {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return const LoginPage();
            }));
          }
        };
        widget.onEnd?.call();
        if (widget.nextScreen == null) {
          return;
        }
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return widget.nextScreen ?? Container();
        }));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.useImmersiveMode) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.splashType == SplashType.text) {
      return TextSplash()
        ..text = widget.text?.data
        ..textHeight = 100 // Change this according to your needs
        ..textWidth = 200 // Change this according to your needs
        ..backgroundColor = widget.backgroundcolor
        ..gradient = widget.gradient;
    }
    return Scaffold(
      backgroundColor: widget.backgroundcolor,
    );
  }
}
