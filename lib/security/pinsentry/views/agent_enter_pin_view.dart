import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/admin/views/admin_panel.dart';
import 'package:saferent/security/agentformssubmission/view/agents_register_view.dart';
import 'package:saferent/security/pinsentry/providers/generate_pin_provider.dart';
import 'package:saferent/state/image_upload/helpers/image_picker_helpers.dart';
import 'package:saferent/state/image_upload/models/file_type.dart';
import 'package:saferent/state/post_settings/providers/post_settings_provider.dart';
import 'package:saferent/views/components/constants/app_colors.dart';
import 'package:saferent/views/create_new_post/create_new_post.dart';

class AgentEnterPinView extends ConsumerStatefulWidget {
  const AgentEnterPinView({Key? key}) : super(key: key);
  @override
  _AgentEnterPinViewState createState() => _AgentEnterPinViewState();
}

class _AgentEnterPinViewState extends ConsumerState<AgentEnterPinView> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  String? _errorText;
  bool _pinEntered = false;
  bool _phoneEntered = false;
  void _generatePin(BuildContext context) async {
    final enteredPhone = _phoneNumberController.text;
    if (enteredPhone.isNotEmpty) {
      final value = ref.read(generateAndReturnPinProvider(enteredPhone));
      value.when(
        data: (generatedPin) {
          // ignore: unnecessary_type_check
          if (generatedPin is String) {
            _pinController.text = generatedPin;
            setState(() {
              _errorText = null;
              _pinEntered = true;
              _phoneEntered = true;
            });
          } else {
            setState(() {
              _errorText = "Failed to generate a PIN";
            });
          }
        },
        loading: () {
          // Handle loading state if needed.
        },
        error: (error, stackTrace) {
          setState(() {
            _errorText = error.toString();
          });
        },
      );
    } else {
      setState(() {
        _errorText = "Phone Number is required";
      });
    }
  }

  void _navigateToCreateNewPost(BuildContext context) async {
    if (_pinEntered && _phoneEntered) {
      final videoFile = await ImagePickerHelper.pickVideoFromGallery();
      if (videoFile == null) {
        return;
      }
      ref.refresh(postSettingProvider);
      if (!mounted) {
        return;
      }
      _pinController.clear();
      _phoneNumberController.clear();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CreateNewPost(
            fileToPost: videoFile,
            fileType: FileType.video,
          ),
        ),
      );
    } else {
      setState(() {
        _errorText = "Enter A Verified Saferents Ref Id To Proceed.";
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
          "Enter Verified SAfeRents Ref Id For Access",
          style: TextStyle(fontSize: 12, color: Colors.black),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.white),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: AppColors.butttonColor,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: const Text(
                        "⚠️ Warning: Agent Authentication Alert ⚠️\n\n"
                        "To ensure the security of your agent account, please only enter the valid ref id associated with your agency verification when prompted. SafeRents will authenticate your identity through ref id.\n\n"
                        "🔐 Agent Security Notice:\n"
                        "This authentication process is crucial for safeguarding your account. Do not exceed three attempts, as multiple unsuccessful tries may lead to the revocation of your access to the Portal.\n\n"
                        "🚨 Caution: Protect Your PassCode!\n"
                        "Never share your passcode or any confidential information. SafeRents will never request your passcode outside of the secure authentication process. If you receive any unsolicited requests for your credentials, report them immediately to SafeRents support team.\n\n"
                        "Remember, your account security is our top priority. Thank you for your cooperation.",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: _phoneNumberController,
                      obscureText: true,
                      obscuringCharacter: '*',
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          CupertinoIcons.phone_arrow_up_right,
                          color: Colors.red,
                        ),
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        labelText: "Enter Verified Ref Id",
                        labelStyle: const TextStyle(fontSize: 10),
                        suffixIcon: IconButton(
                          onPressed: () {
                            _generatePin(context);
                          },
                          icon: const Icon(
                            Icons.cable,
                            color: Colors.red,
                            size: 20,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _pinController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            _navigateToCreateNewPost(context);
                          },
                          icon: const Icon(
                            CupertinoIcons.forward_fill,
                            color: Colors.green,
                            size: 20,
                          ),
                        ),
                        prefixIcon: const Icon(
                          CupertinoIcons.pin_fill,
                          size: 15,
                          color: Colors.red,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        hintText: "Awaiting pin generation...",
                        hintStyle:
                            const TextStyle(fontSize: 8, color: Colors.red),
                        errorText: _errorText,
                      ),
                      keyboardType: TextInputType.number,
                      obscureText: true,
                    ),
                    const Divider(
                      color: Colors.red,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Want To  Become Our Agent Click Below",
                      style: TextStyle(fontSize: 10, color: Colors.red),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AgentsRegisterPage(),
                          ),
                        );
                      },
                      icon: const Icon(
                        CupertinoIcons.person_3_fill,
                      ),
                      label: const Text(
                        'Become Our Agent',
                        style: TextStyle(color: Colors.green, fontSize: 10),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AdminPanelPage(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.admin_panel_settings_sharp,
                        color: Colors.green,
                      ),
                      label: const Text(
                        "Admin Strictly",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.red,
                        ),
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

  @override
  void dispose() {
    _pinController.dispose();
    _phoneNumberController.dispose();

    super.dispose();
  }
}
