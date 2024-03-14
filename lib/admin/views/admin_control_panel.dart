import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:saferent/views/tabs/search/search_view.dart';
import 'package:saferent/views/tabs/users_posts/user_posts_view.dart';

class AgentActivityControlPanel extends StatefulHookConsumerWidget {
  const AgentActivityControlPanel({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdminControlPanelState();
}

class _AdminControlPanelState extends ConsumerState<AgentActivityControlPanel> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Admin Control Panel',
            style: TextStyle(fontSize: 12),
          ),
          bottom: const TabBar(tabs: [
            Text(
              'Activity',
              style: TextStyle(fontSize: 12),
            ),
            Text(
              'Search',
              style: TextStyle(fontSize: 12),
            )
          ]),
        ),
        body: const TabBarView(children: [
          UserPostsView(),
          SearchView(),
        ]),
      ),
    );
  }
}
