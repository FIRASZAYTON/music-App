import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:ui_screen_project/feature/view/screen/playList_screen.dart';

import '../../viewModel/view_model.dart';
import '../widget/custom_Painter.dart';
import '../widget/dot_indecator.dart';
import '../widget/onboarding_widget.dart';

class PageViewScreen extends StatefulWidget {
  const PageViewScreen({super.key});

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  String? key;
  int? isCurrentIndex;
  @override
  void initState() {
    isCurrentIndex = 0;

    // print(isCurrentIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PageController _pageController = PageController();
    var tabIndex = InboardingModel.tab;
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: Opacity(
          alwaysIncludeSemantics: true,
          opacity: isCurrentIndex == 2 ? 1 : 0,
          child: Container(
            margin: EdgeInsets.all(8),
            // duration: Duration(seconds: 3),
            decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadiusDirectional.circular(12)),
            child: IconButton(
              onPressed: () async {
                context.read<ViewModel>().setDataInSharedPrefrences();
                context.read<ViewModel>().requestStoragePermission(context);
              },
              icon: Icon(Icons.start_sharp),
              color: Colors.black87,
            ),
          )),
      backgroundColor: Colors.grey.withOpacity(0.2),
      body: Stack(children: [
        CustomPaint(
          painter: ArcPainter(context),
          child: SizedBox(
            height: screenSize.height * 0.2,
            width: screenSize.width,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            height: screenSize.height * 0.85,
            child: Column(
              children: [
                Flexible(
                  child: PageView.builder(
                      controller: _pageController,
                      itemCount: InboardingModel.tab.length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          // mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Lottie.asset(
                              '${tabIndex[index].lottieFile}',
                              fit: BoxFit.fill,
                              width: 350,
                              height: 350,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    "${tabIndex[index].title}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  "${tabIndex[index].subTitle}",
                                  style: TextStyle(
                                      color: Colors.amber,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            Row(mainAxisSize: MainAxisSize.min,
                                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  for (int i = 0; i < tabIndex.length; i++)
                                    Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: DotIndecator(
                                          isSelect: i == isCurrentIndex,
                                        )),
                                ]),
                          ],
                        );
                      },
                      onPageChanged: (value) {
                        isCurrentIndex = value;
                        setState(() {});
                      }),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
