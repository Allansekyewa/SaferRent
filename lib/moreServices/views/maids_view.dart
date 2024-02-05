import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/moreServices/houseMaids/providers/house_maid_provider.dart';
import 'package:saferent/views/components/constants/app_colors.dart';
import 'package:saferent/views/extensions/dismiss_keyboard.dart';

class MaidsRegPage extends HookConsumerWidget {
  const MaidsRegPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final maidNameController = useTextEditingController();
    final phoneController = useTextEditingController();
    final handlersController = useTextEditingController();
    final handlersPhoneController = useTextEditingController();
    final descriptionController = useTextEditingController();
    return Scaffold(
      backgroundColor: AppColors.butttonColor,
      appBar: AppBar(
        title: const Text(
          'Maids',
          style: TextStyle(fontSize: 10, color: Colors.red),
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
                      style: TextStyle(fontSize: 10, color: Colors.red),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: maidNameController,
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
                        labelText: 'Maids Phone Number',
                        labelStyle: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                        hintText: 'Maids PhoneNumber',
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
                      controller: handlersController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field Missing';
                        }
                        {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'Handlers Name',
                        labelStyle: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                        hintText: 'Your Handlers Names',
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
                      controller: handlersPhoneController,
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
                      controller: descriptionController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field Missing';
                        }
                        {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        labelStyle: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                        hintText: 'Your Description',
                        hintStyle: TextStyle(fontSize: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                      maxLines: null,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton.icon(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            final isSubmitted = await ref
                                .read(submitMaidsProvider.notifier)
                                .submitMaidsForm(
                                    phoneNumber: phoneController.text,
                                    handlerName: handlersController.text,
                                    description: descriptionController.text,
                                    names: maidNameController.text,
                                    handlersPhone: handlersPhoneController.text,
                                    createdAt: DateTime.timestamp());
                            if (isSubmitted) {
                              phoneController.clear();
                              handlersController.clear();
                              descriptionController.clear();
                              maidNameController.clear();
                              handlersPhoneController.clear();
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
