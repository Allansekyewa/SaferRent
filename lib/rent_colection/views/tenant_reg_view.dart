import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/rent_colection/providers/sunmitTenant_provider.dart';
import 'package:saferent/views/components/constants/app_colors.dart';
import 'package:saferent/views/extensions/dismiss_keyboard.dart';

class TenantRegistrationPage extends HookConsumerWidget {
  const TenantRegistrationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final phoneController = useTextEditingController();
    final landlordRefController = useTextEditingController();
    final ninController = useTextEditingController();
    final unitNoController = useTextEditingController();
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final locController = useTextEditingController();
    final rentAmountController = useTextEditingController();
    return Scaffold(
      backgroundColor: AppColors.butttonColor,
      appBar: AppBar(
        title: const Text(
          'Tenant Management Form',
          style: TextStyle(fontSize: 15, color: Colors.red),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: SafeArea(
              child: Center(
            child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Welcome to SafeRents Rent Collection Tool Start Off By Registering To Avoid Incoviniences And Please Only Provide Accurate information',
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                    const Divider(
                      color: Colors.red,
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
                        labelText: 'Email',
                        labelStyle: TextStyle(fontSize: 10),
                        hintText: 'Email Address',
                        hintStyle: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
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
                        labelStyle: TextStyle(fontSize: 10),
                        hintText: 'Valid Phone',
                        hintStyle: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: ninController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Field Missing";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Nin Number',
                        labelStyle: TextStyle(fontSize: 10),
                        hintText: 'Enter Nin Number',
                        hintStyle: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: locController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Field Missing";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Location',
                        labelStyle: TextStyle(fontSize: 10),
                        hintText: 'Enter Unit Location',
                        hintStyle: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: unitNoController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Field Missing";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Unit Number',
                        labelStyle: TextStyle(fontSize: 10),
                        hintText: 'Enter Unit Number',
                        hintStyle: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: rentAmountController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field Missing';
                        }
                        {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'Rent Amount',
                        labelStyle: TextStyle(fontSize: 10),
                        hintText: 'Your Rent Amount',
                        hintStyle: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: landlordRefController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Field Missing";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'LandLord Reference Id',
                        labelStyle: TextStyle(fontSize: 10),
                        hintText: 'Enter LandLord Ref Id',
                        hintStyle: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      color: Colors.red,
                    ),
                    TextButton.icon(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            final isSubm = await ref
                                .read(submitTenantProvider.notifier)
                                .submitTenant(
                                    fromUserId: '',
                                    phoneNumber: phoneController.text,
                                    amount: rentAmountController.text,
                                    ninNumber: ninController.text,
                                    names: nameController.text,
                                    location: locController.text,
                                    unitnumber: unitNoController.text,
                                    email: emailController.text,
                                    landlordRef: landlordRefController.text,
                                    createdAt: DateTime.timestamp());
                            if (isSubm) {
                              ninController.clear();
                              phoneController.clear();
                              unitNoController.clear();
                              emailController.clear();
                              landlordRefController.clear();
                              rentAmountController.clear();
                              locController.clear();
                              nameController.clear();
                              dismissKeyboard();
                            }
                          }
                        },
                        icon: const Icon(Icons.send_and_archive_rounded),
                        label: const Text('Submit'))
                  ],
                )),
          )),
        ),
      ),
    );
  }
}
