import 'package:flutter/material.dart';
import 'package:le_esting_task/assets/colors/colors.dart';
import 'package:le_esting_task/assets/res/project_icons.dart';
import 'package:le_esting_task/assets/res/project_pictures.dart';
import 'package:le_esting_task/assets/strings/project_strings.dart';
import 'package:le_esting_task/features/floors/screen/floors_screen.dart';
import 'package:le_esting_task/features/widgets/circle_indicator.dart';
import 'package:le_esting_task/features/widgets/icon_button_with_title.dart';

/// главная страница приложения
class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _MainBackground(),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 95,
              ),
              Image.asset(ProjectPictures.pLogo, width: 473.0, height: 91.0),
              const SizedBox(
                height: 91,
              ),
              const _ProjectName(),
              const SizedBox(
                height: 50,
              ),
              const SizedBox(
                height: 100,
              ),
              const _ButtonMainRow(),
            ],
          ),
        ],
      ),
    );
  }
}

/// фон главной страницы
class _MainBackground extends StatelessWidget {
  const _MainBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          ProjectPictures.leftTower,
          width: MediaQuery.of(context).size.width / 6,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.fill,
        ),
        Expanded(child: Container()),
        Image.asset(
          ProjectPictures.rightTower,
          width: MediaQuery.of(context).size.width / 5,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.fill,
        ),
      ],
    );
  }
}

/// панель кнопок
class _ButtonMainRow extends StatelessWidget {
  const _ButtonMainRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ButtonWidget(
          buttonHeight: 145,
          buttonWidth: 176,
          buttonColor: ProjectColors.buttonSecondary,
          iconPath: ProjectIcons.iInfo,
          buttonName: ProjectStrings.aboutUsBtn,
          onPressed: () {
            _showDialogFunc(
              context,
              ProjectStrings.title,
              ProjectStrings.desc,
            );
          },
        ),
        const SizedBox(
          width: 45,
        ),
        ButtonWidget(
          buttonHeight: 145,
          buttonWidth: 276,
          buttonRadius: 26,
          buttonColor: ProjectColors.primary,
          iconPath: ProjectIcons.iMap,
          buttonName: ProjectStrings.mapBtn,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FloorsScreen()),
            );
          },
        ),
        const SizedBox(
          width: 40,
        ),
        ButtonWidget(
          buttonHeight: 145,
          buttonWidth: 176,
          buttonColor: ProjectColors.buttonSecondary,
          iconPath: ProjectIcons.iDialog,
          buttonName: ProjectStrings.instructionBtn,
          onPressed: () {
            _showDialogFunc(
              context,
              ProjectStrings.title,
              ProjectStrings.desc,
            );
          },
        ),
      ],
    );
  }
}

/// виджет описания проекта
class _ProjectName extends StatelessWidget {
  const _ProjectName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: ProjectStrings.appName1,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 70,
              fontFamily: 'PlayfairDisplay',
              color: ProjectColors.mainDark,
            ),
          ),
          TextSpan(
            text: ProjectStrings.appName2,
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 54,
              fontFamily: 'PlayfairDisplay',
              color: ProjectColors.mainDark,
            ),
          ),
        ],
      ),
    );
  }
}

/// функция возвращающая диалог с 3 этапами анбординга
/// на вход требует:
/// title - строка - заголовок анбординга
/// desc - массив строк - описание этапов анбординга
_showDialogFunc(BuildContext context, String title, List<String> desc) {
  return showDialog(
    context: context,
    builder: (context) {
      int chosenCircle = 0;
      return StatefulBuilder(builder: (context, setState) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              padding: const EdgeInsets.only(
                  left: 49, top: 30, bottom: 40, right: 49),
              height: 561,
              width: MediaQuery.of(context).size.width * 0.36,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          fontFamily: 'PlayfairDisplay',
                          color: ProjectColors.mainDark,
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      CircleIndicatorWidget(
                        chosenCircle: chosenCircle,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    desc[chosenCircle],
                    style: const TextStyle(
                      fontSize: 30,
                      fontFamily: 'Montserrat',
                      color: ProjectColors.mainDark,
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ProjectColors.primary,
                      ),
                      onPressed: () {
                        setState(() {
                          if (chosenCircle == 2) {
                            chosenCircle = 0;
                          } else {
                            chosenCircle = ++chosenCircle;
                          }
                        });
                      },
                      child: const SizedBox(
                        width: 290,
                        height: 80,
                        child: Center(
                          child: Text(
                            ProjectStrings.next,
                            style: TextStyle(
                              fontSize: 30,
                              fontFamily: 'Montserrat',
                              color: ProjectColors.mainLight,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
    },
  );
}
