import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../viewModel/view_model.dart';
import '../widget/container_shadow.dart';

class FavoriteScreen extends StatelessWidget {
  int index2;
  FavoriteScreen({required this.index2});
  @override
  Widget build(BuildContext context) {
    var providerRead = context.read<ViewModel>();
    var providerWatch = context.watch<ViewModel>();

    print("ss");

    final List<String>? favoriteSongs = providerWatch.songFavorite;
    if (favoriteSongs!.isEmpty) {
      return Scaffold(
          backgroundColor: Colors.grey[300],
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'images/1234.json',
                  fit: BoxFit.cover,
                  width: 200,
                  height: 200,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "No favorites yet ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ],
            ),
          ));
    } else
      return Scaffold(
          backgroundColor: Colors.grey[300],
          body: ListView.separated(
            itemCount: favoriteSongs.length,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              return SafeArea(
                child: Card(
                  child: ContainerShadow(
                    width: 50,
                    hight: 120,
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
                                  image: AssetImage(
                                      "images/playList_music_2.jpg")),
                            ),
                            width: 50,
                            height: 120,
                          ),
                        )),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 2,
                          child: ListTile(
                            title: Text(favoriteSongs[index]),
                            // trailing: IconButton(
                            //     icon: providerRead
                            //             .isADD(providerRead.songs[index2].title)
                            //         ? Icon(
                            //             FontAwesomeIcons.solidHeart,
                            //             color: Colors.red,
                            //             size: 28,
                            //           )
                            //         : Icon(
                            //             FontAwesomeIcons.heart,
                            //             color: Colors.red,
                            //             size: 28,
                            //           ),
                            //     onPressed: () {
                            //       providerRead.addMusicTofavorit(
                            //           providerRead.songs[index2].title);
                            //     }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ));
  }
}
