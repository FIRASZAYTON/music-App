import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:ui_screen_project/feature/viewModel/view_model.dart';

import '../widget/container_shadow.dart';

class MusicScreen extends StatefulWidget {
  List<SongModel> songs;
  MusicScreen({required this.songs});

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  @override
  void initState() {
    context
        .read<ViewModel>()
        .audioPlayerStorage
        .currentIndexStream
        .listen((index) {
      if (index != null) {
        context.read<ViewModel>().updateCurrentPlayingSongDetails(index);
      }
    });
    _controller = AnimationController(
        animationBehavior: AnimationBehavior.preserve, vsync: this);

    super.initState();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widthMedia = MediaQuery.of(context).size.width;
    double hightMedia = MediaQuery.of(context).size.height;

    var providerRead = context.read<ViewModel>();
    var providerWatch = context.watch<ViewModel>();
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 8,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: hightMedia * 0.10,
                width: widthMedia,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ContainerShadow(
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(FontAwesomeIcons.chevronLeft)),
                    ),
                    SizedBox(
                      // width: widthMedia * 0.30,
                      child: Text(
                        "M U S I C A N O",
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ),
                    ContainerShadow(
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(FontAwesomeIcons.bars),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: hightMedia * 0.02,
              ),
              ContainerShadow(
                  hight: hightMedia * 0.40,
                  width: widthMedia,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          decoration: BoxDecoration(

                              // image: DecorationImage(
                              //     fit: BoxFit.cover,
                              //     image:
                              //         AssetImage("images/playList_music_2.jpg")),
                              // borderRadius: BorderRadius.circular(20),
                              ),
                          width: widthMedia,
                          height: hightMedia * 0.3,
                          child: Lottie.asset('images/image7.json',
                              reverse: true,
                              repeat: true,
                              fit: BoxFit.contain,
                              width: widthMedia * 0.2,
                              height: hightMedia * 0.2,
                              controller:
                                  providerRead.playing! ? null : _controller),
                        ),
                      ),
                      SizedBox(
                        height: hightMedia * 0.02,
                      ),
                      SizedBox(
                        height: widthMedia * 0.08,
                        width: widthMedia,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 5,
                              child: Text(
                                widget.songs[providerRead.currentIndex].title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 129, 128, 128)),
                              ),
                            ),
                            Expanded(
                              child: IconButton(
                                icon: providerRead.addToFavorit!
                                    ? Icon(
                                        FontAwesomeIcons.solidHeart,
                                        color: Colors.red,
                                        size: 28,
                                      )
                                    : Icon(
                                        FontAwesomeIcons.heart,
                                        color: Colors.red,
                                        size: 28,
                                      ),
                                onPressed: () {
                                  providerRead.addToFavorit!
                                      ? providerRead.addMusicTofavorit(false)
                                      : providerRead.addMusicTofavorit(true);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              /////////////////////////////////////////////
              SizedBox(
                height: hightMedia * 0.02,
              ),
              /////////////////////////////////////////////////
              SizedBox(
                height: hightMedia * 0.1,
                width: widthMedia,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      providerWatch.timeMusic(providerWatch.position),
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    IconButton(
                        onPressed: () {
                          providerRead.shuffle!
                              ? providerRead.shuffleMode(false)
                              : providerRead.shuffleMode(true);
                        },
                        icon: providerWatch.shuffle!
                            ? Icon(FontAwesomeIcons.shuffle)
                            : Icon(
                                FontAwesomeIcons.shuffle,
                                color: Colors.grey,
                              )),
                    IconButton(
                        onPressed: () {
                          providerRead.loop!
                              ? providerRead.loopMode(false)
                              : providerRead.loopMode(true);
                        },
                        icon: providerWatch.loop!
                            ? Icon(FontAwesomeIcons.repeat)
                            : Icon(
                                FontAwesomeIcons.repeat,
                                color: Colors.grey,
                              )),
                    Text(providerWatch.timeMusic(providerWatch.duration),
                        style: TextStyle(color: Colors.grey.shade600)),
                  ],
                ),
              ),
              //////////////////////////////////////////////////
              SizedBox(
                height: hightMedia * 0.02,
              ),
              ///////////////////////////////////////////////////
              ContainerShadow(
                  hight: hightMedia * 0.1,
                  width: widthMedia,
                  child: Slider(
                      activeColor: Colors.green,
                      inactiveColor: Colors.green[200],
                      min: 0,
                      max: providerRead.duration.inSeconds.toDouble(),
                      value: providerWatch.position.inSeconds.toDouble(),
                      onChanged: (value) {
                        providerRead.changeValue(value);
                      })),
              //////////////////////////////////////////////////

              SizedBox(
                height: hightMedia * 0.03,
              ),
              //////////////////////////////////////////////////////
              SizedBox(
                height: hightMedia * 0.1,
                width: widthMedia,
                child: Row(
                  children: [
                    Expanded(
                      child: ContainerShadow(
                          // hight: hightMedia * 0.10,
                          child: IconButton(
                              onPressed: (() {
                                // widget.index = widget.index! - 1;
                                providerRead.seekToPrevious();
                              }),
                              icon: Icon(FontAwesomeIcons.backward))),
                    ),
                    SizedBox(
                      width: widthMedia * 0.05,
                    ),
                    Expanded(
                        flex: 2,
                        child: ContainerShadow(
                          // hight: hightMedia * 0.10,
                          child: IconButton(
                              onPressed: () {
                                if (providerRead.playing!) {
                                  providerRead.playPauseAudio(true);
                                } else {
                                  providerRead.playPauseAudio(false);
                                  // providerRead.sliderMusic();
                                }

                                // provider.playing == true
                                //     ? provider.pauseMsic()
                                //     : provider.playMsic();
                              },
                              icon: providerRead.playing!
                                  //  provider.playing!
                                  ? Icon(FontAwesomeIcons.pause)
                                  : Icon(FontAwesomeIcons.play)),
                        )),
                    SizedBox(
                      width: widthMedia * 0.05,
                    ),
                    Expanded(
                      child: ContainerShadow(
                        // hight: hightMedia * 0.10,
                        child: IconButton(
                          onPressed: () async {
                            // widget.index = widget.index! + 1;
                            providerRead.seekToNext();
                          },
                          icon: Icon(FontAwesomeIcons.forward),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
