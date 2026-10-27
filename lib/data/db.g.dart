// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// ignore_for_file: type=lint
class $PetsTable extends Pets with TableInfo<$PetsTable, Pet> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _speciesMeta = const VerificationMeta(
    'species',
  );
  @override
  late final GeneratedColumn<String> species = GeneratedColumn<String>(
    'species',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('dog'),
  );
  static const VerificationMeta _breedMeta = const VerificationMeta('breed');
  @override
  late final GeneratedColumn<String> breed = GeneratedColumn<String>(
    'breed',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _birthDateMeta = const VerificationMeta(
    'birthDate',
  );
  @override
  late final GeneratedColumn<DateTime> birthDate = GeneratedColumn<DateTime>(
    'birth_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _chipMeta = const VerificationMeta('chip');
  @override
  late final GeneratedColumn<String> chip = GeneratedColumn<String>(
    'chip',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _vetNameMeta = const VerificationMeta(
    'vetName',
  );
  @override
  late final GeneratedColumn<String> vetName = GeneratedColumn<String>(
    'vet_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _vetPhoneMeta = const VerificationMeta(
    'vetPhone',
  );
  @override
  late final GeneratedColumn<String> vetPhone = GeneratedColumn<String>(
    'vet_phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photoPathMeta = const VerificationMeta(
    'photoPath',
  );
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
    'photo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    remoteId,
    updatedAt,
    dirty,
    id,
    name,
    species,
    breed,
    birthDate,
    chip,
    vetName,
    vetPhone,
    photoPath,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pets';
  @override
  VerificationContext validateIntegrity(
    Insertable<Pet> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('species')) {
      context.handle(
        _speciesMeta,
        species.isAcceptableOrUnknown(data['species']!, _speciesMeta),
      );
    }
    if (data.containsKey('breed')) {
      context.handle(
        _breedMeta,
        breed.isAcceptableOrUnknown(data['breed']!, _breedMeta),
      );
    }
    if (data.containsKey('birth_date')) {
      context.handle(
        _birthDateMeta,
        birthDate.isAcceptableOrUnknown(data['birth_date']!, _birthDateMeta),
      );
    }
    if (data.containsKey('chip')) {
      context.handle(
        _chipMeta,
        chip.isAcceptableOrUnknown(data['chip']!, _chipMeta),
      );
    }
    if (data.containsKey('vet_name')) {
      context.handle(
        _vetNameMeta,
        vetName.isAcceptableOrUnknown(data['vet_name']!, _vetNameMeta),
      );
    }
    if (data.containsKey('vet_phone')) {
      context.handle(
        _vetPhoneMeta,
        vetPhone.isAcceptableOrUnknown(data['vet_phone']!, _vetPhoneMeta),
      );
    }
    if (data.containsKey('photo_path')) {
      context.handle(
        _photoPathMeta,
        photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Pet map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Pet(
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_id'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      ),
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      species: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}species'],
      )!,
      breed: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}breed'],
      ),
      birthDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}birth_date'],
      ),
      chip: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}chip'],
      ),
      vetName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vet_name'],
      ),
      vetPhone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vet_phone'],
      ),
      photoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_path'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $PetsTable createAlias(String alias) {
    return $PetsTable(attachedDatabase, alias);
  }
}

