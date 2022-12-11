import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_screen_project/feature/viewModel/view_model.dart';

import '../widget/container_shadow.dart';

class MusicScreen extends StatelessWidget {
  const MusicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var provider = Provider.of<ViewModel>(context);
    return ChangeNotifierProvider(
      create: (context) => ViewModel(),
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ContainerShadow(
                    hight: 60,
                    width: 60,
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                        )),
                  ),
                  Text(
                    "P L A Y L I S T",
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                  ContainerShadow(
                    hight: 60,
                    width: 60,
                    child: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
                width: double.minPositive,
              ),
              ContainerShadow(
                  child: Column(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset("images/cover_art.png")),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Kota The Friend",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 129, 128, 128)),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Birdie",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ],
              )),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    context
                        .watch<ViewModel>()
                        .timeMusic(context.watch<ViewModel>().position),
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  Icon(
                    Icons.shuffle,
                    color: Colors.black,
                  ),
                  Icon(Icons.repeat, color: Colors.black),
                  Text(
                      context
                          .watch<ViewModel>()
                          .timeMusic(context.watch<ViewModel>().duration),
                      style: TextStyle(color: Colors.grey.shade600)),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              ContainerShadow(
                  child: Slider(
                      min: 0,
                      max: context
                          .read<ViewModel>()
                          .duration
                          .inSeconds
                          .toDouble(),
                      value: context
                          .watch<ViewModel>()
                          .position
                          .inSeconds
                          .toDouble(),
                      onChanged: (value) {
                        context.read<ViewModel>().changeValue(value);
                      })
                  //  LinearPercentIndicator(
                  //   backgroundColor: Colors.transparent,
                  //   barRadius: Radius.circular(8),
                  //   lineHeight: 10,
                  //   percent: 0.2,
                  //   progressColor: Colors.green,
                  // ),
                  ),
              SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Expanded(
                    child: ContainerShadow(
                        hight: 60,
                        child: IconButton(
                            onPressed: (() {}),
                            icon: Icon(
                              Icons.skip_previous,
                              size: 30,
                            ))),
                  ),
                  Expanded(
                      flex: 2,
                      child: ContainerShadow(
                        hight: 60,
                        child: IconButton(
                            onPressed: () {
                              if (context.read<ViewModel>().playing!) {
                                context.read<ViewModel>().playPauseAudio(true);
                              } else {
                                context.read<ViewModel>().playPauseAudio(false);
                                context.read<ViewModel>().sliderMusic();
                              }

                              // provider.playing == true
                              //     ? provider.pauseMsic()
                              //     : provider.playMsic();
                            },
                            icon: context.read<ViewModel>().playing!
                                //  provider.playing!
                                ? Icon(
                                    Icons.pause,
                                    size: 30,
                                  )
                                : Icon(
                                    Icons.play_arrow,
                                    size: 30,
                                  )),
                      )),
                  Expanded(
                    child: ContainerShadow(
                      hight: 60,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.skip_next,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}
