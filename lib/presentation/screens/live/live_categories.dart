part of '../screens.dart';

class LiveCategoriesScreen extends StatefulWidget {
  const LiveCategoriesScreen({Key? key}) : super(key: key);

  @override
  State<LiveCategoriesScreen> createState() => _LiveCategoriesScreenState();
}

class _LiveCategoriesScreenState extends State<LiveCategoriesScreen> {
  final ScrollController _hideButtonController = ScrollController();
  bool _hideButton = true;
  String keySearch = "";

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    //Wakelock.enable();
    _hideButtonController.addListener(() {
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_hideButton == true) {
          setState(() {
            _hideButton = false;
          });
        }
      } else {
        if (_hideButtonController.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (_hideButton == false) {
            setState(() {
              _hideButton = true;
            });
          }
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: !_hideButton,
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              _hideButtonController.animateTo(0,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.ease);
              _hideButton = true;
            });
          },
          backgroundColor: kColorPrimaryDark,
          child: const Icon(
            FontAwesomeIcons.chevronUp,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HeaderImageAnimated(
              title: "استمتع بالبث المباشر بدون انقطاع",
            ),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Ink(
                  width: 100.w,
                  height: 100.h,
                  decoration: kDecorBackground,
                  // padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10),
                  child: NestedScrollView(
                    controller: _hideButtonController,
                    headerSliverBuilder: (_, ch) {
                      return [
                        SliverAppBar(
                          automaticallyImplyLeading: false,
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          flexibleSpace: FlexibleSpaceBar(
                            background: AppBarLive(
                              onSearch: (String value) {
                                setState(() {
                                  keySearch = value.toLowerCase();
                                });
                                debugPrint("search :$keySearch");
                              },
                            ),
                          ),
                        ),
                      ];
                    },
                    body: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BlocBuilder<LiveCatyBloc, LiveCatyState>(
                        builder: (context, state) {
                          if (state is LiveCatyLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state is LiveCatySuccess) {
                            final categories = state.categories;
                      
                            List<CategoryModel> searchCaty = categories
                                .where((element) => element.categoryName!
                                    .toLowerCase()
                                    .contains(keySearch))
                                .toList();
                      
                            return GridView.builder(
                              padding: const EdgeInsets.all(10),
                              itemCount: keySearch.isNotEmpty
                                  ? searchCaty.length
                                  : categories.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 4.8,
                              ),
                              itemBuilder: (_, i) {
                                final model = keySearch.isNotEmpty
                                    ? searchCaty[i]
                                    : categories[i];
                      
                                return CardLiveItem(
                                  title: model.categoryName ?? "",
                                  onTap: () {
                                    /// OPEN Channels
                                    Get.to(() => LiveChannelsScreen(
                                            catyId: model.categoryId ?? ''))!
                                        .then((value) async {});
                                  },
                                );
                              },
                            );
                          }
                      
                          return const Center(
                            child: Text("Failed to load data..."),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
