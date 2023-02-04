import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:le_esting_task/assets/colors/colors.dart';

/// кастомная кнопка с иконкой и описанием
class ButtonWidget extends StatelessWidget {
  /// высота кнопки
  final double buttonHeight;

  /// ширина кнопки
  final double buttonWidth;

  /// радиус округления в стандарте = 20
  final double buttonRadius;

  /// цвет кнопки
  final Color buttonColor;

  /// svg путь до иконки
  final String iconPath;

  /// описание кнопки
  final String buttonName;

  /// функция кнопки при нажатии
  final Function() onPressed;

  const ButtonWidget(
      {required this.buttonHeight,
      required this.buttonWidth,
      required this.buttonColor,
      required this.iconPath,
      required this.buttonName,
      required this.onPressed,
      this.buttonRadius = 20,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(buttonRadius),
            ),
          ),
          onPressed: onPressed,
          child: SizedBox(
            width: buttonWidth,
            height: buttonHeight,
            child: SvgPicture.asset(
              iconPath,
              fit: BoxFit.none,
            ),
          ),
        ),
        const SizedBox(
          height: 14,
        ),
        Text(
          buttonName,
          style: const TextStyle(
              fontSize: 32,
              fontFamily: 'Montserrat',
              color: ProjectColors.mainDark),
        ),
      ],
    );
  }
}
