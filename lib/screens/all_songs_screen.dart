import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player_app/core/controllers.dart';
import 'package:music_player_app/screens/home_screen.dart';
import 'package:music_player_app/shared_widgets/song_item_card.dart';

class AllSongsScreen extends StatefulWidget {
  const AllSongsScreen({super.key, required this.onTap});

  final Function() onTap;

  @override
  State<AllSongsScreen> createState() => _AllSongsScreenState();
}

class _AllSongsScreenState extends State<AllSongsScreen> {
  final AudioPlayerController audioPLayerController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: audioPLayerController.listOfSongs.length + 1,
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
                      color: MyColors.tertiaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    audioPLayerController.listOfSongs.length.toString(),
                    style: TextStyle(
                      color: MyColors.tertiaryColor.withOpacity(0),
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            );
          }
          return Obx(
            () => SongItemCard(
                song: audioPLayerController.listOfSongs[index - 1],
                onTap: () {
                  audioPLayerController.setInSearchMode(false);
                  if (audioPLayerController.song.value != null) {
                    if (audioPLayerController.song.value == audioPLayerController.listOfSongs[index - 1]) {
                      audioPLayerController.resume();
                    }
                  }
                  audioPLayerController.currentIndex = (index - 1).obs;
                  audioPLayerController.setSong(audioPLayerController.listOfSongs[index - 1]);
                  audioPLayerController.play();
                  widget.onTap();
                }),
          );
        },
      ),
    );
  }
}
