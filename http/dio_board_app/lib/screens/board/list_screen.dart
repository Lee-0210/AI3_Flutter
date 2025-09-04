import 'package:flutter/material.dart';
import 'package:dio_board_app/models/board.dart';
import 'package:dio_board_app/service/board_service.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {

  // state
  late Future<List<Map<String, dynamic>>> _boardList;
  final boardService = BoardService();

  // 팝업메뉴 아이템 (수정하기, 삭제하기)
  final List<PopupMenuEntry<String>> _popupMenuItems = [
    const PopupMenuItem(
      value: 'update',
      child: Row(
        children: [
          Icon(Icons.edit, size: 16),
          SizedBox(width: 8),
          Text("수정하기")
        ],
      )
    ),
    const PopupMenuItem(
      value: 'delete',
      child: Row(
        children: [
          Icon(Icons.delete, size: 16),
          SizedBox(width: 8),
          Text("삭제하기")
        ],
      )
    )
  ];

  void _selected(String value, String id) async {
    switch (value) {
      case 'update':
        print("수정하기 클릭");
        Navigator.pushReplacementNamed(context, "/board/update", arguments: id);
        break;
      case 'delete':
        print("삭제하기 클릭");
        // 삭제 확인 -> 삭제 처리
        bool check = await _confirm();
        if(check) {
          int result = await boardService.delete(id);
          setState(() {
            _boardList = boardService.list();
          });
        }
        break;
    }
  }

  // 삭제 확인
  Future<bool> _confirm() async {
    bool result = false;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("삭제 확인"),
          content: const Text("정말 삭제하시겠습니까?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("취소")
            ),
            TextButton(
              onPressed: () {
                result = true;
                Navigator.of(context).pop(true);
              },
              child: const Text("삭제")
            ),
          ],
        );
      }
    ).then((value) {
      // [삭제], [취소]
      result = value ?? false;
    });
    return result;
  }


  @override
  void initState() {
    super.initState();
    // 게시글 목록 요청
    _boardList = boardService.list();
    print("boardList : ${_boardList.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("게시글 목록")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, "/board/create");
        },
        child: const Icon(Icons.create)
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
        child: FutureBuilder(
          future: _boardList,

          builder: (context, snapshot) {
            // 데이터 로딩 중
            if(snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            // 에러 발생
            else if (snapshot.hasError) {
              return Column(
                children: [
                  Center(child: Text("데이터 조회 시, 에러")),
                  Center(child: Text("error: ${snapshot.error}"))
                ]
              );
            }
            // 데이터 없음
            else if(!snapshot.hasError && snapshot.data!.isEmpty) {
              return const Center(child: Text("조회된 데이터가 없습니다."));
            }
            // 데이터 있음
            else {
              List<Map<String, dynamic>> boardData = snapshot.data!;
              return ListView.builder(
                itemCount: boardData.length,
                itemBuilder: (context, index) {
                  final board = Boards.fromMap(boardData[index]);
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "/board/detail", arguments: board.id);
                    },
                    child: Card(
                      child: ListTile(
                        leading: Text(board.no.toString()),
                        title: Text(board.title ?? ''),
                        subtitle: Text(board.writer ?? ''),
                        trailing: PopupMenuButton(
                          itemBuilder: (BuildContext context) {
                            return _popupMenuItems;
                          },
                          // 팝업 메뉴 선택 시, 이벤트
                          onSelected: (String value) {
                            _selected(value, board.id!);
                          },
                        )
                      )
                    )
                  );
                }
              );
            }
          }
        )
      )
    );
  }
}