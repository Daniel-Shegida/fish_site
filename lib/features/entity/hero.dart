/// структура героя
class FloorHero {
  /// изображение в пнг
  String imagePath;

  /// имя героя
  String name;

  /// должность героя
  String position;

  /// местположение героя
  String location;

  /// описание героя
  String desc;

  /// цитата героя
  String quote;

  /// видео героя
  String videoPath;

  FloorHero({
    required this.imagePath,
    required this.name,
    required this.position,
    required this.location,
    required this.desc,
    required this.quote,
    required this.videoPath
  });
}
