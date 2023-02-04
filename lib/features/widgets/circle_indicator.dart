import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:le_esting_task/assets/res/project_icons.dart';

/// виджет с круглыми индикаторами (стандартное количество = 3)
class CircleIndicatorWidget extends StatelessWidget {
  /// количество индикаторов
  final int numberCircles;

  /// выбранный индикатор слева направо
  final int chosenCircle;

  const CircleIndicatorWidget(
      {this.numberCircles = 3, required this.chosenCircle, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = numberCircles; i > 0; i--)
          i == (numberCircles - chosenCircle)
              ? SvgPicture.asset(ProjectIcons.iFullCircle)
              : SvgPicture.asset(ProjectIcons.iHollowCircle),
      ],
    );
  }
}
