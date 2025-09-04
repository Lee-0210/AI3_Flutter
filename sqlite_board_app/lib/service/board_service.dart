import 'package:sqlite_board_app/database_helper.dart';
import 'package:sqlite_board_app/models/board.dart';

class BoardService {

  // 데이터 목록
  Future<List<Map<String, dynamic>>> list() async {
    final db = await DatabaseHelper.instance.database;
    return await db.query('boards', orderBy: 'no DESC');
  }

  // 데이터 조회
  Future<Boards?> select(String id) async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.query('boards', where: 'id = ?', whereArgs: [id]);

    return result.isNotEmpty ? Boards.fromMap(result.first) : null;
  }

  // 데이터 등록
  Future<int> create(Boards entity) async {
    final db = await DatabaseHelper.instance.database;
    return db.insert('boards', entity.toMap());
  }

  // 데이터 수정
  Future<int> update(Boards entity) async {
    final db = await DatabaseHelper.instance.database;
    // Map<String, dynamic> data = entity.toMap();
    // data.remove("no");
    // data.remove("created_at");
    // data["updated_at"] = DateTime.now().toIso8601String();
    Map<String, dynamic> data = {
      'title': entity.title,
      'writer': entity.writer,
      'content': entity.content,
      'updated_at': DateTime.now().toIso8601String()
    };
    return db.update('boards', data, where: 'id = ?', whereArgs: [entity.id]);
  }

  // 데이터 삭제
  Future<int> delete(String id) async {
    final db = await DatabaseHelper.instance.database;
    return db.delete('boards', where: 'id = ?', whereArgs: [id]);
  }
}