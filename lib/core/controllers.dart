import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:music_player_app/models/song.dart';

class AudioPLayerController extends GetxController {
  AudioPLayerController({this.song}) {
    _audioPlayer.onPlayerStateChanged.listen((state) {
      isPlaying.value = state == PlayerState.playing;
    });

    duration.value = Duration(milliseconds: song?.value.duration ?? 0);
    _audioPlayer.onDurationChanged.listen((newDuration) {
      duration.value = newDuration;
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      position.value = newPosition;
    });
  }

  Rx<Song>? song;
  final AudioPlayer _audioPlayer = AudioPlayer();
  final RxBool isPlaying = false.obs;
  final Rx<Duration> duration = Duration.zero.obs;
  final Rx<Duration> position = Duration.zero.obs;


  // methods
  Future<void> play() async {
    await _audioPlayer.play(UrlSource(song?.value.songUrl ?? ''),);
  }

  Future<void> pause() async => await _audioPlayer.pause();

  Future<void> stop() async => await _audioPlayer.stop();

  Future<void> resume() async => await _audioPlayer.resume();

  Future<void> seek({required double value}) async {
    final newPosition = Duration(seconds: value.toInt());
    await _audioPlayer.seek(newPosition);
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