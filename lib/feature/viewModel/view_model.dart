import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view/screen/playList_screen.dart';

class ViewModel extends ChangeNotifier {
  bool isAdd = false;
  List<String> songFavorite = [];
  bool? addToFavoriteBool = false;
  final OnAudioQuery audioQuery = OnAudioQuery();
  List<SongModel> songs = [];
  List<FileSystemEntity> arraySongs = [];
  String currentSongTitle = '';
  int currentIndex = 0;

  List<String> fileName = [];
  final audioPlayerStorage = AudioPlayer();
  final audioPlayer = AudioPlayer()..setAsset("assets/music_audio.mp3");
  Duration position = Duration.zero;
  Duration duration = Duration.zero;

  bool? repeat;
  List<String?> allSongsInFavoriteStorage = [];
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

  void setFavoriteInSharedPrefrences(List<SongModel> son) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('addToFavorite', [son[currentIndex].title]);
    addToFavoriteBool = true;
    print(son[currentIndex].title);
    notifyListeners();
  }

  void removeFavoriteFromSharedPrefrences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('addToFavorite');
    addToFavoriteBool = false;

    print("remoove");
    notifyListeners();
  }

  void getSongsFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    allSongsInFavoriteStorage = prefs.getStringList('addToFavorite')!;

    print("${allSongsInFavoriteStorage}sttttttttttttttttttttttttt");
    notifyListeners();
  }

  void addMusicTofavorit(String w) async {
    isAdd = !songFavorite.contains(w);
    if (isAdd) {
      songFavorite.add(w);
      print("add");

      // setFavoriteInSharedPrefrences(son);

      // addToFavorit = true;
    } else {
      songFavorite.remove(w);
      print("remove");

      // addToFavorit = false;
      // removeFavoriteFromSharedPrefrences();
    }
    notifyListeners();
  }

  bool isADD(String a) {
    isAdd = songFavorite.contains(a);
    return isAdd;
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
      audioPlayerStorage.setLoopMode(LoopMode.one);
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
    audioPlayerStorage.durationStream.listen((event) {
      if (event != null) {
        Duration temp = event;
        duration = temp;
        notifyListeners();
      }
    });
    // duration = await audioPlayerStorage.duration!;

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

  void requestStoragePermission(BuildContext context) async {
    //only if the platform is not web, coz web have no permissions
    if (!kIsWeb) {
      bool permissionStatus = await audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await audioQuery.permissionsRequest().then((value) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => PlayList()),
              (route) => false);
        });
      }
    }
    notifyListeners();
  }

  seekToNext() async {
    await audioPlayerStorage.seekToNext();
    notifyListeners();
  }

  seekToPrevious() async {
    await audioPlayerStorage.seekToPrevious();
    notifyListeners();
  }

  ConcatenatingAudioSource createPlaylist(List<SongModel> songs) {
    List<AudioSource> sources = [];
    for (var song in songs) {
      sources.add(AudioSource.uri(Uri.parse(song.uri!)));
    }

    return ConcatenatingAudioSource(children: sources);
  }

  audioSourcePlayList(List<SongModel> songs, int index) {
    audioPlayerStorage.setAudioSource(createPlaylist(songs),
        initialIndex: index);

    notifyListeners();
  }

  void updateCurrentPlayingSongDetails(int index) {
    if (songs.isNotEmpty) {
      currentSongTitle = songs[index].title;
      currentIndex = index;
    }
  }
}
// https://www.youtube.com/watch?v=LZ3baC5esJc
//https://www.youtube.com/@suprimpoudel6070