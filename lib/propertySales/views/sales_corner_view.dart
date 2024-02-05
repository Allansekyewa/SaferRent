import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/propertySales/providers/generate%20_property_pin_provider.dart';
import 'package:saferent/propertySales/views/sales_submit.dart';
import 'package:saferent/views/components/constants/app_colors.dart';

class SalesSubmitPin extends ConsumerStatefulWidget {
  const SalesSubmitPin({Key? key}) : super(key: key);

  @override
  _SalesSubmitPinState createState() => _SalesSubmitPinState();
}

class _SalesSubmitPinState extends ConsumerState<SalesSubmitPin> {
  final TextEditingController _pinControler = TextEditingController();
  bool _pinEntered = false;
  void _generatePass(BuildContext context) async {
    final enteredPasscode = _pinControler.text;
    if (enteredPasscode.isNotEmpty) {
      final value = ref.read(generateandReturnProvider(enteredPasscode));
      value.when(
        data: (generatePass) {
          // ignore: unnecessary_type_check
          if (generatePass is String) {
            _pinControler.text = generatePass;
            setState(() {
              _pinEntered = true;
            });
          }
        },
        loading: () {},
        error: (Object error, StackTrace stackTrace) {
          setState(() {});
        },
      );
    } else {
      setState(() {});
    }
  }

  void _navigateToPropertyForms(BuildContext context) async {
    if (_pinEntered) {
      _pinControler.clear();
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SalesTabView()));
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.butttonColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(color: Colors.white),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: const Text(
                        "Before accessing the property sales listing form, please be aware of the following rules and procedures. A fee of 100,000 UGX is required for the field agent, covering transportation, filming, and expeditious job execution related to your property. Additionally, upon successful property sale, the portal is entitled to 10% of the sale fee. Call 0761439068 to generate a unique PIN from the portal, crucial for limiting potential fraudulent activities. Moreover, all property documentations, including deeds and titles, must be provided to the portal for attestation before listing. Only after completing these steps, payment of stipulated fees, and submitting required documents will your property be posted on the portal. The portal reserves the right to ensure legitimacy and adherence to these rules before listing any property. Thank you for your cooperation.",
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                    const Text(
                      "If You Have Agreed To The Above Proceed",
                      style: TextStyle(fontSize: 12, color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _pinControler,
                      obscureText: true,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          onPressed: () {
                            _generatePass(context);
                          },
                          icon: const Icon(
                            CupertinoIcons.pin_fill,
                            size: 16,
                            color: Colors.orange,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                        labelText: 'Call 0761439068 for pin',
                        labelStyle: const TextStyle(fontSize: 10),
                        suffixIcon: IconButton(
                          onPressed: () {
                            _navigateToPropertyForms(context);
                          },
                          icon: const Icon(
                            Icons.forward,
                            color: Colors.green,
                            size: 16,
                          ),
                        ),
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
        ),
      ),
    );
  }
}
