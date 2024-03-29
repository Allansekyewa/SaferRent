import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saferent/firebase_options.dart';
import 'package:saferent/state/auth/providers/is_logged_in_provider.dart';
import 'package:saferent/state/providers/is_loading_provider.dart';
import 'package:saferent/views/components/loading/loading_screen.dart';
import 'package:saferent/views/login/login.dart';
import 'package:saferent/views/main/portal_main.dart';

void main() async {
  // Ensure that Flutter is initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase with the default options
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Run the app with Riverpod ProviderScope
  runApp(
    const ProviderScope(
      child: SafeRents(),
    ),
  );
}

class SafeRents extends StatelessWidget {
  const SafeRents({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
        indicatorColor: Colors.black,
        textTheme: GoogleFonts.openSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: Consumer(
        builder: (context, ref, child) {
          ref.listen<bool>(
            isLoadingProvider,
            (_, isLoading) {
              if (isLoading) {
                LoadingScreen.instance().show(context: context);
              } else {
                LoadingScreen.instance().hide();
              }
            },
          );

          final isLoggedIn = ref.watch(isLoggedInProvider);

          if (isLoggedIn) {
            return const PortalsMain();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