class Pet extends DataClass implements Insertable<Pet> {
  final String? remoteId;
  final int? updatedAt;
  final bool? dirty;
  final int id;
  final String name;
  final String species;
  final String? breed;
  final DateTime? birthDate;
  final String? chip;
  final String? vetName;
  final String? vetPhone;
  final String? photoPath;
  final String? notes;
  const Pet({
    this.remoteId,
    this.updatedAt,
    this.dirty,
    required this.id,
    required this.name,
    required this.species,
    this.breed,
    this.birthDate,
    this.chip,
    this.vetName,
    this.vetPhone,
    this.photoPath,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<int>(updatedAt);
    }
    if (!nullToAbsent || dirty != null) {
      map['dirty'] = Variable<bool>(dirty);
    }
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['species'] = Variable<String>(species);
    if (!nullToAbsent || breed != null) {
      map['breed'] = Variable<String>(breed);
    }
    if (!nullToAbsent || birthDate != null) {
      map['birth_date'] = Variable<DateTime>(birthDate);
    }
    if (!nullToAbsent || chip != null) {
      map['chip'] = Variable<String>(chip);
    }
    if (!nullToAbsent || vetName != null) {
      map['vet_name'] = Variable<String>(vetName);
    }
    if (!nullToAbsent || vetPhone != null) {
      map['vet_phone'] = Variable<String>(vetPhone);
    }
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  PetsCompanion toCompanion(bool nullToAbsent) {
    return PetsCompanion(
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      dirty: dirty == null && nullToAbsent
          ? const Value.absent()
          : Value(dirty),
      id: Value(id),
      name: Value(name),
      species: Value(species),
      breed: breed == null && nullToAbsent
          ? const Value.absent()
          : Value(breed),
      birthDate: birthDate == null && nullToAbsent
          ? const Value.absent()
          : Value(birthDate),
      chip: chip == null && nullToAbsent ? const Value.absent() : Value(chip),
      vetName: vetName == null && nullToAbsent
          ? const Value.absent()
          : Value(vetName),
      vetPhone: vetPhone == null && nullToAbsent
          ? const Value.absent()
          : Value(vetPhone),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory Pet.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Pet(
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      updatedAt: serializer.fromJson<int?>(json['updatedAt']),
      dirty: serializer.fromJson<bool?>(json['dirty']),
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      species: serializer.fromJson<String>(json['species']),
      breed: serializer.fromJson<String?>(json['breed']),
      birthDate: serializer.fromJson<DateTime?>(json['birthDate']),
      chip: serializer.fromJson<String?>(json['chip']),
      vetName: serializer.fromJson<String?>(json['vetName']),
      vetPhone: serializer.fromJson<String?>(json['vetPhone']),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'remoteId': serializer.toJson<String?>(remoteId),
      'updatedAt': serializer.toJson<int?>(updatedAt),
      'dirty': serializer.toJson<bool?>(dirty),
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'species': serializer.toJson<String>(species),
      'breed': serializer.toJson<String?>(breed),
      'birthDate': serializer.toJson<DateTime?>(birthDate),
      'chip': serializer.toJson<String?>(chip),
      'vetName': serializer.toJson<String?>(vetName),
      'vetPhone': serializer.toJson<String?>(vetPhone),
      'photoPath': serializer.toJson<String?>(photoPath),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  Pet copyWith({
    Value<String?> remoteId = const Value.absent(),
    Value<int?> updatedAt = const Value.absent(),
    Value<bool?> dirty = const Value.absent(),
    int? id,
    String? name,
    String? species,
    Value<String?> breed = const Value.absent(),
    Value<DateTime?> birthDate = const Value.absent(),
    Value<String?> chip = const Value.absent(),
    Value<String?> vetName = const Value.absent(),
    Value<String?> vetPhone = const Value.absent(),
    Value<String?> photoPath = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => Pet(
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
    dirty: dirty.present ? dirty.value : this.dirty,
    id: id ?? this.id,
    name: name ?? this.name,
    species: species ?? this.species,
    breed: breed.present ? breed.value : this.breed,
    birthDate: birthDate.present ? birthDate.value : this.birthDate,
    chip: chip.present ? chip.value : this.chip,
    vetName: vetName.present ? vetName.value : this.vetName,
    vetPhone: vetPhone.present ? vetPhone.value : this.vetPhone,
    photoPath: photoPath.present ? photoPath.value : this.photoPath,
    notes: notes.present ? notes.value : this.notes,
  );
  Pet copyWithCompanion(PetsCompanion data) {
    return Pet(
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      species: data.species.present ? data.species.value : this.species,
      breed: data.breed.present ? data.breed.value : this.breed,
      birthDate: data.birthDate.present ? data.birthDate.value : this.birthDate,
      chip: data.chip.present ? data.chip.value : this.chip,
      vetName: data.vetName.present ? data.vetName.value : this.vetName,
      vetPhone: data.vetPhone.present ? data.vetPhone.value : this.vetPhone,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Pet(')
          ..write('remoteId: $remoteId, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('dirty: $dirty, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('species: $species, ')
          ..write('breed: $breed, ')
          ..write('birthDate: $birthDate, ')
          ..write('chip: $chip, ')
          ..write('vetName: $vetName, ')
          ..write('vetPhone: $vetPhone, ')
          ..write('photoPath: $photoPath, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    remoteId,
    updatedAt,
    dirty,
    id,
    name,
    species,
    breed,
    birthDate,
    chip,
    vetName,
    vetPhone,
    photoPath,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Pet &&
          other.remoteId == this.remoteId &&
          other.updatedAt == this.updatedAt &&
          other.dirty == this.dirty &&
          other.id == this.id &&
          other.name == this.name &&
          other.species == this.species &&
          other.breed == this.breed &&
          other.birthDate == this.birthDate &&
          other.chip == this.chip &&
          other.vetName == this.vetName &&
          other.vetPhone == this.vetPhone &&
          other.photoPath == this.photoPath &&
          other.notes == this.notes);
}

class PetsCompanion extends UpdateCompanion<Pet> {
  final Value<String?> remoteId;
  final Value<int?> updatedAt;
  final Value<bool?> dirty;
  final Value<int> id;
  final Value<String> name;
  final Value<String> species;
  final Value<String?> breed;
  final Value<DateTime?> birthDate;
  final Value<String?> chip;
  final Value<String?> vetName;
  final Value<String?> vetPhone;
  final Value<String?> photoPath;
  final Value<String?> notes;
  const PetsCompanion({
    this.remoteId = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.dirty = const Value.absent(),
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.species = const Value.absent(),
    this.breed = const Value.absent(),
    this.birthDate = const Value.absent(),
    this.chip = const Value.absent(),
    this.vetName = const Value.absent(),
    this.vetPhone = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.notes = const Value.absent(),
  });
  PetsCompanion.insert({
    this.remoteId = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.dirty = const Value.absent(),
    this.id = const Value.absent(),
    required String name,
    this.species = const Value.absent(),
    this.breed = const Value.absent(),
    this.birthDate = const Value.absent(),
    this.chip = const Value.absent(),
    this.vetName = const Value.absent(),
    this.vetPhone = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.notes = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Pet> custom({
    Expression<String>? remoteId,
    Expression<int>? updatedAt,
    Expression<bool>? dirty,
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? species,
    Expression<String>? breed,
    Expression<DateTime>? birthDate,
    Expression<String>? chip,
    Expression<String>? vetName,
    Expression<String>? vetPhone,
    Expression<String>? photoPath,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (remoteId != null) 'remote_id': remoteId,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (dirty != null) 'dirty': dirty,
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (species != null) 'species': species,
      if (breed != null) 'breed': breed,
      if (birthDate != null) 'birth_date': birthDate,
      if (chip != null) 'chip': chip,
      if (vetName != null) 'vet_name': vetName,
      if (vetPhone != null) 'vet_phone': vetPhone,
      if (photoPath != null) 'photo_path': photoPath,
      if (notes != null) 'notes': notes,
    });
  }

  PetsCompanion copyWith({
    Value<String?>? remoteId,
    Value<int?>? updatedAt,
    Value<bool?>? dirty,
    Value<int>? id,
    Value<String>? name,
    Value<String>? species,
    Value<String?>? breed,
    Value<DateTime?>? birthDate,
    Value<String?>? chip,
    Value<String?>? vetName,
    Value<String?>? vetPhone,
    Value<String?>? photoPath,
    Value<String?>? notes,
  }) {
    return PetsCompanion(
      remoteId: remoteId ?? this.remoteId,
      updatedAt: updatedAt ?? this.updatedAt,
      dirty: dirty ?? this.dirty,
      id: id ?? this.id,
      name: name ?? this.name,
      species: species ?? this.species,
      breed: breed ?? this.breed,
      birthDate: birthDate ?? this.birthDate,
      chip: chip ?? this.chip,
      vetName: vetName ?? this.vetName,
      vetPhone: vetPhone ?? this.vetPhone,
      photoPath: photoPath ?? this.photoPath,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (species.present) {
      map['species'] = Variable<String>(species.value);
    }
    if (breed.present) {
      map['breed'] = Variable<String>(breed.value);
    }
    if (birthDate.present) {
      map['birth_date'] = Variable<DateTime>(birthDate.value);
    }
    if (chip.present) {
      map['chip'] = Variable<String>(chip.value);
    }
    if (vetName.present) {
      map['vet_name'] = Variable<String>(vetName.value);
    }
    if (vetPhone.present) {
      map['vet_phone'] = Variable<String>(vetPhone.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PetsCompanion(')
          ..write('remoteId: $remoteId, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('dirty: $dirty, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('species: $species, ')
          ..write('breed: $breed, ')
          ..write('birthDate: $birthDate, ')
          ..write('chip: $chip, ')
          ..write('vetName: $vetName, ')
          ..write('vetPhone: $vetPhone, ')
          ..write('photoPath: $photoPath, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $HealthRecordsTable extends HealthRecords
    with TableInfo<$HealthRecordsTable, HealthRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HealthRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _petIdMeta = const VerificationMeta('petId');
  @override
  late final GeneratedColumn<int> petId = GeneratedColumn<int>(
    'pet_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pets (id) ON DELETE CASCADE',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<RecordType, int> type =
      GeneratedColumn<int>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<RecordType>($HealthRecordsTable.$convertertype);
  static const VerificationMeta _productMeta = const VerificationMeta(
    'product',
  );
  @override
  late final GeneratedColumn<String> product = GeneratedColumn<String>(
    'product',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nextDueMeta = const VerificationMeta(
    'nextDue',
  );
  @override
  late final GeneratedColumn<DateTime> nextDue = GeneratedColumn<DateTime>(
    'next_due',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _remindDaysBeforeMeta = const VerificationMeta(
    'remindDaysBefore',
  );
  @override
  late final GeneratedColumn<int> remindDaysBefore = GeneratedColumn<int>(
    'remind_days_before',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(7),
  );
  @override
  List<GeneratedColumn> get $columns => [
    remoteId,
    updatedAt,
    dirty,
    id,
    petId,
    type,
    product,
    date,
    nextDue,
    remindDaysBefore,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'health_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<HealthRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('pet_id')) {
      context.handle(
        _petIdMeta,
        petId.isAcceptableOrUnknown(data['pet_id']!, _petIdMeta),
      );
    } else if (isInserting) {
      context.missing(_petIdMeta);
    }
    if (data.containsKey('product')) {
      context.handle(
        _productMeta,
        product.isAcceptableOrUnknown(data['product']!, _productMeta),
      );
    } else if (isInserting) {
      context.missing(_productMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('next_due')) {
      context.handle(
        _nextDueMeta,
        nextDue.isAcceptableOrUnknown(data['next_due']!, _nextDueMeta),
      );
    }
    if (data.containsKey('remind_days_before')) {
      context.handle(
        _remindDaysBeforeMeta,
        remindDaysBefore.isAcceptableOrUnknown(
          data['remind_days_before']!,
          _remindDaysBeforeMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HealthRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HealthRecord(
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_id'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      ),
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      petId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pet_id'],
      )!,
      type: $HealthRecordsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}type'],
        )!,
      ),
      product: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      nextDue: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_due'],
      ),
      remindDaysBefore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}remind_days_before'],
      )!,
    );
  }

  @override
  $HealthRecordsTable createAlias(String alias) {
    return $HealthRecordsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<RecordType, int, int> $convertertype =
      const EnumIndexConverter<RecordType>(RecordType.values);
}

class HealthRecord extends DataClass implements Insertable<HealthRecord> {
  final String? remoteId;
  final int? updatedAt;
  final bool? dirty;
  final int id;
  final int petId;
  final RecordType type;
  final String product;
  final DateTime date;
  final DateTime? nextDue;
  final int remindDaysBefore;
  const HealthRecord({
    this.remoteId,
    this.updatedAt,
    this.dirty,
    required this.id,
    required this.petId,
    required this.type,
    required this.product,
    required this.date,
    this.nextDue,
    required this.remindDaysBefore,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<int>(updatedAt);
    }
    if (!nullToAbsent || dirty != null) {
      map['dirty'] = Variable<bool>(dirty);
    }
    map['id'] = Variable<int>(id);
    map['pet_id'] = Variable<int>(petId);
    {
      map['type'] = Variable<int>(
        $HealthRecordsTable.$convertertype.toSql(type),
      );
    }
    map['product'] = Variable<String>(product);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || nextDue != null) {
      map['next_due'] = Variable<DateTime>(nextDue);
    }
    map['remind_days_before'] = Variable<int>(remindDaysBefore);
    return map;
  }

  HealthRecordsCompanion toCompanion(bool nullToAbsent) {
    return HealthRecordsCompanion(
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      dirty: dirty == null && nullToAbsent
          ? const Value.absent()
          : Value(dirty),
      id: Value(id),
      petId: Value(petId),
      type: Value(type),
      product: Value(product),
      date: Value(date),
      nextDue: nextDue == null && nullToAbsent
          ? const Value.absent()
          : Value(nextDue),
      remindDaysBefore: Value(remindDaysBefore),
    );
  }

  factory HealthRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HealthRecord(
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      updatedAt: serializer.fromJson<int?>(json['updatedAt']),
      dirty: serializer.fromJson<bool?>(json['dirty']),
      id: serializer.fromJson<int>(json['id']),
      petId: serializer.fromJson<int>(json['petId']),
      type: $HealthRecordsTable.$convertertype.fromJson(
        serializer.fromJson<int>(json['type']),
      ),
      product: serializer.fromJson<String>(json['product']),
      date: serializer.fromJson<DateTime>(json['date']),
      nextDue: serializer.fromJson<DateTime?>(json['nextDue']),
      remindDaysBefore: serializer.fromJson<int>(json['remindDaysBefore']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'remoteId': serializer.toJson<String?>(remoteId),
      'updatedAt': serializer.toJson<int?>(updatedAt),
      'dirty': serializer.toJson<bool?>(dirty),
      'id': serializer.toJson<int>(id),
      'petId': serializer.toJson<int>(petId),
      'type': serializer.toJson<int>(
        $HealthRecordsTable.$convertertype.toJson(type),
      ),
      'product': serializer.toJson<String>(product),
      'date': serializer.toJson<DateTime>(date),
      'nextDue': serializer.toJson<DateTime?>(nextDue),
      'remindDaysBefore': serializer.toJson<int>(remindDaysBefore),
    };
  }

  HealthRecord copyWith({
    Value<String?> remoteId = const Value.absent(),
    Value<int?> updatedAt = const Value.absent(),
    Value<bool?> dirty = const Value.absent(),
    int? id,
    int? petId,
    RecordType? type,
    String? product,
    DateTime? date,
    Value<DateTime?> nextDue = const Value.absent(),
    int? remindDaysBefore,
  }) => HealthRecord(
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
    dirty: dirty.present ? dirty.value : this.dirty,
    id: id ?? this.id,
    petId: petId ?? this.petId,
    type: type ?? this.type,
    product: product ?? this.product,
    date: date ?? this.date,
    nextDue: nextDue.present ? nextDue.value : this.nextDue,
    remindDaysBefore: remindDaysBefore ?? this.remindDaysBefore,
  );
  HealthRecord copyWithCompanion(HealthRecordsCompanion data) {
    return HealthRecord(
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      id: data.id.present ? data.id.value : this.id,
      petId: data.petId.present ? data.petId.value : this.petId,
      type: data.type.present ? data.type.value : this.type,
      product: data.product.present ? data.product.value : this.product,
      date: data.date.present ? data.date.value : this.date,
      nextDue: data.nextDue.present ? data.nextDue.value : this.nextDue,
      remindDaysBefore: data.remindDaysBefore.present
          ? data.remindDaysBefore.value
          : this.remindDaysBefore,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HealthRecord(')
          ..write('remoteId: $remoteId, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('dirty: $dirty, ')
          ..write('id: $id, ')
          ..write('petId: $petId, ')
          ..write('type: $type, ')
          ..write('product: $product, ')
          ..write('date: $date, ')
          ..write('nextDue: $nextDue, ')
          ..write('remindDaysBefore: $remindDaysBefore')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    remoteId,
    updatedAt,
    dirty,
    id,
    petId,
    type,
    product,
    date,
    nextDue,
    remindDaysBefore,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HealthRecord &&
          other.remoteId == this.remoteId &&
          other.updatedAt == this.updatedAt &&
          other.dirty == this.dirty &&
          other.id == this.id &&
          other.petId == this.petId &&
          other.type == this.type &&
          other.product == this.product &&
          other.date == this.date &&
          other.nextDue == this.nextDue &&
          other.remindDaysBefore == this.remindDaysBefore);
}

class HealthRecordsCompanion extends UpdateCompanion<HealthRecord> {
  final Value<String?> remoteId;
  final Value<int?> updatedAt;
  final Value<bool?> dirty;
  final Value<int> id;
  final Value<int> petId;
  final Value<RecordType> type;
  final Value<String> product;
  final Value<DateTime> date;
  final Value<DateTime?> nextDue;
  final Value<int> remindDaysBefore;
  const HealthRecordsCompanion({
    this.remoteId = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.dirty = const Value.absent(),
    this.id = const Value.absent(),
    this.petId = const Value.absent(),
    this.type = const Value.absent(),
    this.product = const Value.absent(),
    this.date = const Value.absent(),
    this.nextDue = const Value.absent(),
    this.remindDaysBefore = const Value.absent(),
  });
  HealthRecordsCompanion.insert({
    this.remoteId = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.dirty = const Value.absent(),
    this.id = const Value.absent(),
    required int petId,
    required RecordType type,
    required String product,
    required DateTime date,
    this.nextDue = const Value.absent(),
    this.remindDaysBefore = const Value.absent(),
  }) : petId = Value(petId),
       type = Value(type),
       product = Value(product),
       date = Value(date);
  static Insertable<HealthRecord> custom({
    Expression<String>? remoteId,
    Expression<int>? updatedAt,
    Expression<bool>? dirty,
    Expression<int>? id,
    Expression<int>? petId,
    Expression<int>? type,
    Expression<String>? product,
    Expression<DateTime>? date,
    Expression<DateTime>? nextDue,
    Expression<int>? remindDaysBefore,
  }) {
    return RawValuesInsertable({
      if (remoteId != null) 'remote_id': remoteId,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (dirty != null) 'dirty': dirty,
      if (id != null) 'id': id,
      if (petId != null) 'pet_id': petId,
      if (type != null) 'type': type,
      if (product != null) 'product': product,
      if (date != null) 'date': date,
      if (nextDue != null) 'next_due': nextDue,
      if (remindDaysBefore != null) 'remind_days_before': remindDaysBefore,
    });
  }

  HealthRecordsCompanion copyWith({
    Value<String?>? remoteId,
    Value<int?>? updatedAt,
    Value<bool?>? dirty,
    Value<int>? id,
    Value<int>? petId,
    Value<RecordType>? type,
    Value<String>? product,
    Value<DateTime>? date,
    Value<DateTime?>? nextDue,
    Value<int>? remindDaysBefore,
  }) {
    return HealthRecordsCompanion(
      remoteId: remoteId ?? this.remoteId,
      updatedAt: updatedAt ?? this.updatedAt,
      dirty: dirty ?? this.dirty,
      id: id ?? this.id,
      petId: petId ?? this.petId,
      type: type ?? this.type,
      product: product ?? this.product,
      date: date ?? this.date,
      nextDue: nextDue ?? this.nextDue,
      remindDaysBefore: remindDaysBefore ?? this.remindDaysBefore,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (petId.present) {
      map['pet_id'] = Variable<int>(petId.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(
        $HealthRecordsTable.$convertertype.toSql(type.value),
      );
    }
    if (product.present) {
      map['product'] = Variable<String>(product.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (nextDue.present) {
      map['next_due'] = Variable<DateTime>(nextDue.value);
    }
    if (remindDaysBefore.present) {
      map['remind_days_before'] = Variable<int>(remindDaysBefore.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HealthRecordsCompanion(')
          ..write('remoteId: $remoteId, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('dirty: $dirty, ')
          ..write('id: $id, ')
          ..write('petId: $petId, ')
          ..write('type: $type, ')
          ..write('product: $product, ')
          ..write('date: $date, ')
          ..write('nextDue: $nextDue, ')
          ..write('remindDaysBefore: $remindDaysBefore')
          ..write(')'))
        .toString();
  }
}

class $WeightsTable extends Weights with TableInfo<$WeightsTable, Weight> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeightsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _petIdMeta = const VerificationMeta('petId');
  @override
  late final GeneratedColumn<int> petId = GeneratedColumn<int>(
    'pet_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pets (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kgMeta = const VerificationMeta('kg');
  @override
  late final GeneratedColumn<double> kg = GeneratedColumn<double>(
    'kg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    remoteId,
    updatedAt,
    dirty,
    id,
    petId,
    date,
    kg,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weights';
  @override
  VerificationContext validateIntegrity(
    Insertable<Weight> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('pet_id')) {
      context.handle(
        _petIdMeta,
        petId.isAcceptableOrUnknown(data['pet_id']!, _petIdMeta),
      );
    } else if (isInserting) {
      context.missing(_petIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('kg')) {
      context.handle(_kgMeta, kg.isAcceptableOrUnknown(data['kg']!, _kgMeta));
    } else if (isInserting) {
      context.missing(_kgMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Weight map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Weight(
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_id'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      ),
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      petId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pet_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      kg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}kg'],
      )!,
    );
  }

  @override
  $WeightsTable createAlias(String alias) {
    return $WeightsTable(attachedDatabase, alias);
  }
}

class Weight extends DataClass implements Insertable<Weight> {
  final String? remoteId;
  final int? updatedAt;
  final bool? dirty;
  final int id;
  final int petId;
  final DateTime date;
  final double kg;
  const Weight({
    this.remoteId,
    this.updatedAt,
    this.dirty,
    required this.id,
    required this.petId,
    required this.date,
    required this.kg,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<int>(updatedAt);
    }
    if (!nullToAbsent || dirty != null) {
      map['dirty'] = Variable<bool>(dirty);
    }
    map['id'] = Variable<int>(id);
    map['pet_id'] = Variable<int>(petId);
    map['date'] = Variable<DateTime>(date);
    map['kg'] = Variable<double>(kg);
    return map;
  }

  WeightsCompanion toCompanion(bool nullToAbsent) {
    return WeightsCompanion(
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      dirty: dirty == null && nullToAbsent
          ? const Value.absent()
          : Value(dirty),
      id: Value(id),
      petId: Value(petId),
      date: Value(date),
      kg: Value(kg),
    );
  }

  factory Weight.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Weight(
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      updatedAt: serializer.fromJson<int?>(json['updatedAt']),
      dirty: serializer.fromJson<bool?>(json['dirty']),
      id: serializer.fromJson<int>(json['id']),
      petId: serializer.fromJson<int>(json['petId']),
      date: serializer.fromJson<DateTime>(json['date']),
      kg: serializer.fromJson<double>(json['kg']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'remoteId': serializer.toJson<String?>(remoteId),
      'updatedAt': serializer.toJson<int?>(updatedAt),
      'dirty': serializer.toJson<bool?>(dirty),
      'id': serializer.toJson<int>(id),
      'petId': serializer.toJson<int>(petId),
      'date': serializer.toJson<DateTime>(date),
      'kg': serializer.toJson<double>(kg),
    };
  }

  Weight copyWith({
    Value<String?> remoteId = const Value.absent(),
    Value<int?> updatedAt = const Value.absent(),
    Value<bool?> dirty = const Value.absent(),
    int? id,
    int? petId,
    DateTime? date,
    double? kg,
  }) => Weight(
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
    dirty: dirty.present ? dirty.value : this.dirty,
    id: id ?? this.id,
    petId: petId ?? this.petId,
    date: date ?? this.date,
    kg: kg ?? this.kg,
  );
  Weight copyWithCompanion(WeightsCompanion data) {
    return Weight(
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      id: data.id.present ? data.id.value : this.id,
      petId: data.petId.present ? data.petId.value : this.petId,
      date: data.date.present ? data.date.value : this.date,
      kg: data.kg.present ? data.kg.value : this.kg,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Weight(')
          ..write('remoteId: $remoteId, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('dirty: $dirty, ')
          ..write('id: $id, ')
          ..write('petId: $petId, ')
          ..write('date: $date, ')
          ..write('kg: $kg')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(remoteId, updatedAt, dirty, id, petId, date, kg);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Weight &&
          other.remoteId == this.remoteId &&
          other.updatedAt == this.updatedAt &&
          other.dirty == this.dirty &&
          other.id == this.id &&
          other.petId == this.petId &&
          other.date == this.date &&
          other.kg == this.kg);
}

class WeightsCompanion extends UpdateCompanion<Weight> {
  final Value<String?> remoteId;
  final Value<int?> updatedAt;
  final Value<bool?> dirty;
  final Value<int> id;
  final Value<int> petId;
  final Value<DateTime> date;
  final Value<double> kg;
  const WeightsCompanion({
    this.remoteId = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.dirty = const Value.absent(),
    this.id = const Value.absent(),
    this.petId = const Value.absent(),
    this.date = const Value.absent(),
    this.kg = const Value.absent(),
  });
  WeightsCompanion.insert({
    this.remoteId = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.dirty = const Value.absent(),
    this.id = const Value.absent(),
    required int petId,
    required DateTime date,
    required double kg,
  }) : petId = Value(petId),
       date = Value(date),
       kg = Value(kg);
  static Insertable<Weight> custom({
    Expression<String>? remoteId,
    Expression<int>? updatedAt,
    Expression<bool>? dirty,
    Expression<int>? id,
    Expression<int>? petId,
    Expression<DateTime>? date,
    Expression<double>? kg,
  }) {
    return RawValuesInsertable({
      if (remoteId != null) 'remote_id': remoteId,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (dirty != null) 'dirty': dirty,
      if (id != null) 'id': id,
      if (petId != null) 'pet_id': petId,
      if (date != null) 'date': date,
      if (kg != null) 'kg': kg,
    });
  }

  WeightsCompanion copyWith({
    Value<String?>? remoteId,
    Value<int?>? updatedAt,
    Value<bool?>? dirty,
    Value<int>? id,
    Value<int>? petId,
    Value<DateTime>? date,
    Value<double>? kg,
  }) {
    return WeightsCompanion(
      remoteId: remoteId ?? this.remoteId,
      updatedAt: updatedAt ?? this.updatedAt,
      dirty: dirty ?? this.dirty,
      id: id ?? this.id,
      petId: petId ?? this.petId,
      date: date ?? this.date,
      kg: kg ?? this.kg,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (petId.present) {
      map['pet_id'] = Variable<int>(petId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (kg.present) {
      map['kg'] = Variable<double>(kg.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeightsCompanion(')
          ..write('remoteId: $remoteId, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('dirty: $dirty, ')
          ..write('id: $id, ')
          ..write('petId: $petId, ')
          ..write('date: $date, ')
          ..write('kg: $kg')
          ..write(')'))
        .toString();
  }
}

class $AppointmentsTable extends Appointments
    with TableInfo<$AppointmentsTable, Appointment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppointmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dirtyMeta = const VerificationMeta('dirty');
  @override
  late final GeneratedColumn<bool> dirty = GeneratedColumn<bool>(
    'dirty',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dirty" IN (0, 1))',
    ),
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _petIdMeta = const VerificationMeta('petId');
  @override
  late final GeneratedColumn<int> petId = GeneratedColumn<int>(
    'pet_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pets (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _atMeta = const VerificationMeta('at');
  @override
  late final GeneratedColumn<DateTime> at = GeneratedColumn<DateTime>(
    'at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _placeMeta = const VerificationMeta('place');
  @override
  late final GeneratedColumn<String> place = GeneratedColumn<String>(
    'place',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _remindDaysBeforeMeta = const VerificationMeta(
    'remindDaysBefore',
  );
  @override
  late final GeneratedColumn<int> remindDaysBefore = GeneratedColumn<int>(
    'remind_days_before',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  @override
  List<GeneratedColumn> get $columns => [
    remoteId,
    updatedAt,
    dirty,
    id,
    petId,
    at,
    title,
    place,
    remindDaysBefore,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'appointments';
  @override
  VerificationContext validateIntegrity(
    Insertable<Appointment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('dirty')) {
      context.handle(
        _dirtyMeta,
        dirty.isAcceptableOrUnknown(data['dirty']!, _dirtyMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('pet_id')) {
      context.handle(
        _petIdMeta,
        petId.isAcceptableOrUnknown(data['pet_id']!, _petIdMeta),
      );
    } else if (isInserting) {
      context.missing(_petIdMeta);
    }
    if (data.containsKey('at')) {
      context.handle(_atMeta, at.isAcceptableOrUnknown(data['at']!, _atMeta));
    } else if (isInserting) {
      context.missing(_atMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('place')) {
      context.handle(
        _placeMeta,
        place.isAcceptableOrUnknown(data['place']!, _placeMeta),
      );
    }
    if (data.containsKey('remind_days_before')) {
      context.handle(
        _remindDaysBeforeMeta,
        remindDaysBefore.isAcceptableOrUnknown(
          data['remind_days_before']!,
          _remindDaysBeforeMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Appointment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Appointment(
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_id'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      ),
      dirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dirty'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      petId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pet_id'],
      )!,
      at: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}at'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      place: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}place'],
      ),
      remindDaysBefore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}remind_days_before'],
      )!,
    );
  }

  @override
  $AppointmentsTable createAlias(String alias) {
    return $AppointmentsTable(attachedDatabase, alias);
  }
}

class Appointment extends DataClass implements Insertable<Appointment> {
  final String? remoteId;
  final int? updatedAt;
  final bool? dirty;
  final int id;
  final int petId;
  final DateTime at;
  final String title;
  final String? place;
  final int remindDaysBefore;
  const Appointment({
    this.remoteId,
    this.updatedAt,
    this.dirty,
    required this.id,
    required this.petId,
    required this.at,
    required this.title,
    this.place,
    required this.remindDaysBefore,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<int>(updatedAt);
    }
    if (!nullToAbsent || dirty != null) {
      map['dirty'] = Variable<bool>(dirty);
    }
    map['id'] = Variable<int>(id);
    map['pet_id'] = Variable<int>(petId);
    map['at'] = Variable<DateTime>(at);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || place != null) {
      map['place'] = Variable<String>(place);
    }
    map['remind_days_before'] = Variable<int>(remindDaysBefore);
    return map;
  }

  AppointmentsCompanion toCompanion(bool nullToAbsent) {
    return AppointmentsCompanion(
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      dirty: dirty == null && nullToAbsent
          ? const Value.absent()
          : Value(dirty),
      id: Value(id),
      petId: Value(petId),
      at: Value(at),
      title: Value(title),
      place: place == null && nullToAbsent
          ? const Value.absent()
          : Value(place),
      remindDaysBefore: Value(remindDaysBefore),
    );
  }

  factory Appointment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Appointment(
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      updatedAt: serializer.fromJson<int?>(json['updatedAt']),
      dirty: serializer.fromJson<bool?>(json['dirty']),
      id: serializer.fromJson<int>(json['id']),
      petId: serializer.fromJson<int>(json['petId']),
      at: serializer.fromJson<DateTime>(json['at']),
      title: serializer.fromJson<String>(json['title']),
      place: serializer.fromJson<String?>(json['place']),
      remindDaysBefore: serializer.fromJson<int>(json['remindDaysBefore']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'remoteId': serializer.toJson<String?>(remoteId),
      'updatedAt': serializer.toJson<int?>(updatedAt),
      'dirty': serializer.toJson<bool?>(dirty),
      'id': serializer.toJson<int>(id),
      'petId': serializer.toJson<int>(petId),
      'at': serializer.toJson<DateTime>(at),
      'title': serializer.toJson<String>(title),
      'place': serializer.toJson<String?>(place),
      'remindDaysBefore': serializer.toJson<int>(remindDaysBefore),
    };
  }

  Appointment copyWith({
    Value<String?> remoteId = const Value.absent(),
    Value<int?> updatedAt = const Value.absent(),
    Value<bool?> dirty = const Value.absent(),
    int? id,
    int? petId,
    DateTime? at,
    String? title,
    Value<String?> place = const Value.absent(),
    int? remindDaysBefore,
  }) => Appointment(
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
    dirty: dirty.present ? dirty.value : this.dirty,
    id: id ?? this.id,
    petId: petId ?? this.petId,
    at: at ?? this.at,
    title: title ?? this.title,
    place: place.present ? place.value : this.place,
    remindDaysBefore: remindDaysBefore ?? this.remindDaysBefore,
  );
  Appointment copyWithCompanion(AppointmentsCompanion data) {
    return Appointment(
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      dirty: data.dirty.present ? data.dirty.value : this.dirty,
      id: data.id.present ? data.id.value : this.id,
      petId: data.petId.present ? data.petId.value : this.petId,
      at: data.at.present ? data.at.value : this.at,
      title: data.title.present ? data.title.value : this.title,
      place: data.place.present ? data.place.value : this.place,
      remindDaysBefore: data.remindDaysBefore.present
          ? data.remindDaysBefore.value
          : this.remindDaysBefore,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Appointment(')
          ..write('remoteId: $remoteId, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('dirty: $dirty, ')
          ..write('id: $id, ')
          ..write('petId: $petId, ')
          ..write('at: $at, ')
          ..write('title: $title, ')
          ..write('place: $place, ')
          ..write('remindDaysBefore: $remindDaysBefore')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    remoteId,
    updatedAt,
    dirty,
    id,
    petId,
    at,
    title,
    place,
    remindDaysBefore,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Appointment &&
          other.remoteId == this.remoteId &&
          other.updatedAt == this.updatedAt &&
          other.dirty == this.dirty &&
          other.id == this.id &&
          other.petId == this.petId &&
          other.at == this.at &&
          other.title == this.title &&
          other.place == this.place &&
          other.remindDaysBefore == this.remindDaysBefore);
}

class AppointmentsCompanion extends UpdateCompanion<Appointment> {
  final Value<String?> remoteId;
  final Value<int?> updatedAt;
  final Value<bool?> dirty;
  final Value<int> id;
  final Value<int> petId;
  final Value<DateTime> at;
  final Value<String> title;
  final Value<String?> place;
  final Value<int> remindDaysBefore;
  const AppointmentsCompanion({
    this.remoteId = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.dirty = const Value.absent(),
    this.id = const Value.absent(),
    this.petId = const Value.absent(),
    this.at = const Value.absent(),
    this.title = const Value.absent(),
    this.place = const Value.absent(),
    this.remindDaysBefore = const Value.absent(),
  });
  AppointmentsCompanion.insert({
    this.remoteId = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.dirty = const Value.absent(),
    this.id = const Value.absent(),
    required int petId,
    required DateTime at,
    required String title,
    this.place = const Value.absent(),
    this.remindDaysBefore = const Value.absent(),
  }) : petId = Value(petId),
       at = Value(at),
       title = Value(title);
  static Insertable<Appointment> custom({
    Expression<String>? remoteId,
    Expression<int>? updatedAt,
    Expression<bool>? dirty,
    Expression<int>? id,
    Expression<int>? petId,
    Expression<DateTime>? at,
    Expression<String>? title,
    Expression<String>? place,
    Expression<int>? remindDaysBefore,
  }) {
    return RawValuesInsertable({
      if (remoteId != null) 'remote_id': remoteId,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (dirty != null) 'dirty': dirty,
      if (id != null) 'id': id,
      if (petId != null) 'pet_id': petId,
      if (at != null) 'at': at,
      if (title != null) 'title': title,
      if (place != null) 'place': place,
      if (remindDaysBefore != null) 'remind_days_before': remindDaysBefore,
    });
  }

  AppointmentsCompanion copyWith({
    Value<String?>? remoteId,
    Value<int?>? updatedAt,
    Value<bool?>? dirty,
    Value<int>? id,
    Value<int>? petId,
    Value<DateTime>? at,
    Value<String>? title,
    Value<String?>? place,
    Value<int>? remindDaysBefore,
  }) {
    return AppointmentsCompanion(
      remoteId: remoteId ?? this.remoteId,
      updatedAt: updatedAt ?? this.updatedAt,
      dirty: dirty ?? this.dirty,
      id: id ?? this.id,
      petId: petId ?? this.petId,
      at: at ?? this.at,
      title: title ?? this.title,
      place: place ?? this.place,
      remindDaysBefore: remindDaysBefore ?? this.remindDaysBefore,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (dirty.present) {
      map['dirty'] = Variable<bool>(dirty.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (petId.present) {
      map['pet_id'] = Variable<int>(petId.value);
    }
    if (at.present) {
      map['at'] = Variable<DateTime>(at.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (place.present) {
      map['place'] = Variable<String>(place.value);
    }
    if (remindDaysBefore.present) {
      map['remind_days_before'] = Variable<int>(remindDaysBefore.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppointmentsCompanion(')
          ..write('remoteId: $remoteId, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('dirty: $dirty, ')
          ..write('id: $id, ')
          ..write('petId: $petId, ')
          ..write('at: $at, ')
          ..write('title: $title, ')
          ..write('place: $place, ')
          ..write('remindDaysBefore: $remindDaysBefore')
          ..write(')'))
        .toString();
  }
}

class $SyncDeletesTable extends SyncDeletes
    with TableInfo<$SyncDeletesTable, SyncDelete> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncDeletesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _petRemoteIdMeta = const VerificationMeta(
    'petRemoteId',
  );
  @override
  late final GeneratedColumn<String> petRemoteId = GeneratedColumn<String>(
    'pet_remote_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
    'remote_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, kind, petRemoteId, remoteId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_deletes';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncDelete> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('pet_remote_id')) {
      context.handle(
        _petRemoteIdMeta,
        petRemoteId.isAcceptableOrUnknown(
          data['pet_remote_id']!,
          _petRemoteIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_petRemoteIdMeta);
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    } else if (isInserting) {
      context.missing(_remoteIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncDelete map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncDelete(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      petRemoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pet_remote_id'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_id'],
      )!,
    );
  }

  @override
  $SyncDeletesTable createAlias(String alias) {
    return $SyncDeletesTable(attachedDatabase, alias);
  }
}

class SyncDelete extends DataClass implements Insertable<SyncDelete> {
  final int id;
  final String kind;
  final String petRemoteId;
  final String remoteId;
  const SyncDelete({
    required this.id,
    required this.kind,
    required this.petRemoteId,
    required this.remoteId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['kind'] = Variable<String>(kind);
    map['pet_remote_id'] = Variable<String>(petRemoteId);
    map['remote_id'] = Variable<String>(remoteId);
    return map;
  }

  SyncDeletesCompanion toCompanion(bool nullToAbsent) {
    return SyncDeletesCompanion(
      id: Value(id),
      kind: Value(kind),
      petRemoteId: Value(petRemoteId),
      remoteId: Value(remoteId),
    );
  }

  factory SyncDelete.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncDelete(
      id: serializer.fromJson<int>(json['id']),
      kind: serializer.fromJson<String>(json['kind']),
      petRemoteId: serializer.fromJson<String>(json['petRemoteId']),
      remoteId: serializer.fromJson<String>(json['remoteId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'kind': serializer.toJson<String>(kind),
      'petRemoteId': serializer.toJson<String>(petRemoteId),
      'remoteId': serializer.toJson<String>(remoteId),
    };
  }

  SyncDelete copyWith({
    int? id,
    String? kind,
    String? petRemoteId,
    String? remoteId,
  }) => SyncDelete(
    id: id ?? this.id,
    kind: kind ?? this.kind,
    petRemoteId: petRemoteId ?? this.petRemoteId,
    remoteId: remoteId ?? this.remoteId,
  );
  SyncDelete copyWithCompanion(SyncDeletesCompanion data) {
    return SyncDelete(
      id: data.id.present ? data.id.value : this.id,
      kind: data.kind.present ? data.kind.value : this.kind,
      petRemoteId: data.petRemoteId.present
          ? data.petRemoteId.value
          : this.petRemoteId,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncDelete(')
          ..write('id: $id, ')
          ..write('kind: $kind, ')
          ..write('petRemoteId: $petRemoteId, ')
          ..write('remoteId: $remoteId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, kind, petRemoteId, remoteId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncDelete &&
          other.id == this.id &&
          other.kind == this.kind &&
          other.petRemoteId == this.petRemoteId &&
          other.remoteId == this.remoteId);
}

class SyncDeletesCompanion extends UpdateCompanion<SyncDelete> {
  final Value<int> id;
  final Value<String> kind;
  final Value<String> petRemoteId;
  final Value<String> remoteId;
  const SyncDeletesCompanion({
    this.id = const Value.absent(),
    this.kind = const Value.absent(),
    this.petRemoteId = const Value.absent(),
    this.remoteId = const Value.absent(),
  });
  SyncDeletesCompanion.insert({
    this.id = const Value.absent(),
    required String kind,
    required String petRemoteId,
    required String remoteId,
  }) : kind = Value(kind),
       petRemoteId = Value(petRemoteId),
       remoteId = Value(remoteId);
  static Insertable<SyncDelete> custom({
    Expression<int>? id,
    Expression<String>? kind,
    Expression<String>? petRemoteId,
    Expression<String>? remoteId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (kind != null) 'kind': kind,
      if (petRemoteId != null) 'pet_remote_id': petRemoteId,
      if (remoteId != null) 'remote_id': remoteId,
    });
  }

  SyncDeletesCompanion copyWith({
    Value<int>? id,
    Value<String>? kind,
    Value<String>? petRemoteId,
    Value<String>? remoteId,
  }) {
    return SyncDeletesCompanion(
      id: id ?? this.id,
      kind: kind ?? this.kind,
      petRemoteId: petRemoteId ?? this.petRemoteId,
      remoteId: remoteId ?? this.remoteId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (petRemoteId.present) {
      map['pet_remote_id'] = Variable<String>(petRemoteId.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncDeletesCompanion(')
          ..write('id: $id, ')
          ..write('kind: $kind, ')
          ..write('petRemoteId: $petRemoteId, ')
          ..write('remoteId: $remoteId')
          ..write(')'))
        .toString();
  }
}

class $SyncFlagsTable extends SyncFlags
    with TableInfo<$SyncFlagsTable, SyncFlag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncFlagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _applyingMeta = const VerificationMeta(
    'applying',
  );
  @override
  late final GeneratedColumn<int> applying = GeneratedColumn<int>(
    'applying',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [applying];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_flags';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncFlag> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('applying')) {
      context.handle(
        _applyingMeta,
        applying.isAcceptableOrUnknown(data['applying']!, _applyingMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  SyncFlag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncFlag(
      applying: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}applying'],
      )!,
    );
  }

  @override
  $SyncFlagsTable createAlias(String alias) {
    return $SyncFlagsTable(attachedDatabase, alias);
  }
}

class SyncFlag extends DataClass implements Insertable<SyncFlag> {
  final int applying;
  const SyncFlag({required this.applying});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['applying'] = Variable<int>(applying);
    return map;
  }

  SyncFlagsCompanion toCompanion(bool nullToAbsent) {
    return SyncFlagsCompanion(applying: Value(applying));
  }

  factory SyncFlag.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncFlag(applying: serializer.fromJson<int>(json['applying']));
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{'applying': serializer.toJson<int>(applying)};
  }

  SyncFlag copyWith({int? applying}) =>
      SyncFlag(applying: applying ?? this.applying);
  SyncFlag copyWithCompanion(SyncFlagsCompanion data) {
    return SyncFlag(
      applying: data.applying.present ? data.applying.value : this.applying,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncFlag(')
          ..write('applying: $applying')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => applying.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncFlag && other.applying == this.applying);
}

class SyncFlagsCompanion extends UpdateCompanion<SyncFlag> {
  final Value<int> applying;
  final Value<int> rowid;
  const SyncFlagsCompanion({
    this.applying = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncFlagsCompanion.insert({
    this.applying = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  static Insertable<SyncFlag> custom({
    Expression<int>? applying,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (applying != null) 'applying': applying,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncFlagsCompanion copyWith({Value<int>? applying, Value<int>? rowid}) {
    return SyncFlagsCompanion(
      applying: applying ?? this.applying,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (applying.present) {
      map['applying'] = Variable<int>(applying.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncFlagsCompanion(')
          ..write('applying: $applying, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDb extends GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(e);
  $AppDbManager get managers => $AppDbManager(this);
  late final $PetsTable pets = $PetsTable(this);
  late final $HealthRecordsTable healthRecords = $HealthRecordsTable(this);
  late final $WeightsTable weights = $WeightsTable(this);
  late final $AppointmentsTable appointments = $AppointmentsTable(this);
  late final $SyncDeletesTable syncDeletes = $SyncDeletesTable(this);
  late final $SyncFlagsTable syncFlags = $SyncFlagsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    pets,
    healthRecords,
    weights,
    appointments,
    syncDeletes,
    syncFlags,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'pets',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('health_records', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'pets',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('weights', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'pets',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('appointments', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$PetsTableCreateCompanionBuilder = PetsCompanion Function({
  Value<String?> remoteId,
  Value<int?> updatedAt,
  Value<bool?> dirty,
  Value<int> id,
  required String name,
  Value<String> species,
  Value<String?> breed,
  Value<DateTime?> birthDate,
  Value<String?> chip,
  Value<String?> vetName,
  Value<String?> vetPhone,
  Value<String?> photoPath,
  Value<String?> notes,
});
typedef $$PetsTableUpdateCompanionBuilder = PetsCompanion Function({
  Value<String?> remoteId,
  Value<int?> updatedAt,
  Value<bool?> dirty,
  Value<int> id,
  Value<String> name,
  Value<String> species,
  Value<String?> breed,
  Value<DateTime?> birthDate,
  Value<String?> chip,
  Value<String?> vetName,
  Value<String?> vetPhone,
  Value<String?> photoPath,
  Value<String?> notes,
});

final class $$PetsTableReferences
    extends BaseReferences<_$AppDb, $PetsTable, Pet> {
  $$PetsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$HealthRecordsTable, List<HealthRecord>>
  _healthRecordsRefsTable(_$AppDb db) => MultiTypedResultKey.fromTable(
    db.healthRecords,
    aliasName: 'pets__id__health_records__pet_id',
  );

  $$HealthRecordsTableProcessedTableManager get healthRecordsRefs {
    final manager = $$HealthRecordsTableTableManager(
      $_db,
      $_db.healthRecords,
    ).filter((f) => f.petId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_healthRecordsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$WeightsTable, List<Weight>> _weightsRefsTable(
    _$AppDb db,
  ) => MultiTypedResultKey.fromTable(
    db.weights,
    aliasName: 'pets__id__weights__pet_id',
  );

  $$WeightsTableProcessedTableManager get weightsRefs {
    final manager = $$WeightsTableTableManager(
      $_db,
      $_db.weights,
    ).filter((f) => f.petId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_weightsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AppointmentsTable, List<Appointment>>
  _appointmentsRefsTable(_$AppDb db) => MultiTypedResultKey.fromTable(
    db.appointments,
    aliasName: 'pets__id__appointments__pet_id',
  );

  $$AppointmentsTableProcessedTableManager get appointmentsRefs {
    final manager = $$AppointmentsTableTableManager(
      $_db,
      $_db.appointments,
    ).filter((f) => f.petId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_appointmentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PetsTableFilterComposer extends Composer<_$AppDb, $PetsTable> {
  $$PetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get species => $composableBuilder(
    column: $table.species,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get breed => $composableBuilder(
    column: $table.breed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get birthDate => $composableBuilder(
    column: $table.birthDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get chip => $composableBuilder(
    column: $table.chip,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vetName => $composableBuilder(
    column: $table.vetName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vetPhone => $composableBuilder(
    column: $table.vetPhone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> healthRecordsRefs(
    Expression<bool> Function($$HealthRecordsTableFilterComposer f) f,
  ) {
    final $$HealthRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.healthRecords,
      getReferencedColumn: (t) => t.petId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HealthRecordsTableFilterComposer(
            $db: $db,
            $table: $db.healthRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> weightsRefs(
    Expression<bool> Function($$WeightsTableFilterComposer f) f,
  ) {
    final $$WeightsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.weights,
      getReferencedColumn: (t) => t.petId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeightsTableFilterComposer(
            $db: $db,
            $table: $db.weights,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> appointmentsRefs(
    Expression<bool> Function($$AppointmentsTableFilterComposer f) f,
  ) {
    final $$AppointmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.appointments,
      getReferencedColumn: (t) => t.petId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppointmentsTableFilterComposer(
            $db: $db,
            $table: $db.appointments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PetsTableOrderingComposer extends Composer<_$AppDb, $PetsTable> {
  $$PetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get species => $composableBuilder(
    column: $table.species,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get breed => $composableBuilder(
    column: $table.breed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get birthDate => $composableBuilder(
    column: $table.birthDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get chip => $composableBuilder(
    column: $table.chip,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vetName => $composableBuilder(
    column: $table.vetName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vetPhone => $composableBuilder(
    column: $table.vetPhone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PetsTableAnnotationComposer extends Composer<_$AppDb, $PetsTable> {
  $$PetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get species =>
      $composableBuilder(column: $table.species, builder: (column) => column);

  GeneratedColumn<String> get breed =>
      $composableBuilder(column: $table.breed, builder: (column) => column);

  GeneratedColumn<DateTime> get birthDate =>
      $composableBuilder(column: $table.birthDate, builder: (column) => column);

  GeneratedColumn<String> get chip =>
      $composableBuilder(column: $table.chip, builder: (column) => column);

  GeneratedColumn<String> get vetName =>
      $composableBuilder(column: $table.vetName, builder: (column) => column);

  GeneratedColumn<String> get vetPhone =>
      $composableBuilder(column: $table.vetPhone, builder: (column) => column);

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  Expression<T> healthRecordsRefs<T extends Object>(
    Expression<T> Function($$HealthRecordsTableAnnotationComposer a) f,
  ) {
    final $$HealthRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.healthRecords,
      getReferencedColumn: (t) => t.petId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HealthRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.healthRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> weightsRefs<T extends Object>(
    Expression<T> Function($$WeightsTableAnnotationComposer a) f,
  ) {
    final $$WeightsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.weights,
      getReferencedColumn: (t) => t.petId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeightsTableAnnotationComposer(
            $db: $db,
            $table: $db.weights,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> appointmentsRefs<T extends Object>(
    Expression<T> Function($$AppointmentsTableAnnotationComposer a) f,
  ) {
    final $$AppointmentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.appointments,
      getReferencedColumn: (t) => t.petId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppointmentsTableAnnotationComposer(
            $db: $db,
            $table: $db.appointments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PetsTableTableManager
    extends
        RootTableManager<
          _$AppDb,
          $PetsTable,
          Pet,
          $$PetsTableFilterComposer,
          $$PetsTableOrderingComposer,
          $$PetsTableAnnotationComposer,
          $$PetsTableCreateCompanionBuilder,
          $$PetsTableUpdateCompanionBuilder,
          (Pet, $$PetsTableReferences),
          Pet,
          PrefetchHooks Function({
            bool healthRecordsRefs,
            bool weightsRefs,
            bool appointmentsRefs,
          })
        > {
  $$PetsTableTableManager(_$AppDb db, $PetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String?> remoteId = const Value.absent(),
                Value<int?> updatedAt = const Value.absent(),
                Value<bool?> dirty = const Value.absent(),
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> species = const Value.absent(),
                Value<String?> breed = const Value.absent(),
                Value<DateTime?> birthDate = const Value.absent(),
                Value<String?> chip = const Value.absent(),
                Value<String?> vetName = const Value.absent(),
                Value<String?> vetPhone = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => PetsCompanion(
                remoteId: remoteId,
                updatedAt: updatedAt,
                dirty: dirty,
                id: id,
                name: name,
                species: species,
                breed: breed,
                birthDate: birthDate,
                chip: chip,
                vetName: vetName,
                vetPhone: vetPhone,
                photoPath: photoPath,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<String?> remoteId = const Value.absent(),
                Value<int?> updatedAt = const Value.absent(),
                Value<bool?> dirty = const Value.absent(),
                Value<int> id = const Value.absent(),
                required String name,
                Value<String> species = const Value.absent(),
                Value<String?> breed = const Value.absent(),
                Value<DateTime?> birthDate = const Value.absent(),
                Value<String?> chip = const Value.absent(),
                Value<String?> vetName = const Value.absent(),
                Value<String?> vetPhone = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => PetsCompanion.insert(
                remoteId: remoteId,
                updatedAt: updatedAt,
                dirty: dirty,
                id: id,
                name: name,
                species: species,
                breed: breed,
                birthDate: birthDate,
                chip: chip,
                vetName: vetName,
                vetPhone: vetPhone,
                photoPath: photoPath,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PetsTable, Pet>(table),
                  $$PetsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                healthRecordsRefs = false,
                weightsRefs = false,
                appointmentsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (healthRecordsRefs) db.healthRecords,
                    if (weightsRefs) db.weights,
                    if (appointmentsRefs) db.appointments,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (healthRecordsRefs)
                        await $_getPrefetchedDataByColumns<
                          Pet,
                          $PetsTable,
                          HealthRecord,
                          $HealthRecordsTable
                        >(
                          currentTable: table,
                          referencedTable: $$PetsTableReferences
                              ._healthRecordsRefsTable(db),
                          managerFromTypedResult: (p0) => $$PetsTableReferences(
                            db,
                            table,
                            p0,
                          ).healthRecordsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'pet_id',
                          typedResults: items,
                        ),
                      if (weightsRefs)
                        await $_getPrefetchedDataByColumns<
                          Pet,
                          $PetsTable,
                          Weight,
                          $WeightsTable
                        >(
                          currentTable: table,
                          referencedTable: $$PetsTableReferences
                              ._weightsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PetsTableReferences(db, table, p0).weightsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'pet_id',
                          typedResults: items,
                        ),
                      if (appointmentsRefs)
                        await $_getPrefetchedDataByColumns<
                          Pet,
                          $PetsTable,
                          Appointment,
                          $AppointmentsTable
                        >(
                          currentTable: table,
                          referencedTable: $$PetsTableReferences
                              ._appointmentsRefsTable(db),
                          managerFromTypedResult: (p0) => $$PetsTableReferences(
                            db,
                            table,
                            p0,
                          ).appointmentsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'pet_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PetsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      $PetsTable,
      Pet,
      $$PetsTableFilterComposer,
      $$PetsTableOrderingComposer,
      $$PetsTableAnnotationComposer,
      $$PetsTableCreateCompanionBuilder,
      $$PetsTableUpdateCompanionBuilder,
      (Pet, $$PetsTableReferences),
      Pet,
      PrefetchHooks Function({
        bool healthRecordsRefs,
        bool weightsRefs,
        bool appointmentsRefs,
      })
    >;
typedef $$HealthRecordsTableCreateCompanionBuilder =
    HealthRecordsCompanion Function({
      Value<String?> remoteId,
      Value<int?> updatedAt,
      Value<bool?> dirty,
      Value<int> id,
      required int petId,
      required RecordType type,
      required String product,
      required DateTime date,
      Value<DateTime?> nextDue,
      Value<int> remindDaysBefore,
    });
typedef $$HealthRecordsTableUpdateCompanionBuilder =
    HealthRecordsCompanion Function({
      Value<String?> remoteId,
      Value<int?> updatedAt,
      Value<bool?> dirty,
      Value<int> id,
      Value<int> petId,
      Value<RecordType> type,
      Value<String> product,
      Value<DateTime> date,
      Value<DateTime?> nextDue,
      Value<int> remindDaysBefore,
    });

final class $$HealthRecordsTableReferences
    extends BaseReferences<_$AppDb, $HealthRecordsTable, HealthRecord> {
  $$HealthRecordsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PetsTable _petIdTable(_$AppDb db) =>
      db.pets.createAlias('health_records__pet_id__pets__id');

  $$PetsTableProcessedTableManager get petId {
    final $_column = $_itemColumn<int>('pet_id')!;

    final manager = $$PetsTableTableManager(
      $_db,
      $_db.pets,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_petIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$HealthRecordsTableFilterComposer
    extends Composer<_$AppDb, $HealthRecordsTable> {
  $$HealthRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<RecordType, RecordType, int> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get product => $composableBuilder(
    column: $table.product,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextDue => $composableBuilder(
    column: $table.nextDue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get remindDaysBefore => $composableBuilder(
    column: $table.remindDaysBefore,
    builder: (column) => ColumnFilters(column),
  );

  $$PetsTableFilterComposer get petId {
    final $$PetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.petId,
      referencedTable: $db.pets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PetsTableFilterComposer(
            $db: $db,
            $table: $db.pets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HealthRecordsTableOrderingComposer
    extends Composer<_$AppDb, $HealthRecordsTable> {
  $$HealthRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get product => $composableBuilder(
    column: $table.product,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextDue => $composableBuilder(
    column: $table.nextDue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get remindDaysBefore => $composableBuilder(
    column: $table.remindDaysBefore,
    builder: (column) => ColumnOrderings(column),
  );

  $$PetsTableOrderingComposer get petId {
    final $$PetsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.petId,
      referencedTable: $db.pets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PetsTableOrderingComposer(
            $db: $db,
            $table: $db.pets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HealthRecordsTableAnnotationComposer
    extends Composer<_$AppDb, $HealthRecordsTable> {
  $$HealthRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<RecordType, int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get product =>
      $composableBuilder(column: $table.product, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<DateTime> get nextDue =>
      $composableBuilder(column: $table.nextDue, builder: (column) => column);

  GeneratedColumn<int> get remindDaysBefore => $composableBuilder(
    column: $table.remindDaysBefore,
    builder: (column) => column,
  );

  $$PetsTableAnnotationComposer get petId {
    final $$PetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.petId,
      referencedTable: $db.pets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PetsTableAnnotationComposer(
            $db: $db,
            $table: $db.pets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HealthRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDb,
          $HealthRecordsTable,
          HealthRecord,
          $$HealthRecordsTableFilterComposer,
          $$HealthRecordsTableOrderingComposer,
          $$HealthRecordsTableAnnotationComposer,
          $$HealthRecordsTableCreateCompanionBuilder,
          $$HealthRecordsTableUpdateCompanionBuilder,
          (HealthRecord, $$HealthRecordsTableReferences),
          HealthRecord,
          PrefetchHooks Function({bool petId})
        > {
  $$HealthRecordsTableTableManager(_$AppDb db, $HealthRecordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HealthRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HealthRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HealthRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String?> remoteId = const Value.absent(),
                Value<int?> updatedAt = const Value.absent(),
                Value<bool?> dirty = const Value.absent(),
                Value<int> id = const Value.absent(),
                Value<int> petId = const Value.absent(),
                Value<RecordType> type = const Value.absent(),
                Value<String> product = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<DateTime?> nextDue = const Value.absent(),
                Value<int> remindDaysBefore = const Value.absent(),
              }) => HealthRecordsCompanion(
                remoteId: remoteId,
                updatedAt: updatedAt,
                dirty: dirty,
                id: id,
                petId: petId,
                type: type,
                product: product,
                date: date,
                nextDue: nextDue,
                remindDaysBefore: remindDaysBefore,
              ),
          createCompanionCallback:
              ({
                Value<String?> remoteId = const Value.absent(),
                Value<int?> updatedAt = const Value.absent(),
                Value<bool?> dirty = const Value.absent(),
                Value<int> id = const Value.absent(),
                required int petId,
                required RecordType type,
                required String product,
                required DateTime date,
                Value<DateTime?> nextDue = const Value.absent(),
                Value<int> remindDaysBefore = const Value.absent(),
              }) => HealthRecordsCompanion.insert(
                remoteId: remoteId,
                updatedAt: updatedAt,
                dirty: dirty,
                id: id,
                petId: petId,
                type: type,
                product: product,
                date: date,
                nextDue: nextDue,
                remindDaysBefore: remindDaysBefore,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$HealthRecordsTable, HealthRecord>(table),
                  $$HealthRecordsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({petId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (petId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.petId,
                        referencedTable: $$HealthRecordsTableReferences
                            ._petIdTable(db),
                        referencedColumn: $$HealthRecordsTableReferences
                            ._petIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$HealthRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      $HealthRecordsTable,
      HealthRecord,
      $$HealthRecordsTableFilterComposer,
      $$HealthRecordsTableOrderingComposer,
      $$HealthRecordsTableAnnotationComposer,
      $$HealthRecordsTableCreateCompanionBuilder,
      $$HealthRecordsTableUpdateCompanionBuilder,
      (HealthRecord, $$HealthRecordsTableReferences),
      HealthRecord,
      PrefetchHooks Function({bool petId})
    >;
typedef $$WeightsTableCreateCompanionBuilder = WeightsCompanion Function({
  Value<String?> remoteId,
  Value<int?> updatedAt,
  Value<bool?> dirty,
  Value<int> id,
  required int petId,
  required DateTime date,
  required double kg,
});
typedef $$WeightsTableUpdateCompanionBuilder = WeightsCompanion Function({
  Value<String?> remoteId,
  Value<int?> updatedAt,
  Value<bool?> dirty,
  Value<int> id,
  Value<int> petId,
  Value<DateTime> date,
  Value<double> kg,
});

final class $$WeightsTableReferences
    extends BaseReferences<_$AppDb, $WeightsTable, Weight> {
  $$WeightsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PetsTable _petIdTable(_$AppDb db) =>
      db.pets.createAlias('weights__pet_id__pets__id');

  $$PetsTableProcessedTableManager get petId {
    final $_column = $_itemColumn<int>('pet_id')!;

    final manager = $$PetsTableTableManager(
      $_db,
      $_db.pets,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_petIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WeightsTableFilterComposer extends Composer<_$AppDb, $WeightsTable> {
  $$WeightsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get kg => $composableBuilder(
    column: $table.kg,
    builder: (column) => ColumnFilters(column),
  );

  $$PetsTableFilterComposer get petId {
    final $$PetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.petId,
      referencedTable: $db.pets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PetsTableFilterComposer(
            $db: $db,
            $table: $db.pets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WeightsTableOrderingComposer extends Composer<_$AppDb, $WeightsTable> {
  $$WeightsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get kg => $composableBuilder(
    column: $table.kg,
    builder: (column) => ColumnOrderings(column),
  );

  $$PetsTableOrderingComposer get petId {
    final $$PetsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.petId,
      referencedTable: $db.pets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PetsTableOrderingComposer(
            $db: $db,
            $table: $db.pets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WeightsTableAnnotationComposer
    extends Composer<_$AppDb, $WeightsTable> {
  $$WeightsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get kg =>
      $composableBuilder(column: $table.kg, builder: (column) => column);

  $$PetsTableAnnotationComposer get petId {
    final $$PetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.petId,
      referencedTable: $db.pets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PetsTableAnnotationComposer(
            $db: $db,
            $table: $db.pets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WeightsTableTableManager
    extends
        RootTableManager<
          _$AppDb,
          $WeightsTable,
          Weight,
          $$WeightsTableFilterComposer,
          $$WeightsTableOrderingComposer,
          $$WeightsTableAnnotationComposer,
          $$WeightsTableCreateCompanionBuilder,
          $$WeightsTableUpdateCompanionBuilder,
          (Weight, $$WeightsTableReferences),
          Weight,
          PrefetchHooks Function({bool petId})
        > {
  $$WeightsTableTableManager(_$AppDb db, $WeightsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeightsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeightsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeightsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String?> remoteId = const Value.absent(),
                Value<int?> updatedAt = const Value.absent(),
                Value<bool?> dirty = const Value.absent(),
                Value<int> id = const Value.absent(),
                Value<int> petId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<double> kg = const Value.absent(),
              }) => WeightsCompanion(
                remoteId: remoteId,
                updatedAt: updatedAt,
                dirty: dirty,
                id: id,
                petId: petId,
                date: date,
                kg: kg,
              ),
          createCompanionCallback:
              ({
                Value<String?> remoteId = const Value.absent(),
                Value<int?> updatedAt = const Value.absent(),
                Value<bool?> dirty = const Value.absent(),
                Value<int> id = const Value.absent(),
                required int petId,
                required DateTime date,
                required double kg,
              }) => WeightsCompanion.insert(
                remoteId: remoteId,
                updatedAt: updatedAt,
                dirty: dirty,
                id: id,
                petId: petId,
                date: date,
                kg: kg,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WeightsTable, Weight>(table),
                  $$WeightsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({petId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (petId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.petId,
                        referencedTable: $$WeightsTableReferences._petIdTable(
                          db,
                        ),
                        referencedColumn: $$WeightsTableReferences
                            ._petIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$WeightsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      $WeightsTable,
      Weight,
      $$WeightsTableFilterComposer,
      $$WeightsTableOrderingComposer,
      $$WeightsTableAnnotationComposer,
      $$WeightsTableCreateCompanionBuilder,
      $$WeightsTableUpdateCompanionBuilder,
      (Weight, $$WeightsTableReferences),
      Weight,
      PrefetchHooks Function({bool petId})
    >;
typedef $$AppointmentsTableCreateCompanionBuilder =
    AppointmentsCompanion Function({
      Value<String?> remoteId,
      Value<int?> updatedAt,
      Value<bool?> dirty,
      Value<int> id,
      required int petId,
      required DateTime at,
      required String title,
      Value<String?> place,
      Value<int> remindDaysBefore,
    });
typedef $$AppointmentsTableUpdateCompanionBuilder =
    AppointmentsCompanion Function({
      Value<String?> remoteId,
      Value<int?> updatedAt,
      Value<bool?> dirty,
      Value<int> id,
      Value<int> petId,
      Value<DateTime> at,
      Value<String> title,
      Value<String?> place,
      Value<int> remindDaysBefore,
    });

final class $$AppointmentsTableReferences
    extends BaseReferences<_$AppDb, $AppointmentsTable, Appointment> {
  $$AppointmentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PetsTable _petIdTable(_$AppDb db) =>
      db.pets.createAlias('appointments__pet_id__pets__id');

  $$PetsTableProcessedTableManager get petId {
    final $_column = $_itemColumn<int>('pet_id')!;

    final manager = $$PetsTableTableManager(
      $_db,
      $_db.pets,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_petIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AppointmentsTableFilterComposer
    extends Composer<_$AppDb, $AppointmentsTable> {
  $$AppointmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get at => $composableBuilder(
    column: $table.at,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get place => $composableBuilder(
    column: $table.place,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get remindDaysBefore => $composableBuilder(
    column: $table.remindDaysBefore,
    builder: (column) => ColumnFilters(column),
  );

  $$PetsTableFilterComposer get petId {
    final $$PetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.petId,
      referencedTable: $db.pets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PetsTableFilterComposer(
            $db: $db,
            $table: $db.pets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AppointmentsTableOrderingComposer
    extends Composer<_$AppDb, $AppointmentsTable> {
  $$AppointmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dirty => $composableBuilder(
    column: $table.dirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get at => $composableBuilder(
    column: $table.at,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get place => $composableBuilder(
    column: $table.place,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get remindDaysBefore => $composableBuilder(
    column: $table.remindDaysBefore,
    builder: (column) => ColumnOrderings(column),
  );

  $$PetsTableOrderingComposer get petId {
    final $$PetsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.petId,
      referencedTable: $db.pets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PetsTableOrderingComposer(
            $db: $db,
            $table: $db.pets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AppointmentsTableAnnotationComposer
    extends Composer<_$AppDb, $AppointmentsTable> {
  $$AppointmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get dirty =>
      $composableBuilder(column: $table.dirty, builder: (column) => column);

  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get at =>
      $composableBuilder(column: $table.at, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get place =>
      $composableBuilder(column: $table.place, builder: (column) => column);

  GeneratedColumn<int> get remindDaysBefore => $composableBuilder(
    column: $table.remindDaysBefore,
    builder: (column) => column,
  );

  $$PetsTableAnnotationComposer get petId {
    final $$PetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.petId,
      referencedTable: $db.pets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PetsTableAnnotationComposer(
            $db: $db,
            $table: $db.pets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AppointmentsTableTableManager
    extends
        RootTableManager<
          _$AppDb,
          $AppointmentsTable,
          Appointment,
          $$AppointmentsTableFilterComposer,
          $$AppointmentsTableOrderingComposer,
          $$AppointmentsTableAnnotationComposer,
          $$AppointmentsTableCreateCompanionBuilder,
          $$AppointmentsTableUpdateCompanionBuilder,
          (Appointment, $$AppointmentsTableReferences),
          Appointment,
          PrefetchHooks Function({bool petId})
        > {
  $$AppointmentsTableTableManager(_$AppDb db, $AppointmentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppointmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppointmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppointmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String?> remoteId = const Value.absent(),
                Value<int?> updatedAt = const Value.absent(),
                Value<bool?> dirty = const Value.absent(),
                Value<int> id = const Value.absent(),
                Value<int> petId = const Value.absent(),
                Value<DateTime> at = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> place = const Value.absent(),
                Value<int> remindDaysBefore = const Value.absent(),
              }) => AppointmentsCompanion(
                remoteId: remoteId,
                updatedAt: updatedAt,
                dirty: dirty,
                id: id,
                petId: petId,
                at: at,
                title: title,
                place: place,
                remindDaysBefore: remindDaysBefore,
              ),
          createCompanionCallback:
              ({
                Value<String?> remoteId = const Value.absent(),
                Value<int?> updatedAt = const Value.absent(),
                Value<bool?> dirty = const Value.absent(),
                Value<int> id = const Value.absent(),
                required int petId,
                required DateTime at,
                required String title,
                Value<String?> place = const Value.absent(),
                Value<int> remindDaysBefore = const Value.absent(),
              }) => AppointmentsCompanion.insert(
                remoteId: remoteId,
                updatedAt: updatedAt,
                dirty: dirty,
                id: id,
                petId: petId,
                at: at,
                title: title,
                place: place,
                remindDaysBefore: remindDaysBefore,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AppointmentsTable, Appointment>(table),
                  $$AppointmentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({petId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (petId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.petId,
                        referencedTable: $$AppointmentsTableReferences
                            ._petIdTable(db),
                        referencedColumn: $$AppointmentsTableReferences
                            ._petIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AppointmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      $AppointmentsTable,
      Appointment,
      $$AppointmentsTableFilterComposer,
      $$AppointmentsTableOrderingComposer,
      $$AppointmentsTableAnnotationComposer,
      $$AppointmentsTableCreateCompanionBuilder,
      $$AppointmentsTableUpdateCompanionBuilder,
      (Appointment, $$AppointmentsTableReferences),
      Appointment,
      PrefetchHooks Function({bool petId})
    >;
typedef $$SyncDeletesTableCreateCompanionBuilder =
    SyncDeletesCompanion Function({
      Value<int> id,
      required String kind,
      required String petRemoteId,
      required String remoteId,
    });
typedef $$SyncDeletesTableUpdateCompanionBuilder =
    SyncDeletesCompanion Function({
      Value<int> id,
      Value<String> kind,
      Value<String> petRemoteId,
      Value<String> remoteId,
    });

class $$SyncDeletesTableFilterComposer
    extends Composer<_$AppDb, $SyncDeletesTable> {
  $$SyncDeletesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get petRemoteId => $composableBuilder(
    column: $table.petRemoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncDeletesTableOrderingComposer
    extends Composer<_$AppDb, $SyncDeletesTable> {
  $$SyncDeletesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get petRemoteId => $composableBuilder(
    column: $table.petRemoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncDeletesTableAnnotationComposer
    extends Composer<_$AppDb, $SyncDeletesTable> {
  $$SyncDeletesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get petRemoteId => $composableBuilder(
    column: $table.petRemoteId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);
}

class $$SyncDeletesTableTableManager
    extends
        RootTableManager<
          _$AppDb,
          $SyncDeletesTable,
          SyncDelete,
          $$SyncDeletesTableFilterComposer,
          $$SyncDeletesTableOrderingComposer,
          $$SyncDeletesTableAnnotationComposer,
          $$SyncDeletesTableCreateCompanionBuilder,
          $$SyncDeletesTableUpdateCompanionBuilder,
          (SyncDelete, BaseReferences<_$AppDb, $SyncDeletesTable, SyncDelete>),
          SyncDelete,
          PrefetchHooks Function()
        > {
  $$SyncDeletesTableTableManager(_$AppDb db, $SyncDeletesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncDeletesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncDeletesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncDeletesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String> petRemoteId = const Value.absent(),
                Value<String> remoteId = const Value.absent(),
              }) => SyncDeletesCompanion(
                id: id,
                kind: kind,
                petRemoteId: petRemoteId,
                remoteId: remoteId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String kind,
                required String petRemoteId,
                required String remoteId,
              }) => SyncDeletesCompanion.insert(
                id: id,
                kind: kind,
                petRemoteId: petRemoteId,
                remoteId: remoteId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SyncDeletesTable, SyncDelete>(table),
                  BaseReferences<_$AppDb, $SyncDeletesTable, SyncDelete>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncDeletesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      $SyncDeletesTable,
      SyncDelete,
      $$SyncDeletesTableFilterComposer,
      $$SyncDeletesTableOrderingComposer,
      $$SyncDeletesTableAnnotationComposer,
      $$SyncDeletesTableCreateCompanionBuilder,
      $$SyncDeletesTableUpdateCompanionBuilder,
      (SyncDelete, BaseReferences<_$AppDb, $SyncDeletesTable, SyncDelete>),
      SyncDelete,
      PrefetchHooks Function()
    >;
typedef $$SyncFlagsTableCreateCompanionBuilder = SyncFlagsCompanion Function({
  Value<int> applying,
  Value<int> rowid,
});
typedef $$SyncFlagsTableUpdateCompanionBuilder = SyncFlagsCompanion Function({
  Value<int> applying,
  Value<int> rowid,
});

class $$SyncFlagsTableFilterComposer
    extends Composer<_$AppDb, $SyncFlagsTable> {
  $$SyncFlagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get applying => $composableBuilder(
    column: $table.applying,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncFlagsTableOrderingComposer
    extends Composer<_$AppDb, $SyncFlagsTable> {
  $$SyncFlagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get applying => $composableBuilder(
    column: $table.applying,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncFlagsTableAnnotationComposer
    extends Composer<_$AppDb, $SyncFlagsTable> {
  $$SyncFlagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get applying =>
      $composableBuilder(column: $table.applying, builder: (column) => column);
}

class $$SyncFlagsTableTableManager
    extends
        RootTableManager<
          _$AppDb,
          $SyncFlagsTable,
          SyncFlag,
          $$SyncFlagsTableFilterComposer,
          $$SyncFlagsTableOrderingComposer,
          $$SyncFlagsTableAnnotationComposer,
          $$SyncFlagsTableCreateCompanionBuilder,
          $$SyncFlagsTableUpdateCompanionBuilder,
          (SyncFlag, BaseReferences<_$AppDb, $SyncFlagsTable, SyncFlag>),
          SyncFlag,
          PrefetchHooks Function()
        > {
  $$SyncFlagsTableTableManager(_$AppDb db, $SyncFlagsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncFlagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncFlagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncFlagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> applying = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) => SyncFlagsCompanion(applying: applying, rowid: rowid),
          createCompanionCallback: ({
            Value<int> applying = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) => SyncFlagsCompanion.insert(applying: applying, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SyncFlagsTable, SyncFlag>(table),
                  BaseReferences<_$AppDb, $SyncFlagsTable, SyncFlag>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncFlagsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      $SyncFlagsTable,
      SyncFlag,
      $$SyncFlagsTableFilterComposer,
      $$SyncFlagsTableOrderingComposer,
      $$SyncFlagsTableAnnotationComposer,
      $$SyncFlagsTableCreateCompanionBuilder,
      $$SyncFlagsTableUpdateCompanionBuilder,
      (SyncFlag, BaseReferences<_$AppDb, $SyncFlagsTable, SyncFlag>),
      SyncFlag,
      PrefetchHooks Function()
    >;

class $AppDbManager {
  final _$AppDb _db;
  $AppDbManager(this._db);
  $$PetsTableTableManager get pets => $$PetsTableTableManager(_db, _db.pets);
  $$HealthRecordsTableTableManager get healthRecords =>
      $$HealthRecordsTableTableManager(_db, _db.healthRecords);
  $$WeightsTableTableManager get weights =>
      $$WeightsTableTableManager(_db, _db.weights);
  $$AppointmentsTableTableManager get appointments =>
      $$AppointmentsTableTableManager(_db, _db.appointments);
  $$SyncDeletesTableTableManager get syncDeletes =>
      $$SyncDeletesTableTableManager(_db, _db.syncDeletes);
  $$SyncFlagsTableTableManager get syncFlags =>
      $$SyncFlagsTableTableManager(_db, _db.syncFlags);
}
