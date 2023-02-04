import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:le_esting_task/assets/colors/colors.dart';
import 'package:le_esting_task/assets/res/project_icons.dart';
import 'package:le_esting_task/assets/res/project_pictures.dart';
import 'package:le_esting_task/assets/strings/project_strings.dart';
import 'package:le_esting_task/features/floors/repository/floors_rep.dart';
import 'package:le_esting_task/features/entity/places.dart';
import 'package:le_esting_task/features/entity/hero.dart';
import 'package:le_esting_task/features/heroes/heroes_detail_screen.dart';
import 'package:le_esting_task/features/heroes/heroes_screen.dart';
import 'package:le_esting_task/features/widgets/circle_indicator.dart';
import 'package:le_esting_task/features/widgets/transparent_appbar.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';


/// экран с этажами
class FloorsScreen extends StatelessWidget {
  final FloorsRepository rep = FloorsRepository();

  FloorsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(viewportFraction: 1, initialPage: 1),
      items: [
        1,
        2,
        3,
      ].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return _FloorScreen(
              floor: i,
              rep: rep,
            );
          },
        );
      }).toList(),
    );
  }
}

/// экран конкретного этажа
class _FloorScreen extends StatefulWidget {
  /// выбранный этж
  final int floor;
  /// репозиторий для получения героев и описаний карты
  /// (можно получать через провайжер)
  final FloorsRepository rep;

  const _FloorScreen({required this.floor, required this.rep, Key? key})
      : super(key: key);

  @override
  State<_FloorScreen> createState() => _FloorScreenState();
}

class _FloorScreenState extends State<_FloorScreen> {
  late List<Place> places;
  late List<FloorHero> heroes;

  @override
  void initState() {
    places = widget.rep.getFloorPlaces(widget.floor);
    heroes = widget.rep.getFloorHeroes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBar(
        title: ProjectStrings.map,
        subTitle: ProjectStrings.getFloorName(widget.floor),
        isButton: true,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HeroesScreen(floor: widget.floor, heroes: heroes,)),
          );
        },
      ),
      body: Center(
        child: Row(
          children: [
            _MapWidget(
              floor: widget.floor,
              heroes: heroes,
            ),
            _TextFloorWidget(
              places: places,
            ),
          ],
        ),
      ),
    );
  }
}

/// список описаний карты
class _TextFloorWidget extends StatelessWidget {
  /// список мест для отображения
  final List<Place> places;

  const _TextFloorWidget({required this.places, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: places.length,
          itemBuilder: (BuildContext context, int index) {
            return places[index].getListTile();
          }),
    );
  }
}

/// интерактивная карта с индикатором выбранного этажа
class _MapWidget extends StatelessWidget {
  /// контроллер для перемещения героев в диалоге
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  /// выбранный этаж
  final int floor;
  /// герои отображаемые в диалоге
  final List<FloorHero> heroes;

  _MapWidget({required this.floor, required this.heroes, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 255),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              showDialogFunc(
                context,
                heroes,
                // [
                //   Hero1(
                //       imagePath: 'imagePath',
                //       name: 'name',
                //       position: 'position',
                //       location: 'location',
                //       desc: 'desc',
                //       quote: 'quote')
                // ],
                // Hero1(
                //     imagePath: ProjectPictures.getFoto(1),
                //     name: 'name',
                //     position: 'position',
                //     location: 'location',
                //     desc: 'desc',
                //     quote: 'quote'),
                itemScrollController,
                itemPositionsListener,
              );
            },
            child: Image.asset(
              ProjectPictures.getFloorMap(floor),
              fit: BoxFit.none,
            ),
          ),
          CircleIndicatorWidget(
            chosenCircle: floor - 1,
          )
        ],
      ),
    );
  }
}

showDialogFunc(
    BuildContext context,
    List<FloorHero> heroes,
    ItemScrollController itemScrollController,
    ItemPositionsListener itemPositionsListener) {
  return showDialog(
      context: context,
      builder: (context) => Dialog(
            child: _FloorsHeroesWidget(
              heroes: heroes,
            ),
          ));
}

