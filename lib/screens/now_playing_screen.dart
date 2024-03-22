import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player_app/core/controllers.dart';
import 'package:music_player_app/models/song.dart';
import 'package:music_player_app/screens/home_screen.dart';

class NowPLayingScreen extends StatefulWidget {
  const NowPLayingScreen({super.key});

  @override
  State<NowPLayingScreen> createState() => _NowPLayingScreenState();
}

class _NowPLayingScreenState extends State<NowPLayingScreen> {
  @override
  Widget build(BuildContext context) {
    final AudioPlayerController audioPLayerController = Get.find();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
            image: NetworkImage(audioPLayerController.song.value?.imageUrl ?? ''),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 60,
                  left: 10,
                  right: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back(
                            result: 's'
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Now PLAYING",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // audioPLayerController.stop();
                        },
                        icon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  top: 100,
                  left: 10,
                  right: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SvgPicture.asset('assets/sound-wave-3.svg'),
                          Container(
                            width: 220,
                            height: 220,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(500),
                              image: DecorationImage(
                                image: NetworkImage(audioPLayerController.song.value?.imageUrl ?? ''),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 150,
                            height: 35,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.transparent), // No background color
                                shadowColor: MaterialStateProperty.all(Colors.transparent), // No shadow
                                elevation: MaterialStateProperty.all(0),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    side: const BorderSide(color: Colors.white, width: 2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  const Icon(
                                    Icons.favorite_border_outlined,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "Follow",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 160,
                            height: 35,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(MyColors.secondaryColor),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  const Icon(
                                    Icons.shuffle,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "SHUFFLE PLAY",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      Text(
                        audioPLayerController.song.value?.name ?? '',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        audioPLayerController.song.value?.artist ?? '',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(
                            () => Text(
                              formatDuration(audioPLayerController.position.value.inMilliseconds),
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: Obx(
                              () => SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  trackHeight: 2.0,
                                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5.0),
                                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 11.0),
                                ),
                                child: Slider(
                                  value: audioPLayerController.position.value.inSeconds.toDouble(),
                                  max: audioPLayerController.duration.value.inSeconds.toDouble(),
                                  onChanged: (value) async {
                                    await audioPLayerController.seek(value: value);
                                    await audioPLayerController.resume();
                                  },
                                  inactiveColor: Colors.white.withOpacity(0.3),
                                  thumbColor: Colors.white,
                                  activeColor: MyColors.secondaryColor,
                                  overlayColor: MaterialStatePropertyAll(Colors.white.withOpacity(0.4)),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            formatDuration(audioPLayerController.duration.value.inMilliseconds),
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () async {
                              if (audioPLayerController.inSearchMode.value) {
                                if (audioPLayerController.currentIndex.value != 0) {
                                  audioPLayerController.setCurrentIndex(audioPLayerController.currentIndex.value - 1);
                                  Song newSong = audioPLayerController.searchedSongs[audioPLayerController.currentIndex.value];
                                  audioPLayerController.setSong(newSong);
                                  await audioPLayerController.play();
                                  setState(() {});
                                }
                              } else {
                                if (audioPLayerController.currentIndex.value != 0) {
                                  audioPLayerController.setCurrentIndex(audioPLayerController.currentIndex.value - 1);
                                  Song newSong = audioPLayerController.listOfSongs[audioPLayerController.currentIndex.value];
                                  audioPLayerController.setSong(newSong);
                                  await audioPLayerController.play();
                                  setState(() {});
                                }
                              }
                            },
                            icon: const Icon(
                              Icons.skip_previous,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.fast_rewind_sharp,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              if (audioPLayerController.isPlaying.value) {
                                await audioPLayerController.pause();
                              } else {
                                await audioPLayerController.play();
                              }
                            },
                            icon: Obx(
                              () => Icon(
                                (audioPLayerController.isPlaying.value) ? Icons.pause_circle : Icons.play_circle,
                                color: Colors.white,
                                size: 80,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.fast_forward_sharp,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              if (audioPLayerController.inSearchMode.value) {
                                if (audioPLayerController.currentIndex.value != audioPLayerController.searchedSongs.length - 1) {
                                  audioPLayerController.setCurrentIndex(audioPLayerController.currentIndex.value + 1);

                                  Song newSong = audioPLayerController.searchedSongs[audioPLayerController.currentIndex.value];
                                  audioPLayerController.setSong(newSong);
                                  await audioPLayerController.play();
                                  setState(() {});
                                }
                              } else {
                                if (audioPLayerController.currentIndex.value != audioPLayerController.listOfSongs.length - 1) {
                                  audioPLayerController.setCurrentIndex(audioPLayerController.currentIndex.value + 1);
                                  Song newSong = audioPLayerController.listOfSongs[audioPLayerController.currentIndex.value];
                                  audioPLayerController.setSong(newSong);
                                  await audioPLayerController.play();
                                  setState(() {});
                                }
                              }
                            },
                            icon: const Icon(
                              Icons.skip_next,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String formatDuration(int milliseconds) {
    int seconds = (milliseconds / 1000).round();
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;

    String formattedMinutes = minutes.toString().padLeft(2);
    String formattedSeconds = remainingSeconds.toString().padLeft(2, '0');

    return '$formattedMinutes:$formattedSeconds';
  }
}
