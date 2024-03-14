import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/state/auth/providers/auth_state_providers.dart';
import 'package:saferent/views/components/constants/app_colors.dart';
import 'package:saferent/views/components/term_agreements_comp.dart';
import 'package:saferent/views/constants/strings.dart';
import 'package:saferent/views/login/apple_button.dart';
import 'package:saferent/views/login/google_button.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [0.1, 0.7, 0.7, 0.6],
                  colors: [Colors.white, Colors.grey, Colors.grey, Colors.grey],
                ),
                border: Border.all(color: Colors.grey), // Black border
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Safe',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'R',
                          style: TextStyle(
                              fontSize: 45,
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'ents',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Center(
                      child: Icon(
                        CupertinoIcons.lock_circle_fill,
                        color: Colors.red,
                        size: 70,
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'Welcome To SafeRents\n Tired of Broker Headache \n Watch And Book A Tour ',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            height: 1.2,
                            wordSpacing: 0.1,
                            fontSize: 12,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    Text(
                      Strings.accLogIn,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          height: 1.5,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: AppColors.butttonColor,
                          foregroundColor: Colors.black),
                      onPressed: () {
                        ref.read(authStateProvider.notifier).loginWithGoogle();
                      },
                      child: const GoogleButton(),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: AppColors.butttonColor,
                          foregroundColor: Colors.black),
                      onPressed: () {
                        ref.read(authStateProvider.notifier).loginWithGoogle();
                      },
                      child: const AppleButton(),
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TermsAndConditions(),
                    const Divider(
                      color: Colors.black38,
                    ),
                    Text(
                      'Copyright \u{00A9} 2024 Qb Tech Ltd\n  All rights reserved.\u{2122} ',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          height: 1.5,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
