import 'package:hive/hive.dart';
import 'package:hymnal_app/model/hymn.dart';

part 'collection.g.dart';

@HiveType(typeId: 1)
class Collection extends HiveObject {
  Collection({this.id, required this.name, this.hymns});

  @HiveField(0)
  int? id;

  @HiveField(1)
  String name;

  @HiveField(2)
  List<Hymn>? hymns;
}
