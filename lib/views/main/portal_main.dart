import 'package:badges/badges.dart' as badges;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/moreServices/houseMaids/providers/extras_view.dart';
import 'package:saferent/payments/view/reciept_view.dart';
import 'package:saferent/security/pinsentry/views/agent_enter_pin_view.dart';
import 'package:saferent/shoppingCart/providers/cart_management_provider.dart';
import 'package:saferent/shoppingCart/views/shopping_cart_view.dart';
import 'package:saferent/state/auth/providers/auth_state_providers.dart';
import 'package:saferent/views/components/dialogs/alert_dialog_model.dart';
import 'package:saferent/views/components/dialogs/log_out_dialog.dart';
import 'package:saferent/views/tabs/home_view.dart';
import 'package:saferent/views/tabs/search/search_view.dart';
import 'package:saferent/views/tabs/users_posts/user_posts_view.dart';


class PortalsMain extends ConsumerStatefulWidget {
  const PortalsMain({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PortalsMainState();
}

class _PortalsMainState extends ConsumerState<PortalsMain> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Row(
            children: [
              Text(
                'Safe',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
              Text(
                'R',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.green,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'ents',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
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
                    style: const TextStyle(color: Colors.red, fontSize: 12),
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
              Tab(
                icon: Icon(
                  CupertinoIcons.person_2,
                  color: Colors.black,
                  size: 18,
                ),
              ),
              Tab(
                icon: Icon(
                  CupertinoIcons.slider_horizontal_3,
                  color: Colors.red,
                  size: 18,
                ),
              )
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            HomeView(),
            SearchView(),
            UserPostsView(),
            ExtrasViewTab(),
          ],
        ),
      ),
    );
  }
}
