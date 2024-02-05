import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/propertySales/providers/submit_prperty_sales_provider.dart';
import 'package:saferent/views/components/constants/app_colors.dart';

class SalesTabView extends HookConsumerWidget {
  const SalesTabView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final phoneController = useTextEditingController();
    final typeController = useTextEditingController();
    final locController = useTextEditingController();
    final desController = useTextEditingController();
    final namesController = useTextEditingController();

    return Scaffold(
      backgroundColor: AppColors.butttonColor,
      appBar: AppBar(
        title: const Text(
          'Enter Correct Data In All Forms',
          style: TextStyle(fontSize: 12),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: namesController,
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
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: typeController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field Missing';
                        }
                        {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'Property Type',
                        labelStyle: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                        hintText: 'Property Type',
                        hintStyle: TextStyle(fontSize: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
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
                        labelText: 'Location',
                        labelStyle: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                        hintText: 'Property Location',
                        hintStyle: TextStyle(fontSize: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
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
                        labelText: 'Contacts',
                        labelStyle: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                        hintText: 'Your Contacts',
                        hintStyle: TextStyle(fontSize: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: desController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field Missing';
                        }
                        {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'Descrption',
                        labelStyle: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                        hintText: 'Describe your property',
                        hintMaxLines: null,
                        hintStyle: TextStyle(fontSize: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
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
                              .read(propertySalesProvider.notifier)
                              .submitPropertySales(
                                names: namesController.text,
                                description: desController.text,
                                type: typeController.text,
                                location: locController.text,
                                phoneNumber: phoneController.text,
                                createdAt: DateTime.timestamp(),
                              );
                          if (isSubmit) {
                            locController.clear();
                            phoneController.clear();
                            typeController.clear();
                            desController.clear();
                            namesController.clear();
                          }
                        }
                      },
                      icon: const Icon(
                        Icons.send,
                        size: 16,
                        color: Colors.green,
                      ),
                      label: const Text(
                        'submit',
                        style: TextStyle(fontSize: 10),
                      ),
                    )
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
