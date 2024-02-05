import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/moreServices/movingServices/providers/submit_movers_form_provider.dart';
import 'package:saferent/views/components/constants/app_colors.dart';
import 'package:saferent/views/extensions/dismiss_keyboard.dart';

class MoversRegPage extends HookConsumerWidget {
  const MoversRegPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final companyNameController = useTextEditingController();
    final nameController = useTextEditingController();
    final locController = useTextEditingController();
    final phoneController = useTextEditingController();
    return Scaffold(
      backgroundColor: AppColors.butttonColor,
      appBar: AppBar(
        title: const Text(
          'Movers',
          style: TextStyle(
              fontSize: 12, color: Colors.red, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Enter Correct Data Of the the Moving Company in the forms below',
                      style: TextStyle(fontSize: 10, color: Colors.green),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: companyNameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field Missing';
                        }
                        {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'Company names',
                        labelStyle: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                        hintText: 'Your Names',
                        hintStyle: TextStyle(fontSize: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
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
                        labelStyle: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                        hintText: 'Your Names',
                        hintStyle: TextStyle(fontSize: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: phoneController,
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
                        labelStyle: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                        hintText: 'Your Phone Number',
                        hintStyle: TextStyle(fontSize: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: locController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field Missing';
                        }
                        {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'Loction',
                        labelStyle: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                        hintText: 'Your Location',
                        hintStyle: TextStyle(fontSize: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton.icon(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            final isSubmit = await ref
                                .read(subitMoversFormProvider.notifier)
                                .submitMovers(
                                    phoneNumber: phoneController.text,
                                    companyName: companyNameController.text,
                                    location: locController.text,
                                    names: nameController.text,
                                    createdAt: DateTime.timestamp());
                            if (isSubmit) {
                              phoneController.clear();
                              companyNameController.clear();
                              locController.clear();
                              nameController.clear();
                              dismissKeyboard();
                            }
                          }
                        },
                        icon: const Icon(Icons.forward),
                        label: const Text(
                          'Submit',
                          style: TextStyle(fontSize: 10),
                        ))
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
