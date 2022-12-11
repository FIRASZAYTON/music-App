import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewModel extends ChangeNotifier {
  final audioPlayer = AudioPlayer()..setAsset("assets/music_audio.mp3");
  Duration position = Duration.zero;
  Duration duration = Duration.zero;

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

  void playPauseAudio(bool change) async {
    if (change) {
      audioPlayer.pause();
      playing = false;
      print("pause");
    } else {
      audioPlayer.play();
      playing = true;
      print("play");
    }
    notifyListeners();
  }

  void sliderMusic() async {
    duration = await audioPlayer.duration!;
    audioPlayer.positionStream.listen((event) {
      print("time");
      if (event != null) {
        Duration temp = event;
        position = temp;
        notifyListeners();
      }
    });
  }

  String timeMusic(Duration value) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(value.inHours);
    final min = twoDigits(value.inMinutes.remainder(60));
    final sec = twoDigits(value.inSeconds.remainder(60));
    return [if (value.inHours > 0) hours, min, sec].join(":");
  }

  void changeValue(double value) {
    final seekPosition = Duration(seconds: value.toInt());
    audioPlayer.seek(seekPosition);
    notifyListeners();
  } 
}
// https://www.youtube.com/watch?v=LZ3baC5esJc
