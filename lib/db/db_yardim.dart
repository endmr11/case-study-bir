import 'package:case_study/modeller/GiderModel.dart';
import 'package:case_study/modeller/KategoriModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class DbYardim {
  /// Open Database
  Future<Database> openDB() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'test_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE giderler(gider_id INTEGER PRIMARY KEY AUTOINCREMENT, gider_aciklama TEXT, gider_tutar INTEGER, gider_tarih TEXT ,gider_kategori INTEGER, gider_la REAL, gider_lo REAL )",
        );
      },
      version: 1,
    );
    return database;
  }

  Future<void> createDb() async {
    final Database db = await openDB();
    await db.execute(
        "CREATE TABLE kategoriler(kategori_id INTEGER PRIMARY KEY AUTOINCREMENT, kategori_adi TEXT)");
  }

  /// Insert data
  Future<void> insertGider(GiderModel gider) async {
    final Database db = await openDB();
    await db.insert(
      'giderler',
      gider.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertKategori(KategoriModel kategori) async {
    final Database db = await openDB();
    await db.insert(
      'kategoriler',
      kategori.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Query data
  Future<List<GiderModel>> queryGider() async {
    final Database db = await openDB();
    final List<Map<String, dynamic>> maps = await db.query('giderler');
    return List.generate(maps.length, (i) {
      return GiderModel(
        maps[i]['gider_id'],
        maps[i]['gider_aciklama'],
        maps[i]['gider_tutar'],
        maps[i]['gider_tarih'],
        maps[i]['gider_kategori'],
        maps[i]['gider_la'],
        maps[i]['gider_lo'],
      );
    });
  }

  Future<List<KategoriModel>> queryKategori() async {
    final Database db = await openDB();
    final List<Map<String, dynamic>> maps = await db.query('kategoriler');
    return List.generate(maps.length, (i) {
      return KategoriModel(
        maps[i]['kategori_id'],
        maps[i]['kategori_adi'],
      );
    });
  }

  /// Query data
  Future<List<GiderModel>> queryDetayGider(id) async {
    final Database db = await openDB();
    final List<Map<String, dynamic>> maps =
        await db.query('giderler', where: "gider_id = ?", whereArgs: [id]);
    return List.generate(maps.length, (i) {
      return GiderModel(
        maps[i]['gider_id'],
        maps[i]['gider_aciklama'],
        maps[i]['gider_tutar'],
        maps[i]['gider_tarih'],
        maps[i]['gider_kategori'],
        maps[i]['gider_la'],
        maps[i]['gider_lo'],
      );
    });
  }

  Future<List<KategoriModel>> queryDetayKategori(id) async {
    final Database db = await openDB();
    final List<Map<String, dynamic>> maps = await db
        .query('kategoriler', where: "kategori_id = ?", whereArgs: [id]);
    return List.generate(maps.length, (i) {
      return KategoriModel(
        maps[i]['kategori_id'],
        maps[i]['kategori_adi'],
      );
    });
  }

  /// update data
  Future<void> updateGider(GiderModel gider) async {
    // Get a reference to the database.
    final db = await openDB();
    await db.update(
      'giderler',
      gider.toMap(),
      where: "gider_id = ?",
      whereArgs: [gider.giderId],
    );
  }

  Future<void> updateKategori(KategoriModel kategori) async {
    // Get a reference to the database.
    final db = await openDB();
    await db.update(
      'kategoriler',
      kategori.toMap(),
      where: "kategori_di = ?",
      whereArgs: [kategori.kategoriId],
    );
  }

  /// delete data
  Future<void> deleteGider(int id) async {
    final db = await openDB();
    await db.delete(
      'giderler',
      where: "gider_id = ?",
      whereArgs: [id],
    );
  }

  Future<void> deleteKategori(int id) async {
    final db = await openDB();
    await db.delete(
      'kategoriler',
      where: "kategori_id = ?",
      whereArgs: [id],
    );
  }
}
