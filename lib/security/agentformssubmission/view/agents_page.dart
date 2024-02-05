import 'package:flutter/material.dart';
import 'package:saferent/state/posts/typedefs/user_id.dart';

class AgentsPage extends StatelessWidget {
  const AgentsPage(
      {super.key,
      required UserId fromUserId,
      required DateTime createdAt,
      required String email,
      required String nin,
      required String phonenumber,
      required String refPhoneNumber,
      required String education,
      required String names});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
