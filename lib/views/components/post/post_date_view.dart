import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostDateView extends StatelessWidget {
  final DateTime dateTime;
  const PostDateView({Key? key, required this.dateTime});

  @override
  Widget build(BuildContext context) {
    final formattedTimeAgo = timeago.format(
      dateTime,
      locale: 'en_long',
    ); // Use 'en_short' for English locale

    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        formattedTimeAgo,
      ),
    );
  }
}
