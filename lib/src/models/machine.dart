import './model.dart';

class Machine extends Model {
  static String table = 'machine_list';

  int id;
  String compression;
  String password;
  String encryption;
  int port;
  String cmd;
  String ip;

  Machine(
      {this.id,
      this.compression,
      this.password,
      this.encryption,
      this.port,
      this.cmd,
      this.ip});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'compression': compression,
      'password': password,
      'encryption': encryption,
      'port': port,
      'cmd': cmd,
      'ip': ip
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  static Machine fromMap(Map<String, dynamic> map) {
    return Machine(
        id: map['id'],
        compression: map['compression'],
        password: map['password'],
        encryption: map['encryption'],
        port: map['port'],
        cmd: map['cmd'],
        ip: map['ip']);
  }
}
