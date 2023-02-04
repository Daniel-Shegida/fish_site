import 'package:le_esting_task/assets/res/project_icons.dart';
import 'package:le_esting_task/assets/res/project_pictures.dart';
import 'package:le_esting_task/features/entity/places.dart';
import 'package:le_esting_task/features/entity/hero.dart';

/// репозиторий для получения мест и героев
class FloorsRepository {
  /// Возвращает список мест в взависимости от этажа
  List<Place> getFloorPlaces(int floor) {
    switch (floor) {
      case 1:
        return _getImageFloorPlaces(15);
      case 2:
        return _getStringFloorPlaces(15);
      case 3:
        return _getStringFloorPlaces(15);
    }
    return [
      StringLeadingPlaces("", [""])
    ];
  }

  /// Возвразает список героев
  List<FloorHero> getFloorHeroes() {
    return [
      for (int i = 0; i <= 7; i++)
        FloorHero(
          imagePath: ProjectPictures.getFoto(1),
          name: 'name',
          position: 'position',
          location: 'location',
          desc: 'desc',
          quote: 'quote',
          videoPath: 'assets/video/video.mp4',
        )
    ];
  }

  /// Возвразает список мест с числовыми обозначениями
  List<StringLeadingPlaces> _getStringFloorPlaces(int numbersFloors) {
    return [
      for (var i = 1; i <= numbersFloors; i++)
        StringLeadingPlaces(
          'Lorem ipsum dolor sit amet.Lorem ipsum Lorem ipsum dolor sit ametLorem ipsum dolor sit amet',
          [i.toString()],
        )
    ];
  }

  /// Возвразает список мест с иконочными обозначениями
  List<ImageLeadingPlaces> _getImageFloorPlaces(int numbersFloors) {
    return [
      for (var i = 1; i <= numbersFloors; i++)
        ImageLeadingPlaces(
          'Lorem ipsum dolor sit amet',
          [(ProjectIcons.iInfoPlace)],
        )
    ];
  }
}
