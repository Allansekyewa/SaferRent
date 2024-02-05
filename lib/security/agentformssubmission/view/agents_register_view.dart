import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/security/agentformssubmission/providers/submit_agent_form_provider.dart';
import 'package:saferent/security/views/Rules_of_engagement.dart';
import 'package:saferent/views/components/constants/app_colors.dart';
import 'package:saferent/views/constants/strings.dart';
import 'package:saferent/views/extensions/dismiss_keyboard.dart';

class AgentsRegisterPage extends HookConsumerWidget {
  const AgentsRegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final phoneController = useTextEditingController();
    final refPhoneController = useTextEditingController();
    final ninController = useTextEditingController();
    final educController = useTextEditingController();
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final locController = useTextEditingController();

    return Scaffold(
      backgroundColor: AppColors.butttonColor,
      appBar: AppBar(
        title: const Text(
          'Agents Registration Form',
          style: TextStyle(
              fontSize: 11, color: Colors.red, fontWeight: FontWeight.bold),
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
                    Text(
                      'Want To make Some Extra cash Register with Us For Your Finacial Freedom But First Read Our Rules Of Engagement .',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          height: 2.5,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                    const Divider(
                      color: Colors.red,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Rules Of Engagement',
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const RulesAndEngagement(),
                              ),
                            );
                          },
                      ),
                    ),
                    Text(
                      'Ive Read And Agreed To The Agents Rules Of Engagement So Am Ready To Fill The Form .',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            height: 2.5,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const Divider(
                      color: Colors.red,
                    ),
                    Text(
                      'Agents Registration Form ',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            height: 2.5,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                      textAlign: TextAlign.center,
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
                        labelStyle: TextStyle(fontSize: 10),
                        hintText: 'Your Current Location',
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
                      controller: refPhoneController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Field Missing";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Refree Phone Number',
                        labelStyle: TextStyle(fontSize: 10),
                        hintText: 'Enter Ref Phone Number',
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
                    TextFormField(
                      controller: educController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Field Missing";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Education Level',
                        labelStyle: TextStyle(fontSize: 10),
                        hintText: 'Enter Education Level',
                        hintStyle: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          final isSubmitted = await ref
                              .read(submitAgentFormProvider.notifier)
                              .submitForm(
                                  phoneNumber: phoneController.text,
                                  ninNumber: ninController.text,
                                  refNo: refPhoneController.text,
                                  educationLevel: educController.text,
                                  names: nameController.text,
                                  location: locController.text,
                                  email: emailController.text,
                                  fromuserId: '',
                                  formId: '',
                                  createdAt: DateTime.timestamp()

                                  //
                                  );

                          if (isSubmitted) {
                            ninController.clear();
                            refPhoneController.clear();
                            phoneController.clear();
                            educController.clear();
                            emailController.clear();
                            locController.clear();
                            nameController.clear();
                            dismissKeyboard();
                          }
                        }
                      },
                      icon: const Icon(
                        Icons.forward_outlined,
                        color: Colors.green,
                        size: 18,
                      ),
                      label: const Text(
                        Strings.sub,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      ),
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
