import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_screen_project/feature/view/screen/music_screen.dart';
import 'package:ui_screen_project/feature/view/widget/container_shadow.dart';
import 'package:ui_screen_project/feature/viewModel/view_model.dart';

class PlayList extends StatelessWidget {
  const PlayList({super.key});

  @override
  build(BuildContext context) {
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
      body: ListView.separated(
          shrinkWrap: true,
          itemBuilder: ((context1, index) {
            // context.watch<ViewModel>().nameMusic();
            List<String> nameSongs = context.watch<ViewModel>().fileName;

            return InkWell(
              onTap: () async {
                context.read<ViewModel>().playMusicFromStorage(
                    context.read<ViewModel>().arraySongs[index]);
                print(index);

                // context.read<ViewModel>().playPauseAudio(false);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MusicScreen(
                        index: index,
                      ),
                    ));
              },
              child: Card(
                child: ContainerShadow(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    AssetImage("images/playList_music_2.jpg")),
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
                            "${nameSongs[index]}",
                            maxLines: 2,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          separatorBuilder: (context, index) => Divider(),
          itemCount: context.watch<ViewModel>().arraySongs.length),
    );
  }
}
