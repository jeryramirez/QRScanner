


import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:qrapp/src/models/scan_model.dart';
export 'package:qrapp/src/models/scan_model.dart';

class DBProvider {

  static Database _database;
  static final DBProvider db = DBProvider._(); //private constructor

  DBProvider._();

  Future<Database> get database async {

    if (_database != null ) return _database;


    _database = await initDB();


    return _database;
  }

  initDB() async {

    Directory documentDirectory = await getApplicationDocumentsDirectory();

    final path = join( documentDirectory.path, 'QRScansDB.db' );

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db){},
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE Scans ('
            'id INTEGER PRIMARY KEY,'
            'tipo TEXT,'
            'valor TEXT'
          ')'
        );
      }
    );

  }


  createScan(ScanModel createScan ) async {

    final db = await database;

    final res = await db.insert('Scans', createScan.toJson());

    return res;


  }


  Future<ScanModel> getScanById( int id) async {

    final db = await database;

    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id] );

    return res.isNotEmpty ? ScanModel.fromJson( res.first ) : null;

  }

  Future<List<ScanModel>> getAllScans() async {

    final db = await database;

    final res = await db.query('Scans');

    List<ScanModel> list = res.isNotEmpty ? res.map((scan) => ScanModel.fromJson(scan) ).toList() : [];

    return list;

  }

  Future<List<ScanModel>> getScansByType(String tipo) async {

    final db = await database;

    final res = await db.rawQuery("SELECT * FROM Scans WHERE tipo='$tipo'");

    List<ScanModel> list = res.isNotEmpty ? res.map((scan) => ScanModel.fromJson(scan) ).toList() : [];

    return list;

  }

  updateScan( ScanModel newScan) async {

    final db = await database;

    final res = await db.update('Scans', newScan.toJson(), where: 'id = ?', whereArgs: [newScan.id] );

    return res;


  }

  deleteScan(int id) async {

    final db = await database;

    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id] );

    return res;



  }


  deleteAllScan() async {

    final db = await database;
    final res = await db.rawDelete('DELETE FROM Scans ');
    return res;



  }
 




}