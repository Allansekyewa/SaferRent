import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:saferent/propertySales/views/sales_corner_view.dart';
import 'package:saferent/security/agentformssubmission/view/agents_register_view.dart';
import 'package:saferent/views/main/general_reports/views/submit_report_view.dart';


class ExtrasViewTab extends StatelessWidget {
  const ExtrasViewTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  text: 'Reports Submission',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SubmitReportsView()),
                      );
                    },
                ),
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text: 'Property Sales Submission',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SalesSubmitPin()),
                      );
                    },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                    text: 'Become Our Agent',
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.black,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AgentsRegisterPage()));
                      }),
              ),
              const SizedBox(
                height: 10,
              ),
              RichText(
                  text: const TextSpan(
                      text: 'For Devs 👨‍💻 ::: Coming Soon',
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.red,
                          fontStyle: FontStyle.italic)))
            ],
          ),
        ),
      ),
    );
  }
}
