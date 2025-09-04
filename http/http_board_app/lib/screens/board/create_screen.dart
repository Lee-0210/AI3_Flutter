import 'package:flutter/material.dart';
import 'package:http_board_app/models/board.dart';
import 'package:http_board_app/service/board_service.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {

  // state
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _writerController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final boardService = BoardService();

  // 게시글 등록 처리
  Future<void> create() async {
    // 유효성 검사
    if(!_formkey.currentState!.validate()) {
      print("게시글 입력 정보가 유효하지 않습니다.");
      return;
    }

    // 게시글 객체 생성
    Boards board = Boards(
      title: _titleController.text,
      writer: _writerController.text,
      content: _contentController.text,
    );
    print("board - id : ${board.id}");

    // 데이터 등록
    int result = await boardService.create(board);
    if(result > 0) {
      print("게시글 등록 성공");
      Navigator.pushReplacementNamed(context, '/board/list');
    } else {print("게시글 등록 실패");}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, "/board/list");
          },
          child: const Icon(Icons.arrow_back)
        ),
        title: const Text("게시글 등록"),
        // actions: [
        //   IconButton(
        //     onPressed: create,
        //     icon: const Icon(Icons.more_vert)
        //   )
        // ]
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              // 제목
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: "제목"
                ),
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return "제목을 입력하세요.";
                  }
                  return null;
                },
              ),
              // 작성자
              TextFormField(
                controller: _writerController,
                decoration: const InputDecoration(
                  labelText: "작성자"
                ),
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return "작성자를 입력하세요.";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              // 내용
              TextFormField(
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                controller: _contentController,
                decoration: const InputDecoration(
                  labelText: "내용",
                  border: OutlineInputBorder()
                ),
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return "내용을 입력하세요.";
                  }
                  return null;
                },
              ),
            ],
          )
        ),
      ),
      bottomSheet: Container(
        height: 60,
        color: Colors.white,
        child: Center(
          child: ElevatedButton(
            onPressed: create,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 40),
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero
              )
            ),
            child: const Text("등록하기", style: TextStyle(fontSize: 20))
          )
        )
      )
    );
  }
}