import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:saferent/security/agentformssubmission/providers/admin_verify_provider.dart';
import 'package:saferent/security/agentformssubmission/providers/agent_activity_provider.dart';
import 'package:saferent/security/agentformssubmission/providers/verify_phone_number_provider.dart';

import 'package:saferent/views/extensions/dismiss_keyboard.dart';

class AdminScreen extends HookConsumerWidget {
  final GlobalKey<FormState> _agentFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _adminFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _agentIdFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passCodeFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _ninFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _refFormKey = GlobalKey<FormState>();

  AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agentphoneController = useTextEditingController();
    final adminPhoneController = useTextEditingController();
    final agentNameController = useTextEditingController();
    final passcodeController = useTextEditingController();
    final ninController = useTextEditingController();
    final refController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Agent Panel',
          style: TextStyle(fontSize: 14, color: Colors.red),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Fill in Agent phone number and click "verify agent"',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Form(
                key: _agentFormKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: agentphoneController,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      labelText: 'Agent Phone Number',
                      labelStyle: TextStyle(fontSize: 10),
                      prefixIcon: Icon(
                        CupertinoIcons.phone_solid,
                        color: Colors.red,
                        size: 18,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return 'Phone number is required'; // Validation error message
                      }
                      return null; // Return null for no error
                    },
                  ),
                ),
              ),
              Form(
                key: _ninFormKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: ninController,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      labelText: 'Agent Nin Number',
                      labelStyle: TextStyle(fontSize: 10),
                      prefixIcon: Icon(
                        CupertinoIcons.number,
                        color: Colors.green,
                        size: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return 'Nin number is required'; // Validation error message
                      }
                      return null; // Return null for no error
                    },
                  ),
                ),
              ),
              Form(
                key: _refFormKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: refController,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      labelText: 'Agents Referee Number',
                      labelStyle: TextStyle(fontSize: 10),
                      prefixIcon: Icon(
                        CupertinoIcons.phone_arrow_right,
                        color: Colors.blue,
                        size: 18,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return 'Referee Phone number is required'; // Validation error message
                      }
                      return null; // Return null for no error
                    },
                  ),
                ),
              ),
              Form(
                key: _agentIdFormKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: agentNameController,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      labelText: 'Agent Name',
                      labelStyle: TextStyle(fontSize: 10),
                      prefixIcon: Icon(
                        CupertinoIcons.person,
                        color: Colors.purple,
                        size: 18,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return 'Agent ID is required'; // Validation error message
                      }
                      return null; // Return null for no error
                    },
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_agentFormKey.currentState!.validate() &&
                      _agentIdFormKey.currentState!.validate() &&
                      _ninFormKey.currentState!.validate() &&
                      _refFormKey.currentState!.validate()) {
                    final isSave = await ref
                        .read(verifyPhoneProvider.notifier)
                        .saveVerifiedPhoneNumber(
                            phoneNumber: agentphoneController.text,
                            agentId: agentNameController.text,
                            refNumber: refController.text,
                            ninNumber: ninController.text);
                    if (isSave) {
                      agentphoneController.clear();
                      agentNameController.clear();
                      refController.clear();
                      ninController.clear();
                      dismissKeyboard();
                    }
                  }
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(CupertinoIcons.person_2_square_stack),
                    SizedBox(width: 8.0),
                    Text(
                      'Verify Agent',
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(
                  color: Colors.red,
                ),
              ),
              const Text(
                'Fill in verified Administrator Phone Number and click "verify admin"',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Form(
                key: _adminFormKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: adminPhoneController,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      labelText: 'Admin Phone Number',
                      labelStyle: TextStyle(fontSize: 10),
                      prefixIcon: Icon(
                        CupertinoIcons.phone_arrow_right,
                        color: Colors.red,
                        size: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return 'Phone number is required'; // Validation error message
                      }
                      return null; // Return null for no error
                    },
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  if (_adminFormKey.currentState!.validate()) {
                    final isSave = await ref
                        .read(verifyAdminProvider.notifier)
                        .saveVerifiedAdmin(
                            adminPhone: adminPhoneController.text);
                    if (isSave) {
                      adminPhoneController.clear();
                      dismissKeyboard();
                    }
                  }
                },
                icon: const Icon(
                  Icons.admin_panel_settings,
                  color: Colors.green,
                  size: 18,
                ),
                label: const Text(
                  'verify admin',
                  style: TextStyle(fontSize: 10),
                ),
              ),
              const Divider(
                color: Colors.red,
              ),
              const Text(
                'Enter A passcode to be used verified agent for access "save passcode"',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Form(
                key: _passCodeFormKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: passcodeController,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      labelText: 'Agent Ref Id  passcode',
                      labelStyle: TextStyle(fontSize: 10),
                      prefixIcon: Icon(
                        CupertinoIcons.printer_fill,
                        color: Colors.purple,
                        size: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return 'passcode is required'; // Validation error message
                      }
                      return null; // Return null for no error
                    },
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  if (_passCodeFormKey.currentState!.validate()) {
                    final isSave = await ref
                        .read(agentActivityProvider.notifier)
                        .saveAgentActivity(refId: passcodeController.text);
                    if (isSave) {
                      passcodeController.clear();
                      dismissKeyboard();
                    }
                  }
                },
                label: const Text(
                  'submit Agent RefId',
                  style: TextStyle(fontSize: 12),
                ),
                icon: const Icon(
                  CupertinoIcons.person_2_alt,
                  size: 16,
                  color: Colors.blue,
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
