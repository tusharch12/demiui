import 'package:demiui/modals/item.dart';
import 'package:demiui/providers/itemList_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomsheetContainer extends ConsumerStatefulWidget {
  const BottomsheetContainer({super.key});

  @override
  ConsumerState<BottomsheetContainer> createState() => _BottomsheetState();
}

class _BottomsheetState extends ConsumerState<BottomsheetContainer> {
  List<String> imageList = [
    'assets/img1.jpg',
    'assets/img2.jpg',
    'assets/img3.jpg',
    'assets/img1.jpg',
    'assets/img2.jpg',
    'assets/img3.jpg',
  ];
  final controller = DraggableScrollableController();

  @override
  Widget build(BuildContext context) {
    List<Item> items = ref.read(itemListProvider.notifier).state;
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return LayoutBuilder(builder: (context, Constraints) {
      return DraggableScrollableSheet(
          initialChildSize:
              0.5, // The initial height (50% of the screen height)
          minChildSize: 0, // The minimum height (cannot go below 50%)
          maxChildSize: 0.95,
          expand: true,
          controller: controller,
          builder: (context, ScrollController) {
            return DecoratedBox(
              decoration: const BoxDecoration(
                color: Color(0xFF000000),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: CustomScrollView(
                controller: ScrollController,
                slivers: [
                  topButtonIndicator(h, w),
                  container1(h, w),
                  container2(h, w, items)
                ],
              ),
            );
          });
    });
  }

  SliverToBoxAdapter topButtonIndicator(h, w) {
    return SliverToBoxAdapter(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
                child: Center(
                    child: Wrap(children: <Widget>[
              Container(
                  width: w * 0.2,
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  height: 5,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  )),
            ]))),
          ]),
    );
  }

  SliverToBoxAdapter container1(h, w) {
    return SliverToBoxAdapter(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: w * 0.05),
      padding: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: 0.015 * h),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        color: Color(0xFF111111),
      ),
      child: Column(
        children: [
          const Row(
            children: [
              Text(
                "domi in",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: h * 0.08,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: imageList.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        15), // Adjust the radius as needed
                    child: Image.asset(
                      imageList[index],
                      height: h * 0.05,
                      width: w * 0.25,
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ));
  }

  SliverToBoxAdapter container2(h, w, items) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: h * 0.03),
        padding: EdgeInsets.symmetric(horizontal: w * 0.05),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          color: Color(0xFF111111),
        ),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Text(
                  "domi docs",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: h * 0.07,
              width: w * 0.8,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
                color: Color(0xFF1C1C1C),
              ),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Search docs",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    color: Color(0xFF1C1C1C),
                  ),
                  child: ListTile(
                    titleTextStyle:
                        const TextStyle(color: Colors.white70, fontSize: 13),
                    leading: Image.asset(
                      items[index].imageUrl,
                      height: h * 0.05,
                    ),
                    title: Text(items[index].title),
                    subtitle: Text(items[index].subtitle),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
