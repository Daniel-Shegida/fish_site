/// png path изоюражений проекта
abstract class ProjectPictures {
  static const String pLogo= 'assets/icons/logo.png';

  static const String leftTower= 'assets/icons/left_tower.png';

  static const String rightTower= 'assets/icons/right_tower.png';

  /// возвращает путь к карте конкретного этажа
  static String getFloorMap(int floor) {
    return 'assets/icons/floor$floor.png';
  }

  /// возвращает путь фото героя
  static String getFoto(int number) {
    return 'assets/icons/foto$number.jpg';
  }
}