import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:ui_screen_project/feature/view/screen/music_screen.dart';
import 'package:ui_screen_project/feature/view/widget/container_shadow.dart';
import 'package:ui_screen_project/feature/viewModel/view_model.dart';

import '../widget/toast.dart';

class PlayList extends StatelessWidget {
  PlayList({super.key});

  @override
  build(BuildContext context) {
    var providerRead = context.read<ViewModel>();
    var providerWatch = context.watch<ViewModel>();
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "P L A Y L I S T",
          style: TextStyle(fontWeight: FontWeight.normal),
        ),
      ),
      body: FutureBuilder<List<SongModel>>(
          future: providerRead.audioQuery.querySongs(
            orderType: OrderType.ASC_OR_SMALLER,
            uriType: UriType.EXTERNAL,
            ignoreCase: true,
          ),
          builder: (context, item) {
            if (item.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (item.data!.isEmpty) {
              return const Center(
                child: Text("No Songs Found"),
              );
            }
            // providerWatch.songs.clear();
            providerRead.songs = item.data!;

            return ListView.separated(
                shrinkWrap: true,
                itemBuilder: ((context1, index) {
                  return InkWell(
                    onTap: () async {
                      print(index);
                      // Toast.toast(
                      //     context, "Playing:  " + item.data![index].title);
                      providerRead.audioSourcePlayList(item.data!, index);

                      providerRead.playPauseAudio(false);
                      providerRead.playing! ? providerRead.sliderMusic() : null;

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MusicScreen(
                              songs: providerRead.songs,
                            ),
                          )).then((value) => providerWatch.sliderMusic());
                    },
                    child: Card(
                      child: ContainerShadow(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          "images/playList_music_2.jpg")),
                                  // borderRadius: BorderRadius.circular(20),
                                ),
                                width: 50,
                                height: 120,
                                // child: Image.asset(
                                //   "images/playList_music_2.jpg",
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                            )),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              flex: 2,
                              child: ListTile(
                                title: Text(
                                  "${item.data![index].title}",
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // subtitle: Text(
                                //   "${item.data![index].}",
                                //   style: TextStyle(
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                separatorBuilder: (context, index) => Divider(),
                itemCount: item.data!.length);
          }),
    );
  }
}
