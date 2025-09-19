
import 'package:isar/isar.dart';


@collection
class UserEntity {
  Id id = Isar.autoIncrement;
  late String name;
  String? token;
  DateTime? expiresAt;
}
