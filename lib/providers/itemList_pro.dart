import 'package:demiui/modals/item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final itemListProvider = StateProvider<List<Item>>((ref) {
  return [
    Item(
      title: '100 Martinique Ave Title',
      subtitle: 'Opened Dec 4, 2023 ',
      imageUrl: 'assets/file.png',
    ),
    Item(
      title: 'Chase Bank Statement - November 2023',
      subtitle: 'Opened Dec 3, 2023',
      imageUrl: 'assets/file.png',
    ),
    Item(
      title: 'Backyard Remodel Renderings',
      subtitle: 'Opened Nov 11, 2023',
      imageUrl: 'assets/sheets.png',
    ),
    Item(
      title: '100 Martinique Ave Title',
      subtitle: 'Opened Dec 4, 2023 ',
      imageUrl: 'assets/file.png',
    ),
    Item(
      title: 'Chase Bank Statement - November 2023',
      subtitle: 'Opened Dec 3, 2023',
      imageUrl: 'assets/file.png',
    ),
    Item(
      title: 'Backyard Remodel Renderings',
      subtitle: 'Opened Nov 11, 2023',
      imageUrl: 'assets/sheets.png',
    ),
    Item(
      title: '100 Martinique Ave Title',
      subtitle: 'Opened Dec 4, 2023 ',
      imageUrl: 'assets/file.png',
    ),
    Item(
      title: 'Chase Bank Statement - November 2023',
      subtitle: 'Opened Dec 3, 2023',
      imageUrl: 'assets/file.png',
    ),
    Item(
      title: 'Backyard Remodel Renderings',
      subtitle: 'Opened Nov 11, 2023',
      imageUrl: 'assets/sheets.png',
    ),
  ];
});
