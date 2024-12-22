import 'package:flutter/foundation.dart' show immutable;

@immutable
class DBKeys {
  const DBKeys._();
  static const String dbName = 'tasks.db';
  static const String dbTable = 'tasks';
  static const String idColumn = 'id';
  static const String titleColumn = 'title';
  static const String noteColumn = 'note';
  static const String timeColumn = 'time';
  static const String dateColumn = 'date';
  static const String categoryColumn = 'category';
  static const String isCompletedColumn = 'isCompleted';
}
