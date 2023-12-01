import 'package:flutter/material.dart';
import 'package:flutter_bloc_bg_1/sqflite_crud/model/user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelperUserDetails {
  String userInfoTableName = "USERDETAILS";

  Future<Database> getDatabase() async {
    String path = await getDatabasesPath();

    String dbPath = join(path, "UserDB.db");
    Database database = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        db
            .execute(
                "create table $userInfoTableName (id integer primary key autoincrement,name text,email text);")
            .catchError((error) {
          debugPrint("ERROR:- $error");
        });
      },
    );
    return database;
  }

  Future<int> insertUserDetails(UserModel userModel) async {
    Database database = await getDatabase();

    int result = await database.insert(userInfoTableName, userModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
    debugPrint("inserDetails=====>${userModel.toJson()}");
    return result;
  }

  Future<List<UserModel>> readUserInfo() async {
    Database database = await getDatabase();
    var result = await database.query(
      userInfoTableName,
    );
    List<UserModel> userModelList = [];

    for (var element in result) {
      UserModel userModel = UserModel.fromJson(element);
      userModelList.add(userModel);
    }

    return userModelList;
  }

  Future<UserModel?> getLoginUser(String email) async {
    var db = await getDatabase();
    var res = await db
        .query(userInfoTableName, where: "email = ?", whereArgs: [email]);

    if (res.isNotEmpty) {
      return UserModel.fromJson(res.first);
    }

    return null;
  }

  Future<int> deleteUserDetails(UserModel userModel) async {
    Database database = await getDatabase();
    int result = await database
        .delete(userInfoTableName, where: "id = ?", whereArgs: [userModel.id]);
    return result;
  }

  Future<int> updateUserDetails(UserModel userModel) async {
    Database database = await getDatabase();

    // Update the given Dog.
    int result = await database.update(
      userInfoTableName,
      userModel.toJson(),
      where: 'id = ?',
      whereArgs: [userModel.id],
    );
    return result;
  }
}
