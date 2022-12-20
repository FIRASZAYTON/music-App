import 'dart:io';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewModel extends ChangeNotifier {
  List<FileSystemEntity> arraySongs = [];

  List<String> fileName = [];
  final audioPlayerStorage = AudioPlayer();
  final audioPlayer = AudioPlayer()..setAsset("assets/music_audio.mp3");
  Duration position = Duration.zero;
  Duration duration = Duration.zero;

  bool? repeat;
  bool? playing = false;
  bool? loop = false;
  bool? shuffle = false;
  bool? addToFavorit = false;

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
      audioPlayerStorage.pause();
      playing = false;
      print("pause");
    } else {
      audioPlayerStorage.play();

      playing = true;
      print("play");
    }
    notifyListeners();
  }

  void loopMode(bool change) async {
    if (change) {
      audioPlayerStorage.setLoopMode(LoopMode.off);
      loop = true;
    } else {
      audioPlayerStorage.setLoopMode(LoopMode.all);
      loop = false;
    }
    notifyListeners();
  }

  void shuffleMode(bool change) async {
    if (change) {
      audioPlayerStorage.setShuffleModeEnabled(false);
      shuffle = true;
    } else {
      audioPlayerStorage.setShuffleModeEnabled(true);
      shuffle = false;
    }
    notifyListeners();
  }

  void sliderMusic() async {
    duration = audioPlayerStorage.duration!;
    audioPlayerStorage.positionStream.listen((event) {
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
    audioPlayerStorage.seek(seekPosition);
    notifyListeners();
  }

  void getSongList() async {
    await Permission.manageExternalStorage.request();
    await Permission.storage.request();
    // Directory? directory = await getLibraryDirectory();

    Directory directory = Directory('/storage/emulated/0/Download');
    // String mp3Path = directory.toString();
    List<FileSystemEntity> _file;
    _file = directory.listSync(recursive: true, followLinks: false);
    for (FileSystemEntity entity in _file) {
      String path = entity.path;
      print("{$path}ddddddddddddddddddddddddddddddd");
      if (path.endsWith('.mp3')) {
        arraySongs.add(entity);
        print("${arraySongs.length}................");
      }
    }
    for (var i = 0; i < arraySongs.length; i++) {
      fileName.add(File(arraySongs[i].path).uri.pathSegments.last);
    }
    notifyListeners();
  }

  void playMusicFromStorage(FileSystemEntity fileSystemEntity) {
    audioPlayerStorage.setUrl(fileSystemEntity.path);

    // audioPlayerStorage.setAudioSource(source);
  }

  void addMusicTofavorit(bool add) {
    if (add) {
      addToFavorit = true;
    } else {
      addToFavorit = false;
    }
    notifyListeners();
  }

  seek() async {
    // audioPlayerStorage.stop();

    await audioPlayerStorage.seekToNext();
    // await audioPlayerStorage.play();
    notifyListeners();
  }
}
// https://www.youtube.com/watch?v=LZ3baC5esJc
//https://www.youtube.com/@suprimpoudel6070