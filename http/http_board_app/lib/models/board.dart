import 'package:uuid/uuid.dart';

class Boards {

  static final Uuid _uuid = Uuid();

  final int? no;
  final String? id;
  final String? title;
  final String? writer;
  final String? content;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  // 생성자
  // * 객체명 (
  //   -> 위치 매개변수
  //   this.변수,               -> 선택 매개변수
  //   [this.변수],             -> 기본 매개변수
  //   -> 이름 매개변수
  //   {
  //      this.변수,            -> 선택 매개변수
  //      required this.변수    -> 기본 매개변수
  //   }
  // )
  Boards(
    {
      this.no,
      String? id,
      required this.title,
      required this.writer,
      required this.content,
      this.createdAt,
      this.updatedAt,
    }
  ) : id = id?? _uuid.v4();
  // 생성자() : 초기화 리스트
  // initializer list ( : )
  // : 생성자가 실행되기 전에 변수 초기화하는 방법

  // 객체 -> Map
  Map<String, dynamic> toMap() {
    return {
      'no': no,
      'id': id,
      'title': title,
      'writer': writer,
      'content': content,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  // 🎁 Map ➡ 📦 객체
  factory Boards.fromMap(Map<String, dynamic> map) {
    return Boards(
      no: map['no'],
      id: map['id'],
      title: map['title'],
      writer: map['writer'],
      content: map['content'],
      createdAt: map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      updatedAt: map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
    );
  }
}