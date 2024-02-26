import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostDateView extends StatelessWidget {
  final DateTime dateTime;
  const PostDateView({Key? key, required this.dateTime});

  @override
  Widget build(BuildContext context) {
    final formattedTimeAgo = timeago.format(
      dateTime,
      locale: 'en',
    ); // Use 'en_short' for English locale

    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: Text(
        formattedTimeAgo,
        style: const TextStyle(
            fontSize: 10, color: Colors.green, fontWeight: FontWeight.bold),
      ),
    );
  }
}
