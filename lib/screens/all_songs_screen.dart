import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player_app/core/controllers.dart';
import 'package:music_player_app/core/spotify_service.dart';
import 'package:music_player_app/models/song.dart';
import 'package:music_player_app/shared_widgets/song_item_card.dart';

class AllSongsScreen extends StatefulWidget {
  const AllSongsScreen({super.key});

  @override
  State<AllSongsScreen> createState() => _AllSongsScreenState();
}

class _AllSongsScreenState extends State<AllSongsScreen> {
  final SpotifyService spotifyService = SpotifyService(Dio());
  bool loading = true;
  int currentIndex = 0;
  AudioPLayerController audioPLayerController = Get.put(AudioPLayerController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loading ? spotifyService.getRecommendations() : null,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: const TextStyle(color: Colors.white),
              ),
            );
          }
          if (snapshot.hasData) {
            List<Song> songs = snapshot.data as List<Song>;
            loading = false;
            return Stack(
              children: [
                ListView.builder(
                  itemCount: songs.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'All Songs',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            const Icon(
                              Icons.search,
                              color: Colors.white,
                            )
                          ],
                        ),
                      );
                    }
                    return SongItemCard(
                        song: songs[index - 1],
                        onTap: () {
                          setState(() {
                            if (audioPLayerController.song != null) {
                              if (audioPLayerController.song?.value == songs[index - 1]) {
                                audioPLayerController.resume();
                              }
                            }
                            currentIndex = index-1;
                            audioPLayerController.song = songs[index - 1].obs;
                            audioPLayerController.play();
                          });
                        });
                  },
                ),
                if (audioPLayerController.song != null)
                  Positioned(
                    bottom: 4,
                    right: 5,
                    left: 5,
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed('/now_playing');
                      },
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.12),
                            ),
                            child: ListTile(
                              leading: Transform.translate(
                                offset: const Offset(-4.0, 3.0),
                                child: Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                      image: NetworkImage(audioPLayerController.song?.value.imageUrl ?? ''),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              trailing: Transform.translate(
                                offset: const Offset(18.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        if (audioPLayerController.isPlaying.value) {
                                          await audioPLayerController.pause();
                                        } else {
                                          await audioPLayerController.play();
                                        }
                                        setState(() {});
                                      },
                                      child: Obx(
                                        () => Icon(
                                          audioPLayerController.isPlaying.value ? Icons.pause : Icons.play_arrow,
                                          color: Colors.white,
                                          size: 38,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        if(currentIndex != songs.length -1 ){
                                          setState(() {
                                            audioPLayerController.song = songs[currentIndex +1].obs;
                                            currentIndex++;
                                          });
                                          await audioPLayerController.play();
                                        }
                                      },
                                      child: Icon(
                                        Icons.skip_next,
                                        color: currentIndex != songs.length -1  ? Colors.white : Colors.white.withOpacity(0.4),
                                        size: 38,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              title: Text(
                                audioPLayerController.song?.value.name ?? '',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
              ],
            );
          }
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.white,
          ));
        });
  }

  @override
  Future dispose() async {
    super.dispose();
    await audioPLayerController.stop();
    audioPLayerController.song = null;
    audioPLayerController = AudioPLayerController();
  }
}
