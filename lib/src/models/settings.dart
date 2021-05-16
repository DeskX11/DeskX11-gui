import './model.dart';

class Settings extends Model {
  static String table = 'settings';

  int id;
  int resolutionX;
  int resolutionY;
  String key;

  Settings(
      {this.id,
      this.resolutionX = 1920,
      this.resolutionY = 1080,
      this.key = 'ESC'});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'resolutionX': resolutionX,
      'resolutionY': resolutionY,
      'key': key
    };

    return map;
  }

  // нужен каст типов из-за того драйвер приводит строку с числом к инту
  static Settings fromMap(Map<String, dynamic> map) {
    return Settings(
        id: map['id'],
        resolutionX: map['resolutionX'],
        resolutionY: map['resolutionY'],
        key: map['key'].toString());
  }
}
