import 'package:flutter/material.dart';
import 'package:saferent/views/components/constants/app_colors.dart';

class RulesAndEngagement extends StatelessWidget {
  const RulesAndEngagement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.butttonColor,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          "Agent Guidelines for  SafeRents",
          style: TextStyle(
              fontSize: 10, color: Colors.red, fontWeight: FontWeight.bold),
        ),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Agent Guidelines for  SafeRents",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              SizedBox(height: 10),
              Text(
                "Introduction",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              Text(
                "In the endeavor to maintain the highest standards of trust, professionalism, and service excellence,  SafeRents has established a comprehensive set of rigorous rules and guidelines for all real estate agents associated with our platform. These rules have been meticulously crafted to ensure a secure, reliable, and credible environment for both agents and clients. It is imperative that all agents thoroughly understand and meticulously adhere to these guidelines, as outlined below.",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "1. Registration Process:",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              Text(
                "All prospective agents must complete the registration process, which involves the completion of a dedicated form within  SafeRents application. This form necessitates the provision of essential personal information, education background details, and accurate contact information. We earnestly request that all agents provide precise and up-to-date information during the registration procedure.",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
              Text(
                "2. Verification Process:",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              Text(
                "It is of paramount importance to recognize that completion of the registration form does not, in and of itself, qualify an individual as an agent on our platform. Verification is an obligatory step, and it is conducted exclusively at our corporate offices. This meticulous verification process is meticulously designed to ensure that all agents meet the requisite standards, possess the necessary qualifications, and maintain an unblemished professional track record. Agents must emphatically refrain from sharing their verification number with any third parties. Any agent found to be in breach of this rule will be subject to severe penalties, including the potential for permanent revocation of agent status. This stringent measure has been enacted to uphold the highest levels of trust and security on our platform.",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
              Text(
                "3. Suspension and Revocation:",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              Text(
                " SafeRents retains the prerogative to revoke or suspend an agent's membership at any given time, and for any reason, without prior notification. This course of action may be pursued in response to an agent's contravention of any of our stipulations, engagement in unethical or illegal activities, or failure to adhere to the anticipated standards of professionalism and customer service. The welfare and trust of our clients constitute our foremost priority, and these measures are indispensable to safeguard and uphold such standards.",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
              Text(
                "4. Handling Client Matches:",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              Text(
                "When an agent is matched with a client, it is imperatively vital that the agent treats the client with the utmost respect, professionalism, and transparency. Agents bear the responsibility of providing accurate and reliable information, responding to inquiries in a timely manner, and guiding clients with unwavering honesty and integrity throughout their property search endeavors. Agents are categorically prohibited from partaking in any form of misleading or fraudulent activity that could compromise the trust of clients or the standing of SafeRents . Dissemination of false information, concealment of property flaws, or any other unethical practices are expressly forbidden.If any form of inconvinience arises from the Agent to the Client in accordance with this guideline say like thefty or any other form of malpractice client will be handled accordingly. ",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
              Text(
                "5. Client Privacy and Confidentiality:",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              Text(
                "Agents are under a solemn obligation to respect the privacy and confidentiality of the clients they serve. Any client information acquired during the course of business must be maintained in strict confidence and used exclusively for legitimate business purposes. The sharing or exploitation of client data for personal gain is intolerable and can result in immediate termination of agent status.",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
              Text(
                "6. Compliance with Laws and Regulations:",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              Text(
                "It is expected that both clients and agents conduct themselves in strict compliance with all pertinent local, regional, and national laws and regulations. Engagement in illegal or unethical activities, more so racial profiling or discrimination, shall not be tolerated.Please act your ages",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
              Text(
                "7. Professionalism and Code of Conduct:",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              Text(
                "All agents are required to comport themselves with the utmost professionalism and adherence to ethical principles at all times. This entails demonstrating courtesy, respect, and promptness in interactions with clients, colleagues, and SafeRents staff. Instances of discriminatory or offensive conduct, harassment, or unprofessionalism shall be met with zero tolerance.At SafeRents we're FAMILY",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
              Text(
                '8. Agent Payments',
                style: TextStyle(
                    fontSize: 10,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'All Agent Payments Shall be discussed at  SafeRents office premises once Attestation is done. REGARDS 🤟',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
