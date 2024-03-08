import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:saferent/payments/view/reciept_view.dart';
import 'package:saferent/security/pinsentry/views/agent_enter_pin_view.dart';
import 'package:saferent/shoppingCart/views/shopping_cart_view.dart';
import 'package:saferent/state/auth/providers/auth_state_providers.dart';

import 'package:saferent/views/components/dialogs/alert_dialog_model.dart';
import 'package:saferent/views/components/dialogs/log_out_dialog.dart';
import 'package:saferent/views/tabs/home_view.dart';
import 'package:saferent/views/tabs/search/search_view.dart';

class PortalsMain extends ConsumerStatefulWidget {
  const PortalsMain({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PortalsMainState();
}

class _PortalsMainState extends ConsumerState<PortalsMain> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Row(
            children: [
              Text(
                'Safe',
              ),
              Text(
                "Rents",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartViewPage(),
                  ),
                );
              },
              child: const Text(
                'Bookings',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RecieptsView(),
                  ),
                );
              },
              icon: const Icon(
                Icons.receipt_long,
                color: Colors.green,
                size: 18,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AgentEnterPinView(),
                  ),
                );
              },
              icon: const Icon(
                CupertinoIcons.cloud_upload_fill,
                color: Colors.purple,
                size: 18,
              ),
            ),
            IconButton(
              onPressed: () async {
                final shouldLogOut = await const LogoutDialog()
                    .present(context)
                    .then((value) => value ?? false);
                if (shouldLogOut) {
                  await ref.read(authStateProvider.notifier).logOut();
                }
              },
              icon: const Icon(
                Icons.logout_outlined,
                color: Colors.red,
                size: 18,
              ),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text(
                  'Explore',
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Tab(
                child: Text(
                  'Search ',
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            HomeView(),
            SearchView(),
          ],
        ),
      ),
    );
  }
}
