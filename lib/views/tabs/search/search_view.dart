import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/views/components/search_grid_view.dart';
import 'package:saferent/views/constants/strings.dart';
import 'package:saferent/views/extensions/dismiss_keyboard.dart';

class SearchView extends HookConsumerWidget {
  const SearchView({Key? k}) : super(key: k);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _c = useTextEditingController();
    final searchTerm = useState('');
    useEffect(() {
      _c.addListener(() {
        searchTerm.value = _c.text;
      });
      return () {};
    }, [_c]);
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _c,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                labelText: Strings.enterSearch,
                labelStyle: const TextStyle(fontSize: 10),
                focusColor: Colors.black,
                prefixIcon: const Icon(
                  CupertinoIcons.search,
                  size: 15,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    _c.clear();
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
