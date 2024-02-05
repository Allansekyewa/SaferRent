import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/views/components/constants/app_colors.dart';
import 'package:saferent/views/constants/strings.dart';
import 'package:saferent/views/extensions/dismiss_keyboard.dart';
import 'package:saferent/views/main/general_reports/providers/general_report_provider.dart';

class SubmitReportsView extends HookConsumerWidget {
  const SubmitReportsView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final repController = useTextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Back',
          style: TextStyle(fontSize: 12),
        ),
      ),
      backgroundColor: AppColors.butttonColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: SafeArea(
                child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(4.0)),
                    child: const Text(
                      'Dear valued client, we encourage you to actively report any issues or observations you encounter with our agents, movers, maids, and other personnel. Your feedback is crucial in helping us maintain the highest standards of service. Please use the form below to submit your reports. Your input is greatly appreciated and will be used to improve our operations.',
                      style: TextStyle(color: Colors.red, fontSize: 11),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: repController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Field Missing';
                      }
                      {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'Make You Report Here',
                      hintMaxLines: null,
                      labelStyle:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                      hintText: 'Your Reports Here',
                      hintStyle: TextStyle(fontSize: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                  ),
                  TextButton.icon(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          final isSubmitted = await ref
                              .read(submitReportProvider.notifier)
                              .submitReport(
                                  report: repController.text,
                                  createdAt: DateTime.timestamp());
                          if (isSubmitted) {
                            repController.clear();
                            dismissKeyboard();
                          }
                        }
                      },
                      icon: const Icon(Icons.save),
                      label: const Text(Strings.sub))
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }
}
