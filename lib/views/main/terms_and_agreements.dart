import 'package:flutter/material.dart';
import 'package:saferent/views/components/constants/app_colors.dart';

class TermsAndAgreements extends StatelessWidget {
  const TermsAndAgreements({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.butttonColor,
      appBar: AppBar(
        title: const Text(
          "Terms and Agreements",
          style: TextStyle(
            fontSize: 10,
            color: Colors.red,
            fontWeight: FontWeight.bold,
            height: 1.5,
          ),
        ),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Terms and Agreements",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "In the bustling real estate and rental bussiness in Uganda, \" SafeRents\" stands as a beacon of trust and innovation, redefining the way users engage with property listings and ensuring a secure, authenticated, and exclusive experience.More so in the property hunting which is at loggerheads with everyone.",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                    wordSpacing: 0.1),
              ),
              SizedBox(height: 10),
              Text(
                "In an era where digital platforms often grapple with issues of trust and transparency, \"SafeRents\" takes a giant leap forward by enforcing stringent user authentication mechanisms. In a bid to provide an uncompromising level of safety and privacy, we employ authentication through the giants of the tech world - Google, Apple, and Twitter. By allowing users and agents to authenticate using their existing accounts on these platforms, we ensure that each user's and agent's identity is verified, offering a level of trust that's essential in the realm of property listings.",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                    wordSpacing: 0.1),
              ),
              SizedBox(height: 10),
              Text(
                "This authentication process is not just about convenience; it's about providing a seal of authenticity to every user, assuring them that the information they access is credible and reliable. It also safeguards our community by deterring any unauthorized access, ultimately creating a secure and exclusive space for property seekers and agents alike.",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                    wordSpacing: 0.1),
              ),
              SizedBox(height: 10),
              Text(
                "However, our commitment to authenticity doesn't end with user authentication. We've taken a step further to ensure that the information our users access is not only trustworthy but also respects the value of the services we provide. To access detailed information about any listing on our platform, a modest fee of 8500ugx UGX is required for touring each and every property added to the cart .",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                    wordSpacing: 0.1),
              ),
              SizedBox(height: 10),
              Text(
                "This fee, though nominal, represents a commitment to maintaining the quality of our services and the accuracy of our listings. It acts as a barrier, ensuring that only serious and genuinely interested users can access in-depth information about properties. This fee is not only a testament to the value we place on the listings but also a measure to prevent spam and inauthentic inquiries.",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                    wordSpacing: 0.1),
              ),
              SizedBox(height: 10),
              Text(
                "Once the payment is verified, we issue a receipt directly to the user's email, containing essential details about the agent details who the user then contacts for field tour and it also acts as the field  fee or search fee. This receipt serves as a record of the transaction, offering users peace of mind and proof of payment. Additionally, it acts as a channel for users to connect directly with agents, creating a bridge of communication that enhances the property search experience . NB No Extra fee is required in the field only the paid fee on our platform covers the field services for that paid pOrtaL any Inconviniences in the field reach out to us on alsekx@gmail.com or call us on 0761439068 or 0704859712",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                    wordSpacing: 0.1),
              ),
              SizedBox(height: 10),
              Text(
                "It's important to note that the 8500 UGX fee applies to one portal use, signifying that each access is a unique opportunity to explore a property listing in depth. This ensures that our users remain invested in their property search, focusing on listings that genuinely pique their interest.",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                    wordSpacing: 0.1),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Its also mindful to note that any payment done outside SafeRents system is not in any way recognized by the administration and note that will be an understanding betwwen you (client )and the agent the portal wont be held liable or responsible between this understanding  please take caution ',
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                    wordSpacing: 0.1),
              ),
              SizedBox(height: 10),
              Text(
                "In the dynamic world of real estate, where time is often of the essence, this strategy serves to streamline the property search process. Users can explore their chosen listings with confidence, knowing that they've invested in access to high-quality, detailed information.",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                    wordSpacing: 0.1),
              ),
              SizedBox(height: 10),
              Text(
                "In conclusion, \"SafeRents\" in Uganda isn't just an estate listing app; it's a gateway to trust, authenticity, and an enhanced property search experience. We've harnessed the power of authentication through Google, Apple, and Twitter to fortify the trust between us and our users. We've introduced a nominal fee, accompanied by a receipt, to ensure the exclusivity and integrity of the information available on our platform. This fee is a symbolic investment in quality and authenticity. And remember, the 8500 UGX you pay unlocks a world of possibilities, granting you exclusive access to the details of a single listing. \"SafeRents\" isn't just about listings; it's about empowering users to find their dream properties securely, conveniently, and with absolute confidence. Join us in this exciting journey as we redefine the way you explore real estate in Uganda.",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                    wordSpacing: 0.1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
