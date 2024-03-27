import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text(
                'About SafeRents',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              const SizedBox(height: 10),
              const Text(
                'SafeRents is a property technology (proptech) and rental tech business registered under Qb Tech (U) Ltd, based in Kampala, Uganda. We are licensed by the Statutory Registration Bureau (URSB).Hence ensuring quality in both our content starting with our Agents and Our Lines of Opeerations',
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 10),
              const Text(
                'Contact Information',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              const SizedBox(height: 10),
              const Text(
                'Phone: +256 761439068',
                style: TextStyle(fontSize: 12),
              ),
              const Text(
                'Email: alsekx@gmail.com',
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 10),
              const Text(
                'Our Business',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              const SizedBox(height: 10),
              const Text(
                'At SafeRents, our mission is to match house hunters with good houses in a trustable manner. We strive to provide reliable and secure rental solutions, ensuring a seamless experience for both tenants and landlords.',
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/cart2.png',
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
