import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/admin/views/admin_control_panel.dart';
import 'package:saferent/agentsactivity/providers/generate_agent_activity_pin_provider.dart';
import 'package:saferent/views/components/constants/app_colors.dart';

class AgentsActivityPage extends ConsumerStatefulWidget {
  const AgentsActivityPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AgentsActivityPageState();
}

class _AgentsActivityPageState extends ConsumerState<AgentsActivityPage> {
  final TextEditingController _refIdController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();

  String? _errorMessage;
  bool _pinEntered = false;
  bool _refIdEntered = false;
  void _generatedAgentActPin(BuildContext context) async {
    final enteredRefId = _refIdController.text;
    if (enteredRefId.isNotEmpty) {
      final asyncValue = ref.read(generateAgentsActPinProvider(enteredRefId));
      asyncValue.when(
          data: (generatedAgentActPin) {
            // ignore: unnecessary_type_check
            if (generatedAgentActPin is String) {
              _pinController.text = generatedAgentActPin;
              setState(() {
                _errorMessage = null;
                _pinEntered = true;
                _refIdEntered = true;
              });
            } else {
              setState(() {
                _errorMessage = 'Pin Generation Failed';
              });
            }
          },
          error: (error, stackTrace) {
            setState(() {
              _errorMessage = error.toString();
            });
          },
          loading: () {});
    } else {
      setState(() {
        _errorMessage = 'Agent refId Required';
      });
    }
  }

  void _navigateTo(BuildContext context) {
    if (_pinEntered && _refIdEntered) {
      _pinController.clear();
      _refIdController.clear();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const AgentActivityControlPanel()));
    } else {
      setState(() {
        _errorMessage = 'Enter A Verified Agent Ref id For Access';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Agents Activity',
          style: TextStyle(fontSize: 12, color: Colors.black),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                  '⚠️ Agents-Only Area ⚠️\n\n'
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
                      controller: _refIdController,
                      obscureText: true,
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      obscuringCharacter: '*',
                      decoration: InputDecoration(
                        labelText: 'Enter Agent Ref Id',
                        suffixIcon: IconButton(
                          onPressed: () {
                            _generatedAgentActPin(context);
                          },
                          icon: const Icon(
                            CupertinoIcons.arrow_2_circlepath,
                            color: Colors.red,
                            size: 20,
                          ),
                        ),
                        labelStyle: const TextStyle(fontSize: 10),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
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
    );
  }
}
