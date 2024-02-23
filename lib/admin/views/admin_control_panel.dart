import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/admin/views/admin_screen.dart';
import 'package:saferent/views/tabs/search/search_view.dart';
import 'package:saferent/views/tabs/users_posts/user_posts_view.dart';

class AdminControlPanel extends StatefulHookConsumerWidget {
  const AdminControlPanel({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdminControlPanelState();
}

class _AdminControlPanelState extends ConsumerState<AdminControlPanel> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: const Text(
            'Admin Control Panel',
            style: TextStyle(fontSize: 12),
          ),
          bottom: const TabBar(tabs: [
            Text(
              'Admin',
              style: TextStyle(fontSize: 12),
            ),
            Text(
              'Search',
              style: TextStyle(fontSize: 12),
            ),
            Text(
              'Activity',
              style: TextStyle(fontSize: 12),
            )
          ]),
        ),
        body: TabBarView(children: [
          AdminScreen(),
          const SearchView(),
          const UserPostsView(),
        ]),
      ),
    );
  }
}
