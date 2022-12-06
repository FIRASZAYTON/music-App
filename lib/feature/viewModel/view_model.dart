import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewModel extends ChangeNotifier {
  final audioPlayer = AudioPlayer()..setAsset("assets/music_audio.mp3");

  bool? repeat;
  bool? playing = false;

  void setDataInSharedPrefrences() async {
    print("repeat");
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('pageView', true);
    notifyListeners();
  }

  void goToNextPage() async {
    final prefs = await SharedPreferences.getInstance();
    repeat = prefs.getBool('pageView');
    print(repeat);
    notifyListeners();
  }

  void playMsic() async {
    // await player.play();

    print("play");
    playing = true;
    notifyListeners();
  }

  void pauseMsic() async {
    print("pause");
    playing = false;
    notifyListeners();
  }
}
// https://www.youtube.com/watch?v=LZ3baC5esJc
