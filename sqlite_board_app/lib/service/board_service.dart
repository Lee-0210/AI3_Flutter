import 'package:sqlite_board_app/database_helper.dart';
import 'package:sqlite_board_app/models/board.dart';

class BoardService {

  // 데이터 목록
  Future<List<Map<String, dynamic>>> list() async {
    final db = await DatabaseHelper.instance.database;
    return await db.query('boards', orderBy: 'no DESC');
  }

  // 데이터 조회
  Future<Map<String, dynamic>?> get(String id) async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.query('boards', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? result.first : null;
  }

  // 데이터 등록
  Future<int> create(Boards entity) async {
    final db = await DatabaseHelper.instance.database;
    return db.insert('boards', entity.toMap());
  }

  // 데이터 수정
  Future<int> update(Boards entity) async {
    final db = await DatabaseHelper.instance.database;
    return db.update('boards', entity.toMap(), where: 'id = ?', whereArgs: [entity.id]);
  }

  // 데이터 삭제
  Future<int> delete(String id) async {
    final db = await DatabaseHelper.instance.database;
    return db.delete('boards', where: 'id = ?', whereArgs: [id]);
  }
}