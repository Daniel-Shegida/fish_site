import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:le_esting_task/assets/res/project_icons.dart';
import 'package:video_player/video_player.dart';

class BasicOverlayWidget extends StatelessWidget {
  final VideoPlayerController controller;

  const BasicOverlayWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () =>
            controller.value.isPlaying ? controller.pause() : controller.play(),
        child: Stack(
          children: <Widget>[
            buildPlay(),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 75, top: 54),
                child: InkWell(
                  child: SvgPicture.asset(
                    ProjectIcons.iExit,
                  ),
                  onTap: () {},
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(left: 60, right: 36, bottom: 36),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      child: SvgPicture.asset(
                        controller.value.isPlaying
                            ? ProjectIcons.iPause
                            : ProjectIcons.iRun,
                      ),
                      onTap: () {
                        controller.value.isPlaying
                            ? controller.pause()
                            : controller.play();
                      },
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    InkWell(
                      child: SvgPicture.asset(
                        ProjectIcons.iBack,
                      ),
                      onTap: () {
                        controller.seekTo(Duration(
                            seconds: controller.value.position.inSeconds - 10));
                      },
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    InkWell(
                      child: SvgPicture.asset(
                        ProjectIcons.iForward,
                      ),
                      onTap: () {
                        controller.seekTo(Duration(
                            seconds: controller.value.position.inSeconds - 10));
                      },
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    InkWell(
                      child: SvgPicture.asset(
                        controller.value.volume != 0
                            ? ProjectIcons.iMixer
                            : ProjectIcons.iMixerOff,
                      ),
                      onTap: () {
                        controller.value.volume != 0
                            ? controller.setVolume(0)
                            : controller.setVolume(100);
                      },
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    ValueListenableBuilder(
                        valueListenable: controller,
                        builder: (context, VideoPlayerValue value, child) {
                          return Text(
                            "${_videoDuration(value.position)}/ ${_videoDuration(value.duration)}",
                            style: const TextStyle(color: Colors.white),
                          );
                        })
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: buildIndicator(),
            ),
          ],
        ),
      );

  Widget buildIndicator() => VideoProgressIndicator(
        controller,
        allowScrubbing: true,
      );

  Widget buildPlay() => controller.value.isPlaying
      ? Container()
      : Container(
          alignment: Alignment.center,
          color: Colors.black26,
          child: SvgPicture.asset(ProjectIcons.iRun),
        );

  String _videoDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }
}