class _FloorsHeroesWidget extends StatefulWidget {
  static int duration = 1;

  final List<FloorHero> heroes;

  _FloorsHeroesWidget({required this.heroes, Key? key}) : super(key: key);

  @override
  State<_FloorsHeroesWidget> createState() => _FloorsHeroesWidgetState();
}

class _FloorsHeroesWidgetState extends State<_FloorsHeroesWidget> {
  final ItemScrollController itemScrollController = ItemScrollController();

  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  int heroIndex = 0;

  void _scrollRight() {
    itemScrollController.scrollTo(
        index: ++heroIndex,
        duration: Duration(seconds: _FloorsHeroesWidget.duration));
    setState(() {});
  }

  void _scrollLeft() {
    itemScrollController.scrollTo(
        index: --heroIndex,
        duration: Duration(seconds: _FloorsHeroesWidget.duration));
    setState(() {});
  }

  bool _isScrollableRight() {
    return widget.heroes.length > 3 && ((heroIndex + 3) < widget.heroes.length);
  }

  bool _isScrollableLeft() {
    return widget.heroes.length > 3 && heroIndex > 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1000,
      height: 700,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              left: 90,
              right: 100,
              top: 70,
            ),
            child: Row(
              children: [
                Container(
                  width: 69,
                  height: 65,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ProjectColors.primary,
                      width: 3,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      (widget.heroes.length).toString(),
                      style: const TextStyle(
                        fontSize: 30,
                        fontFamily: 'Montserrat',
                        color: ProjectColors.primary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 21,
                ),
                const Expanded(
                  child: Text(
                    ProjectStrings.fish,
                    style: TextStyle(
                      fontSize: 26,
                      fontFamily: 'Montserrat',
                      color: ProjectColors.primary,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 60,
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ScrollWidget(
                  isLeft: true,
                  isVisible: _isScrollableLeft(),
                  scroll: _scrollLeft,
                ),
                Expanded(
                  child: ScrollablePositionedList.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.heroes.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: _HeroFloorsCard(
                        hero: widget.heroes[index],
                      ),
                    ),
                    itemScrollController: itemScrollController,
                    itemPositionsListener: itemPositionsListener,
                  ),
                ),
                _ScrollWidget(
                  isLeft: false,
                  isVisible: _isScrollableRight(),
                  scroll: _scrollRight,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ScrollWidget extends StatelessWidget {
  final bool isLeft;
  final bool isVisible;
  final VoidCallback scroll;

  const _ScrollWidget(
      {required this.isLeft,
      required this.isVisible,
      required this.scroll,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Align(
        alignment: Alignment.bottomRight,
        child: RotatedBox(
          quarterTurns: isLeft ? 2 : 0,
          child: Padding(
            padding: const EdgeInsets.only(left: 32, right: 22),
            child: isVisible
                ? InkWell(
                    onTap: scroll,
                    child: SvgPicture.asset(ProjectIcons.iScrollButton),
                  )
                : Container(
                    width: 62,
                  ),
          ),
        ),
      ),
    );
  }
}

class test extends StatelessWidget {
  int test1 = 0;
  final VoidCallback itemScrollController;

  test({required this.itemScrollController, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: itemScrollController, child: Text("dadq"));
  }
}

class _HeroFloorsCard extends StatelessWidget {
  final FloorHero hero;

  const _HeroFloorsCard({required this.hero, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Column(
        children: [
          Image.asset(
            hero.imagePath,
            height: 250,
            width: 250,
            fit: BoxFit.fill,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            hero.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: 'Montserrat',
              color: ProjectColors.mainDark,
            ),
          ),
          // SizedBox(
          //   height: 8,
          // ),
          Text(
            hero.position,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: 'Montserrat',
              color: ProjectColors.textSecondary,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ProjectColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const SizedBox(
              height: 56,
              width: 200,
              child: Center(
                child: Text(
                  ProjectStrings.choose,
                  style: TextStyle(
                    fontSize: 20,
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
        ],
      ),
    );
  }
}
