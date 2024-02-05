import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/views/components/search_grid_view.dart';
import 'package:saferent/views/constants/strings.dart';
import 'package:saferent/views/extensions/dismiss_keyboard.dart';

class SearchView extends HookConsumerWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controlller = useTextEditingController();
    final searchTerm = useState('');
    useEffect(() {
      controlller.addListener(() {
        searchTerm.value = controlller.text;
      });
      return () {};
    }, [controlller]);
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controlller,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                prefixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.sort_down,
                      size: 20,
                      color: Colors.green,
                    )),
                labelText: Strings.enterSearch,
                labelStyle: const TextStyle(fontSize: 10),
                focusColor: Colors.black,
                suffixIcon: IconButton(
                  onPressed: () {
                    controlller.clear();
                    dismissKeyboard();
                  },
                  icon: const Icon(
                    CupertinoIcons.clear,
                    color: Colors.red,
                    size: 15,
                  ),
                ),
              ),
            ),
          ),
        ),
        SearchGridView(
          searchTerm: searchTerm.value,
        )
      ],
    );
  }
}
