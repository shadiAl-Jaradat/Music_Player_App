import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:music_player_app/models/song.dart';
import 'package:flutter/material.dart';


class AudioPlayerController extends GetxController {
  AudioPlayerController({required this.song, required this.currentIndex}) {
    _audioPlayer.onPlayerStateChanged.listen((state) {
      isPlaying.value = state == PlayerState.playing;
    });

    duration.value = Duration(milliseconds: song.value?.duration ?? 0);
    _audioPlayer.onDurationChanged.listen((newDuration) {
      duration.value = newDuration;
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      position.value = newPosition;
    });
  }

  Rx<Song?> song = Rx<Song?>(null);
  final AudioPlayer _audioPlayer = AudioPlayer();
  final RxBool isPlaying = false.obs;
  final Rx<Duration> duration = Duration.zero.obs;
  final Rx<Duration> position = Duration.zero.obs;
  RxList<Song> listOfSongs = <Song>[].obs;
  RxList<Song> searchedSongs = <Song>[].obs;
  RxBool inSearchMode = false.obs;

  Rx<Color> cardBgColor (Song ss) => song.value == ss ? Colors.white.withOpacity(0.1).obs : Colors.white.withOpacity(0).obs;
  Rx<Color> notSelectCardBgColor = Colors.white.withOpacity(0).obs;

  RxInt currentIndex;

  void setCurrentIndex(int index) {
    currentIndex.value = index;
  }

  void setListOfSongs(List<Song> songs) {
    listOfSongs = songs.obs;
  }

  void setSearchedSongs(List<Song> songs) {
    searchedSongs.value = songs;
  }

  void setSong(Song? newSong) {
    song.value = newSong;
  }


  void setInSearchMode(bool value) {
    inSearchMode.value = value;
  }

  // methods
  Future<void> play() async {
    await _audioPlayer.play(UrlSource(song.value?.songUrl ?? ''),);
  }

  Future<void> pause() async => await _audioPlayer.pause();

  Future<void> stop() async => await _audioPlayer.stop();

  Future<void> resume() async => await _audioPlayer.resume();

  Future<void> seek({required double value}) async {
    final newPosition = Duration(seconds: value.toInt());
    await _audioPlayer.seek(newPosition);
  }

  Color? getCardBgColor(Song value){
    return song.value == value ? Colors.white.withOpacity(0.1) : null;
  }


  @override
  void dispose(){
    super.dispose();
    _audioPlayer.dispose();
  }

}

// class SongController {
//   final AudioPlayer _audioPlayer = AudioPlayer();
//     Rx<Song>? currentSong;
//   final RxBool isPlaying = false.obs;
//   // final Rx<Duration> currentSongPosition = Duration.zero.obs;
//
//   Future<void> play(Song song) async {
//     if(_audioPlayer.state == PlayerState.playing) {
//       await _audioPlayer.stop();
//     }
//     currentSong = song.obs;
//     await _audioPlayer.play(UrlSource(currentSong!.value.songUrl));
//     isPlaying.value = true;
//   }
//
//   Future<void> stop() async => await _audioPlayer.stop();
// }