import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:ui_screen_project/feature/view/screen/page_view.dart';
import 'package:ui_screen_project/feature/view/screen/playList_screen.dart';
import 'package:ui_screen_project/feature/viewModel/view_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  bool textal = false;
  @override
  void initState() {
    _controller = AnimationController(
        // duration: Duration(milliseconds: 10000),
        vsync: this);

    Future.delayed(Duration(milliseconds: 1000), () {
      textal = true;

      setState(() {});
    });

    goToNextPage();

    // _controll Navigator.pushReplacement(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => MusicScreen(),
    //         ));er.addListener(() {
    //   if (_controller.value == 1) {
    //
    //     _controller.stop();
    //   }
    // });
    super.initState();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(
                'images/as.json',
                fit: BoxFit.fill,
                width: 300,
                height: 300,
                controller: _controller,
                onLoaded: (composition) {
                  _controller
                    ..duration = composition.duration
                    // ..isAnimating;
                    // ..dispose();
                    ..forward();
                },
              ),
              // Text("welcam"),
              AnimatedOpacity(
                child: Text(
                  "Music App",
                  style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                duration: Duration(milliseconds: 1500),
                opacity: textal ? 1 : 0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void goToNextPage() {
    Provider.of<ViewModel>(context, listen: false).goToNextPage();
    Future.delayed(Duration(milliseconds: 2200), () {
      Provider.of<ViewModel>(context, listen: false).repeat == true
          ? Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => PlayList()
                  //  MusicScreen(),
                  ))
          : Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => PageViewScreen()));
    });
  }
}
