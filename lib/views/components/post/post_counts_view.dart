import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saferent/views/components/post/post_view_count.dart';

class ViewCounterIcon extends StatelessWidget {
  final String postId;

  ViewCounterIcon({Key? key, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const Icon(Icons.remove_red_eye),
        Positioned(
          right: 0,
          child: Consumer<UserViewsModel>(
            builder: (context, userViews, child) {
              return Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(6),
                ),
                constraints: const BoxConstraints(
                  minWidth: 12,
                  minHeight: 12,
                ),
                child: Text(
                  '${userViews.getViewCount(postId)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
