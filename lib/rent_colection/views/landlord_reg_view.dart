import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/rent_colection/providers/submit_landlord_provider.dart';
import 'package:saferent/state/auth/providers/user_id_provider.dart';

import 'package:saferent/views/extensions/dismiss_keyboard.dart';

class LandlordRegistrationPage extends HookConsumerWidget {
  LandlordRegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final phoneNumberController = useTextEditingController();
    final bankAccountController = useTextEditingController();
    final locationController = useTextEditingController();
    final refIdController = useTextEditingController();
    final unitNumberController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Subit New LandLord',
          style: TextStyle(fontSize: 12),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: SafeArea(
              child: Center(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: nameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Field Missing';
                      }
                      {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'Names',
                      labelStyle:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                      hintText: 'Your Names',
                      hintStyle: TextStyle(fontSize: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: phoneNumberController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Field Missing';
                      }
                      {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      labelStyle:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                      hintText: 'LandLord PhoneNumbers',
                      hintStyle: TextStyle(fontSize: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Field Missing';
                      }
                      {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'Email Address',
                      labelStyle:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                      hintText: 'Your Email Address',
                      hintStyle: TextStyle(fontSize: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: locationController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Field Missing';
                      }
                      {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'Unit Location',
                      labelStyle:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                      hintText: 'Units Location',
                      hintStyle: TextStyle(fontSize: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: bankAccountController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Field Missing';
                      }
                      {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'Bank Account',
                      labelStyle:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                      hintText: 'Your Bank Account',
                      hintStyle: TextStyle(fontSize: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: refIdController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Field Missing';
                      }
                      {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'Reference Id',
                      labelStyle:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                      hintText: 'LandLord Ref Id',
                      hintStyle: TextStyle(fontSize: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: unitNumberController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Field Missing';
                      }
                      {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'Unit Numbers',
                      labelStyle:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                      hintText: 'Enter unit numbers separated by comma',
                      hintStyle: TextStyle(fontSize: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                    onFieldSubmitted: (value) {
                      // Split the input string by comma and add the units to the list
                      final unitNumbers = value.split(',');
                      // Now you can use unitNumbers list where each unit is an independent entry
                      //ref.read(unitNumbersProvider).state.value = unitNumbers;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton.icon(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          final userId = ref.watch(userIdProvider);
                          if (userId == null) {
                            // Handle the case where userId is null
                            // For example, show an error message to the user

                            return;
                          }
                          final submit = await ref
                              .read(submitLandlordProvider.notifier)
                              .submitLandlord(
                                  fromUserId: userId,
                                  phoneNumber: phoneNumberController.text,
                                  refId: refIdController.text,
                                  location: locationController.text,
                                  bankAccount: bankAccountController.text,
                                  email: emailController.text,
                                  unitNos: unitNumberController.text,
                                  names: nameController.text);
                          if (submit) {
                            phoneNumberController.clear();
                            refIdController.clear();
                            bankAccountController.clear();
                            locationController.clear();
                            emailController.clear();
                            unitNumberController.clear();
                            nameController.clear();
                            dismissKeyboard();
                          }
                        }
                      },
                      icon: const Icon(Icons.send_and_archive),
                      label: const Text(
                        'Submit',
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.end,
                      ))
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}
