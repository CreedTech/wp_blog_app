import 'package:hive/hive.dart';

part 'posts.g.dart';

@HiveType(typeId: 0)
class Posts {
  @HiveField(0)
  bool? isDark = false;

  @HiveField(1)
  final String? title;

  @HiveField(2)
  final String? image;

  @HiveField(3)
  final String? contents;

  @HiveField(4)
  final String? time;

  @HiveField(5)
  final String? author;

  @HiveField(6)
  final String? id;

  Posts({
    this.title,
    this.image,
    this.contents,
    this.time,
    this.author,
    this.id,
  });

  void changeTheme() {
    isDark = !isDark!;
  }
}
