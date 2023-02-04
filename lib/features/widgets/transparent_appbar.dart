import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:le_esting_task/assets/colors/colors.dart';
import 'package:le_esting_task/assets/res/project_icons.dart';
import 'package:le_esting_task/assets/strings/project_strings.dart';
import 'package:le_esting_task/features/widgets/icon_button_with_title.dart';

/// прозрачный appbar стандартный для приложения
class TransparentAppBar extends StatelessWidget with PreferredSizeWidget {
  /// название экрана
  final String title;

  /// дополнительное название под кнопкой
  final String? subTitle;

  /// добавлена ли кнопка
  final bool isButton;

  /// функция при нажатию на кнопку
  final VoidCallback? onPressed;

  TransparentAppBar(
      {required this.title,
      required this.isButton,
      this.subTitle,
      this.onPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leadingWidth: 178,
      toolbarHeight: 255,
      actions: isButton
          ? [
              Container(
                padding: const EdgeInsets.only(top: 70, right: 75),
                child: ButtonWidget(
                  buttonHeight: 120,
                  buttonWidth: 166,
                  buttonColor: ProjectColors.buttonSecondary,
                  iconPath: ProjectIcons.iHeroes,
                  buttonName: ProjectStrings.allHeroes,
                  onPressed: onPressed!,
                ),
              ),
            ]
          : [],
      title: Padding(
        padding: const EdgeInsets.only(left: 80.0, top: 70, bottom: 65),
        child: RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 64,
                  fontFamily: 'PlayfairDisplay',
                  color: ProjectColors.mainDark,
                ),
              ),
              if (subTitle != null)
                TextSpan(
                  text: "\n$subTitle",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 48,
                    fontFamily: 'PlayfairDisplay',
                    color: ProjectColors.mainDark,
                  ),
                ),
            ],
          ),
        ),
      ),
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: SvgPicture.asset(
          ProjectIcons.iBackArrow,
          color: ProjectColors.mainDark,
          fit: BoxFit.none,
          alignment: Alignment.centerRight,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(255);
}
