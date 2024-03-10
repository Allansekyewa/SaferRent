import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:saferent/admin/views/admin_screen.dart';

import 'package:saferent/security/agentformssubmission/providers/generate_admin_pin_provider.dart';
import 'package:saferent/views/components/constants/app_colors.dart';

class AdminPanelPage extends ConsumerStatefulWidget {
  const AdminPanelPage({Key? key}) : super(key: key);

  @override
  _AdminPanelPageState createState() => _AdminPanelPageState();
}

class _AdminPanelPageState extends ConsumerState<AdminPanelPage> {
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String? _errorMessage;
  bool _pinEntered = false;
  bool _phoneEntered = false;

  void _generatedAdminPin(BuildContext context) async {
    final enteredPhone = _phoneController.text;
    if (enteredPhone.isNotEmpty) {
      final asyncValue =
          ref.read(generateAdminandReturnPinProvider(enteredPhone));

      asyncValue.when(
        data: (generatedAdminPin) {
          // ignore: unnecessary_type_check
          if (generatedAdminPin is String) {
            _pinController.text = generatedAdminPin;
            setState(() {
              _errorMessage = null;
              _pinEntered = true;
              _phoneEntered = true;
            });
          } else {
            setState(() {
              _errorMessage = 'Pin Generation Failed';
            });
          }
        },
        loading: () {},
        error: (error, stackTrace) {
          setState(() {
            _errorMessage = error.toString();
          });
        },
      );
    } else {
      setState(() {
        _errorMessage = 'Admin RefId Required';
      });
    }
  }

  void _navigateTo(BuildContext context) async {
    if (_phoneEntered && _pinEntered) {
      _phoneController.clear();
      _pinController.clear();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AdminScreen()));
    } else {
      setState(() {
        _errorMessage = 'Enter A verified Admin RefId For Access';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'Administration Only',
          style: TextStyle(fontSize: 12, color: Colors.black),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.butttonColor, // Green background color
                    borderRadius:
                        BorderRadius.circular(20), // Circular border radius
                  ),
                  padding: const EdgeInsets.all(20),
                  child: const Text(
                    '⚠️ Admin-Only Area ⚠️\n\n'
                    'Unauthorized access is prohibited. Please refrain from tampering with this field.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 9,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(20), // Circular border radius
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _phoneController,
                        obscureText: true,
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        obscuringCharacter: '*',
                        decoration: InputDecoration(
                          labelText: 'Enter Admin PassCode1',
                          suffixIcon: IconButton(
                            onPressed: () {
                              _generatedAdminPin(context);
                            },
                            icon: const Icon(
                              CupertinoIcons.arrow_2_circlepath_circle,
                              color: Colors.red,
                              size: 20,
                            ),
                          ),
                          labelStyle: const TextStyle(fontSize: 10),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _pinController,
                        obscureText: true,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            hintText: "Awaiting pin generation...",
                            hintStyle:
                                const TextStyle(fontSize: 8, color: Colors.red),
                            errorText: _errorMessage,
                            suffixIcon: IconButton(
                                onPressed: () {
                                  _navigateTo(context);
                                },
                                icon: const Icon(
                                  CupertinoIcons.forward,
                                  color: Colors.green,
                                ))),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
