import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player_app/core/controllers.dart';
import 'package:music_player_app/models/song.dart';
import 'package:music_player_app/screens/home_screen.dart';

class SongItemCard extends StatefulWidget {
  const SongItemCard({required this.song, required this.onTap, Key? key}) : super(key: key);

  final Song song;
  final Function() onTap;

  @override
  State<SongItemCard> createState() => _SongItemCardState();
}

class _SongItemCardState extends State<SongItemCard> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final AudioPlayerController audioPLayerController = Get.find();
    return GestureDetector(
      onTap: () async {
        await widget.onTap();
        Get.toNamed('/now_playing');
      },
      child: Container(
        height: 90,
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Obx(
            ()=> Container(
              decoration: BoxDecoration(
                color: audioPLayerController.cardBgColor(widget.song).value ,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: InkWell(
                    onTap: () async {
                      if (audioPLayerController.song.value == widget.song) {
                        if (audioPLayerController.isPlaying.value) {
                          await audioPLayerController.pause();
                        } else {
                          await audioPLayerController.play();
                        }
                      } else {
                        widget.onTap();
                      }
                    },
                    child: audioPLayerController.song.value == widget.song
                        ? Obx(
                          () =>  CircleAvatar(
                              radius: 20,
                              backgroundColor: audioPLayerController.isPlaying.value ?  MyColors.secondaryColor : MyColors.tertiaryColor,
                              child: Icon(
                                (audioPLayerController.isPlaying.value) ? Icons.pause : Icons.play_arrow,
                                color: (audioPLayerController.isPlaying.value) ? MyColors.tertiaryColor : MyColors.secondaryColor,
                              )
                            ),
                        )
                        : CircleAvatar(
                            radius: 20,
                            backgroundColor: MyColors.tertiaryColor,
                            child: Icon(
                              Icons.play_arrow,
                              color: MyColors.secondaryColor,
                            ))),
                title: Text(
                  widget.song.name,
                  style: GoogleFonts.poppins(
                    color: MyColors.tertiaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                // subtitle: Text(widget.song.artist),
                subtitle: Text(widget.song.artist, style: GoogleFonts.poppins(color: MyColors.tertiaryColor, fontWeight: FontWeight.w300)),
                trailing: Text(
                    formatDuration(widget.song.duration),
                    style: GoogleFonts.poppins(color: MyColors.tertiaryColor, letterSpacing: 1.3)
                ),
              ),
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
