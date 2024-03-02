import 'package:badges/badges.dart' as badges;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:saferent/payments/view/reciept_view.dart';

import 'package:saferent/security/pinsentry/views/agent_enter_pin_view.dart';
import 'package:saferent/shoppingCart/providers/cart_management_provider.dart';
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

class _PortalsMainState extends ConsumerState<PortalsMain>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Adjust duration as needed
    )..repeat(); // Repeats the animation indefinitely
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          centerTitle: false,
          title: Row(
            children: [
              const Text(
                'Safe',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
              ScaleTransition(
                scale: _controller,
                child: const Text(
                  'R',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Text(
                'ents',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              const Icon(
                CupertinoIcons.map_pin_ellipse,
                color: Colors.red,
              )
            ],
          ),
          actions: [
            badges.Badge(
              badgeContent: Consumer(
                builder: (context, ref, child) {
                  final cartProvder = ref.watch(cartProvider.notifier);
                  return Text(
                    cartProvder.badgeCount.toString(),
                    style: const TextStyle(color: Colors.black, fontSize: 12),
                  );
                },
              ),
              position: badges.BadgePosition.topStart(top: 0, start: 30),
              badgeStyle: const badges.BadgeStyle(
                badgeColor: Colors.transparent,
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CartViewPage()));
                },
                icon: const Icon(
                  CupertinoIcons.cart,
                  size: 18,
                  color: Colors.blue,
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
                )),
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
                CupertinoIcons.share,
                color: Colors.red,
                size: 18,
              ),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  CupertinoIcons.house,
                  color: Colors.black,
                  size: 18,
                ),
              ),
              Tab(
                icon: Icon(
                  CupertinoIcons.search,
                  color: Colors.black,
                  size: 18,
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
