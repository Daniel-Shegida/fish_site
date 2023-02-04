import 'package:flutter/material.dart';
import 'package:le_esting_task/assets/colors/colors.dart';
import 'package:le_esting_task/assets/strings/project_strings.dart';
import 'package:le_esting_task/features/entity/hero.dart';
import 'package:le_esting_task/features/heroes/heroes_detail_screen.dart';
import 'package:le_esting_task/features/widgets/transparent_appbar.dart';

/// экран с фиксированными 8 героями
class HeroesScreen extends StatelessWidget {
  /// этаж с которого был вызван экран
  final int floor;

  /// герои [требование >= 8]
  final List<FloorHero> heroes;

  const HeroesScreen({required this.floor, required this.heroes, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBar(
        title: ProjectStrings.allHeroes,
        isButton: false,
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.only(left: 323, right: 321, top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HeroCardRawWidget(
              floorName: ProjectStrings.getFloorName(floor),
              rawNumber: 0,
              heroes: heroes,
            ),
            _HeroCardRawWidget(
                floorName: ProjectStrings.getFloorName(floor),
                rawNumber: 1,
                heroes: heroes),
          ],
        ),
      )),
    );
  }
}

/// Todo[daniel]: refactor later
class _HeroCardRawWidget extends StatelessWidget {
  final String floorName;
  final int rawNumber;
  final List<FloorHero> heroes;

  const _HeroCardRawWidget(
      {required this.floorName,
      required this.rawNumber,
      required this.heroes,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          floorName,
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontFamily: 'PlayfairDisplay',
            fontSize: 48,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            HeroCardWidget(
              hero: heroes[4 * rawNumber],
            ),
            const SizedBox(
              width: 20,
            ),
            HeroCardWidget(
              hero: heroes[4 * rawNumber + 1],
            ),
            const SizedBox(
              width: 20,
            ),
            HeroCardWidget(
              hero: heroes[4 * rawNumber + 2],
            ),
            const SizedBox(
              width: 20,
            ),
            HeroCardWidget(
              hero: heroes[4 * rawNumber + 3],
            ),
          ],
        ),
      ],
    );
  }
}

class HeroCardWidget extends StatelessWidget {
  final FloorHero hero;

  const HeroCardWidget({required this.hero, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => Dialog(
            child: Container(
              padding: const EdgeInsets.only(
                  left: 70, right: 70, top: 60, bottom: 25),
              width: 500,
              height: 820,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    hero.imagePath,
                    height: 360,
                    width: 360,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    hero.name,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      fontFamily: 'Montserrat',
                      color: ProjectColors.mainDark,
                    ),
                  ),
                  Text(
                    hero.position,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      fontFamily: 'Montserrat',
                      color: ProjectColors.mainDark,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    ProjectStrings.fish,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 26,
                      fontFamily: 'Montserrat',
                      color: ProjectColors.mainDark,
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ProjectColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const SizedBox(
                        height: 84,
                        width: 359,
                        child: Center(
                          child: Text(
                            ProjectStrings.watch,
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'Montserrat',
                              color: ProjectColors.mainLight,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HeroesDetailScreen(hero: hero,)),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: Column(
        children: [
          Image.asset(
            hero.imagePath,
            height: 300,
            width: 304,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 4),
            child: Text(
              hero.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            hero.position,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 20,
                color: ProjectColors.textSecondary),
          )
        ],
      ),
    );
  }
}
