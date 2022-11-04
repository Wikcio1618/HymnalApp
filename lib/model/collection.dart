import 'package:hive/hive.dart';
import 'package:hymnal_app/model/hymn.dart';

@HiveType(typeId: 0)
class Collection extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  List<Hymn>? hymns;
}
