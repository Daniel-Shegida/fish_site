import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:le_esting_task/assets/colors/colors.dart';
import 'package:le_esting_task/assets/res/project_icons.dart';
import 'package:le_esting_task/assets/strings/project_strings.dart';
import 'package:le_esting_task/features/entity/hero.dart';
import 'package:le_esting_task/features/video/screen/video_player_screen.dart';
import 'package:le_esting_task/features/widgets/transparent_appbar.dart';
import 'package:video_player/video_player.dart';

/// mda
class HeroesDetailScreen extends StatefulWidget {
  final FloorHero hero;

  const HeroesDetailScreen({required this.hero, Key? key}) : super(key: key);

  @override
  State<HeroesDetailScreen> createState() => _HeroesDetailScreenState();
}

class _HeroesDetailScreenState extends State<HeroesDetailScreen> {
  bool isFullText = false;
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.hero.videoPath)
      ..initialize().then((_) {
        setState(() {}); //when your thumbnail will show.
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBar(
        title: widget.hero.name,
        isButton: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 323, top: 36, bottom: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 805,
              child: Text(
                widget.hero.desc,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 36,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VideoPlayerScreen(
                            videoPath: widget.hero.videoPath,
                          )),
                );
              },
              child: SizedBox(
                height: 600,
                width: 950,
                child: _controller.value.isInitialized
                    ? Stack(children: [
                        VideoPlayer(_controller),
                        Center(
                          child: SvgPicture.asset(
                            ProjectIcons.iRun,
                            height: 119,
                            width: 100,
                          ),
                        )
                      ])
                    : const CircularProgressIndicator(),
              ),
            ),
            const SizedBox(
              height: 36,
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 29,
              ),
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: ProjectColors.primary,
                    width: 20.0,
                  ),
                ),
              ),
              child: SizedBox(
                width: 989,
                child: Column(
                  children: [
                    Text(
                      widget.hero.quote,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: isFullText ? null : 1,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isFullText = !isFullText;
                        });
                      },
                      child: const Text(
                        ProjectStrings.read,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: ProjectColors.primary,
                          fontFamily: 'Montserrat',
                          fontSize: 30,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
