import 'package:flutter/material.dart';

class LandlordRegistrationPage extends StatefulWidget {
  LandlordRegistrationPage({Key? key}) : super(key: key);

  @override
  _LandlordRegistrationPageState createState() =>
      _LandlordRegistrationPageState();
}

class _LandlordRegistrationPageState extends State<LandlordRegistrationPage> {
  // Add TextEditingController for each TextField
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final bankAccountController = TextEditingController();
  final locationController = TextEditingController();

  // Keep track of selected units
  final selectedUnits = <String>{};

  // Keep track of expanded groups
  final expandedGroups = <String>{};

  // Helper function to generate ExpansionPanelList for each letter
  Widget _buildExpansionPanelList(String letter) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          if (isExpanded) {
            expandedGroups.remove(letter);
          } else {
            expandedGroups.add(letter);
          }
        });
      },
      children: [
        ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(letter),
            );
          },
          body: Wrap(
            spacing: 8.0, // gap between adjacent chips
            runSpacing: 4.0, // gap between lines
            children: <Widget>[
              for (var i = 1; i <= 30; i++)
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedUnits.add('$letter$i');
                    });
                  },
                  child: Text(
                      '$letter$i${selectedUnits.contains('$letter$i') ? ' ✔️' : ''}'),
                ),
            ],
          ),
          isExpanded: expandedGroups.contains(letter),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Landlord Registration',
          style: TextStyle(fontSize: 14),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: fullNameController,
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        labelStyle: TextStyle(fontSize: 12),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(fontSize: 12),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: phoneNumberController,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(fontSize: 12),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: bankAccountController,
                      decoration: const InputDecoration(
                        labelText: 'Bank Account',
                        labelStyle: TextStyle(fontSize: 12),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: locationController,
                      decoration: const InputDecoration(
                        labelText: 'Location',
                        labelStyle: TextStyle(fontSize: 12),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    for (var letter in 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split(''))
                      _buildExpansionPanelList(letter),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement registration logic
                  // Use fullNameController.text, emailController.text, etc. to get the text of each TextField
                  // Use selectedUnits for the selected units
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
