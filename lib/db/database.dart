import 'package:moor_flutter/moor_flutter.dart';

part 'database.g.dart';

class Users extends Table{

  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().nullable()();
  TextColumn get stbNo => text().nullable()();
  DateTimeColumn get modifiedDate => dateTime().nullable()();
  TextColumn get area => text().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get mobile => text().nullable()();
  BoolColumn get isSelected => boolean().withDefault(Constant(false))();

/*
  User(this.id, this.name, this.stbNo, this.area, this.mobile,
      this.modified, {this.notes="",this.isSelected=false});*/

}

@UseMoor(tables: [Users], daos: [UsersDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super((FlutterQueryExecutor.inDatabaseFolder(path: 'db.customer',logStatements: true)));

  @override
  int get schemaVersion => 1;
}

@UseDao(tables: [Users])
class UsersDao extends DatabaseAccessor<AppDatabase> with _$UsersDaoMixin {
  final AppDatabase db;
  UsersDao(this.db) : super(db);

  Stream<List<User>> watchAllTasks() {
       return (select(users)
         ..orderBy([
           (t) => OrderingTerm.asc(t.name),
           (t) => OrderingTerm.desc(t.modifiedDate)
         ])).watch();
  }

  Future<List<User>> getAllTasks() => select(users).get();
  // Stream<List<User>> watchAllTasks() => select(users).watch();
  Future insertTask(Insertable<User> task) => into(users).insert(task);
  Future updateTask(Insertable<User> task) => update(users).replace(task);
  Future deleteTask(Insertable<User> task) => delete(users).delete(task);
}