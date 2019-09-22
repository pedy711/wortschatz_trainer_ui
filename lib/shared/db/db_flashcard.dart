/* import 'package:sqflite/sqlite_api.dart';
import 'package:wortschatz_trainer/models/FlashCard.dart';
import 'package:wortschatz_trainer/shared/dbhelper.dart';

class DbFlashCard {
  static Database db;

  DbFlashCard() {
    DbHelper dbHelper = DbHelper();
    dbHelper.db.then((result)=>
      DbFlashCard.db = result
    );
  }

  Future<int> insertUser(FlashCard flashCard) async {
    Database db = await this.db;
    var result = await db.insert(tblUser, user.toJson());
    return result;
  }
}
 */