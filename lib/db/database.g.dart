// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class User extends DataClass implements Insertable<User> {
  final int id;
  final String name;
  final String stbNo;
  final DateTime modifiedDate;
  final String area;
  final String notes;
  final String mobile;
  final bool isSelected;
  User(
      {@required this.id,
      this.name,
      this.stbNo,
      this.modifiedDate,
      this.area,
      this.notes,
      this.mobile,
      @required this.isSelected});
  factory User.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final boolType = db.typeSystem.forDartType<bool>();
    return User(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      stbNo:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}stb_no']),
      modifiedDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}modified_date']),
      area: stringType.mapFromDatabaseResponse(data['${effectivePrefix}area']),
      notes:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}notes']),
      mobile:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}mobile']),
      isSelected: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}is_selected']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || stbNo != null) {
      map['stb_no'] = Variable<String>(stbNo);
    }
    if (!nullToAbsent || modifiedDate != null) {
      map['modified_date'] = Variable<DateTime>(modifiedDate);
    }
    if (!nullToAbsent || area != null) {
      map['area'] = Variable<String>(area);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || mobile != null) {
      map['mobile'] = Variable<String>(mobile);
    }
    if (!nullToAbsent || isSelected != null) {
      map['is_selected'] = Variable<bool>(isSelected);
    }
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      stbNo:
          stbNo == null && nullToAbsent ? const Value.absent() : Value(stbNo),
      modifiedDate: modifiedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(modifiedDate),
      area: area == null && nullToAbsent ? const Value.absent() : Value(area),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      mobile:
          mobile == null && nullToAbsent ? const Value.absent() : Value(mobile),
      isSelected: isSelected == null && nullToAbsent
          ? const Value.absent()
          : Value(isSelected),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      stbNo: serializer.fromJson<String>(json['stbNo']),
      modifiedDate: serializer.fromJson<DateTime>(json['modifiedDate']),
      area: serializer.fromJson<String>(json['area']),
      notes: serializer.fromJson<String>(json['notes']),
      mobile: serializer.fromJson<String>(json['mobile']),
      isSelected: serializer.fromJson<bool>(json['isSelected']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'stbNo': serializer.toJson<String>(stbNo),
      'modifiedDate': serializer.toJson<DateTime>(modifiedDate),
      'area': serializer.toJson<String>(area),
      'notes': serializer.toJson<String>(notes),
      'mobile': serializer.toJson<String>(mobile),
      'isSelected': serializer.toJson<bool>(isSelected),
    };
  }

  User copyWith(
          {int id,
          String name,
          String stbNo,
          DateTime modifiedDate,
          String area,
          String notes,
          String mobile,
          bool isSelected}) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        stbNo: stbNo ?? this.stbNo,
        modifiedDate: modifiedDate ?? this.modifiedDate,
        area: area ?? this.area,
        notes: notes ?? this.notes,
        mobile: mobile ?? this.mobile,
        isSelected: isSelected ?? this.isSelected,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('stbNo: $stbNo, ')
          ..write('modifiedDate: $modifiedDate, ')
          ..write('area: $area, ')
          ..write('notes: $notes, ')
          ..write('mobile: $mobile, ')
          ..write('isSelected: $isSelected')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              stbNo.hashCode,
              $mrjc(
                  modifiedDate.hashCode,
                  $mrjc(
                      area.hashCode,
                      $mrjc(notes.hashCode,
                          $mrjc(mobile.hashCode, isSelected.hashCode))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.name == this.name &&
          other.stbNo == this.stbNo &&
          other.modifiedDate == this.modifiedDate &&
          other.area == this.area &&
          other.notes == this.notes &&
          other.mobile == this.mobile &&
          other.isSelected == this.isSelected);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> stbNo;
  final Value<DateTime> modifiedDate;
  final Value<String> area;
  final Value<String> notes;
  final Value<String> mobile;
  final Value<bool> isSelected;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.stbNo = const Value.absent(),
    this.modifiedDate = const Value.absent(),
    this.area = const Value.absent(),
    this.notes = const Value.absent(),
    this.mobile = const Value.absent(),
    this.isSelected = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.stbNo = const Value.absent(),
    this.modifiedDate = const Value.absent(),
    this.area = const Value.absent(),
    this.notes = const Value.absent(),
    this.mobile = const Value.absent(),
    this.isSelected = const Value.absent(),
  });
  static Insertable<User> custom({
    Expression<int> id,
    Expression<String> name,
    Expression<String> stbNo,
    Expression<DateTime> modifiedDate,
    Expression<String> area,
    Expression<String> notes,
    Expression<String> mobile,
    Expression<bool> isSelected,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (stbNo != null) 'stb_no': stbNo,
      if (modifiedDate != null) 'modified_date': modifiedDate,
      if (area != null) 'area': area,
      if (notes != null) 'notes': notes,
      if (mobile != null) 'mobile': mobile,
      if (isSelected != null) 'is_selected': isSelected,
    });
  }

  UsersCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<String> stbNo,
      Value<DateTime> modifiedDate,
      Value<String> area,
      Value<String> notes,
      Value<String> mobile,
      Value<bool> isSelected}) {
    return UsersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      stbNo: stbNo ?? this.stbNo,
      modifiedDate: modifiedDate ?? this.modifiedDate,
      area: area ?? this.area,
      notes: notes ?? this.notes,
      mobile: mobile ?? this.mobile,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (stbNo.present) {
      map['stb_no'] = Variable<String>(stbNo.value);
    }
    if (modifiedDate.present) {
      map['modified_date'] = Variable<DateTime>(modifiedDate.value);
    }
    if (area.present) {
      map['area'] = Variable<String>(area.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (mobile.present) {
      map['mobile'] = Variable<String>(mobile.value);
    }
    if (isSelected.present) {
      map['is_selected'] = Variable<bool>(isSelected.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('stbNo: $stbNo, ')
          ..write('modifiedDate: $modifiedDate, ')
          ..write('area: $area, ')
          ..write('notes: $notes, ')
          ..write('mobile: $mobile, ')
          ..write('isSelected: $isSelected')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  final GeneratedDatabase _db;
  final String _alias;
  $UsersTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _stbNoMeta = const VerificationMeta('stbNo');
  GeneratedTextColumn _stbNo;
  @override
  GeneratedTextColumn get stbNo => _stbNo ??= _constructStbNo();
  GeneratedTextColumn _constructStbNo() {
    return GeneratedTextColumn(
      'stb_no',
      $tableName,
      true,
    );
  }

  final VerificationMeta _modifiedDateMeta =
      const VerificationMeta('modifiedDate');
  GeneratedDateTimeColumn _modifiedDate;
  @override
  GeneratedDateTimeColumn get modifiedDate =>
      _modifiedDate ??= _constructModifiedDate();
  GeneratedDateTimeColumn _constructModifiedDate() {
    return GeneratedDateTimeColumn(
      'modified_date',
      $tableName,
      true,
    );
  }

  final VerificationMeta _areaMeta = const VerificationMeta('area');
  GeneratedTextColumn _area;
  @override
  GeneratedTextColumn get area => _area ??= _constructArea();
  GeneratedTextColumn _constructArea() {
    return GeneratedTextColumn(
      'area',
      $tableName,
      true,
    );
  }

  final VerificationMeta _notesMeta = const VerificationMeta('notes');
  GeneratedTextColumn _notes;
  @override
  GeneratedTextColumn get notes => _notes ??= _constructNotes();
  GeneratedTextColumn _constructNotes() {
    return GeneratedTextColumn(
      'notes',
      $tableName,
      true,
    );
  }

  final VerificationMeta _mobileMeta = const VerificationMeta('mobile');
  GeneratedTextColumn _mobile;
  @override
  GeneratedTextColumn get mobile => _mobile ??= _constructMobile();
  GeneratedTextColumn _constructMobile() {
    return GeneratedTextColumn(
      'mobile',
      $tableName,
      true,
    );
  }

  final VerificationMeta _isSelectedMeta = const VerificationMeta('isSelected');
  GeneratedBoolColumn _isSelected;
  @override
  GeneratedBoolColumn get isSelected => _isSelected ??= _constructIsSelected();
  GeneratedBoolColumn _constructIsSelected() {
    return GeneratedBoolColumn('is_selected', $tableName, false,
        defaultValue: Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, name, stbNo, modifiedDate, area, notes, mobile, isSelected];
  @override
  $UsersTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'users';
  @override
  final String actualTableName = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    }
    if (data.containsKey('stb_no')) {
      context.handle(
          _stbNoMeta, stbNo.isAcceptableOrUnknown(data['stb_no'], _stbNoMeta));
    }
    if (data.containsKey('modified_date')) {
      context.handle(
          _modifiedDateMeta,
          modifiedDate.isAcceptableOrUnknown(
              data['modified_date'], _modifiedDateMeta));
    }
    if (data.containsKey('area')) {
      context.handle(
          _areaMeta, area.isAcceptableOrUnknown(data['area'], _areaMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes'], _notesMeta));
    }
    if (data.containsKey('mobile')) {
      context.handle(_mobileMeta,
          mobile.isAcceptableOrUnknown(data['mobile'], _mobileMeta));
    }
    if (data.containsKey('is_selected')) {
      context.handle(
          _isSelectedMeta,
          isSelected.isAcceptableOrUnknown(
              data['is_selected'], _isSelectedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return User.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $UsersTable _users;
  $UsersTable get users => _users ??= $UsersTable(this);
  UsersDao _usersDao;
  UsersDao get usersDao => _usersDao ??= UsersDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [users];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$UsersDaoMixin on DatabaseAccessor<AppDatabase> {
  $UsersTable get users => attachedDatabase.users;
}
