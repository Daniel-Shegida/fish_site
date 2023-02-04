/// строки проекта
abstract class ProjectStrings {

  static const String appName1 = 'Lorem ipsum.';

  static const String appName2 = '\nLoren ipsum dolor sit amet';

  static const String briefDesc = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce eu viverra lectus. Nam sagittis arcu vel felis auctor, ut malesuada lacus hendrerit. Donec ut auctor libero. Donec tincidunt at diam nec pulvinar. Donec posuere hendrerit rhoncus. Vestibulum arcu diam, viverra sit amet sem nec, mollis mollis quam. In sed pellentesque velit.';

  static const String fish = 'Lorem ipsum dolor sit ametLorem ipsum dolor sit ametLorem ipsum dolor sit amet';

  static const String aboutUsBtn = 'О нас';

  static const String mapBtn = 'Карта';

  static const String instructionBtn = 'Инструкция';

  static const String allHeroes = 'Все герои';

  static const String next = 'Далее';

  static const String choose = 'Выбрать';

  static const String title = 'Заголовок';

  static const String map = 'Карта';

  static const String watch = 'Смотреть интервью';

  static const String read = 'Читать полностью';

  ///  список инструкций
  static const List<String> desc = [
    "Текст с описанием инструкции1",
    "Текст с описанием инструкции2",
    "Текст с описанием инструкции3",
  ];

  ///  возвращает название этажа
  static String getFloorName(int floor) {
    switch(floor){
      case 1: return "Цокольный этаж";
      case 2: return "Первый этаж";
      case 3: return "Второй этаж";
    }
    return "";
  }
}