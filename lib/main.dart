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

// Main Portal class that extends StatelessWidget
class SafeRents extends StatelessWidget {
  // Constructor for the Portal clasz
  const SafeRents({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Disable the debug
      // banner in the top right corner
      debugShowCheckedModeBanner: false,
      // Define the app's theme
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
        indicatorColor: Colors.black,
        textTheme: GoogleFonts.openSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      // Define the app's home page based on user authentication status
      home: Consumer(
        builder: (context, ref, child) {
          // Listen for changes in isLoadingProvider
          ref.listen<bool>(
            isLoadingProvider,
            (_, isLoading) {
              // Show or hide the loading screen based on the isLoading status
              if (isLoading) {
                LoadingScreen.instance().show(context: context);
              } else {
                LoadingScreen.instance().hide();
              }
            },
          );
          // Check the isLoggedInProvider for the user's authentication status
          final isLoggedIn = ref.watch(isLoggedInProvider);
          // Return the appropriate widget based on authentication status
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
