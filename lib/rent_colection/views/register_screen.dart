import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/rent_colection/views/landlord_reg_view.dart';
import 'package:saferent/rent_colection/views/tenant_reg_view.dart';

class RegisterPage extends HookConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Divider(
                color: Colors.red,
              ),
              const Icon(
                CupertinoIcons.question_circle_fill,
                size: 150,
                color: Colors.red,
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width *
                    0.9, // 90% of screen width
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black),
                ),
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    const Text(
                      'Choose One Below',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    LandlordRegistrationPage()));
                      },
                      label: const Text(
                        'LandLords',
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                      icon: const Icon(Icons.admin_panel_settings),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const TenantRegistrationPage()));
                      },
                      icon: const Icon(
                        Icons.bed,
                        color: Colors.purple,
                      ),
                      label: const Text(
                        'Tenants',
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
