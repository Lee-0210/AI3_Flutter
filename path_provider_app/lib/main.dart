import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // state
  List<String> _itemList = [];
  TextEditingController _controller = TextEditingController();

  // initState
  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    List<String> savedItemList = await readMemo();
    print(savedItemList);
    setState(() {
      _itemList = savedItemList;
    });
  }

  // 함수 정의
  // 1. 메모 불러오는 함수
  // 2. 메모 저장하는 함수
  // 3. 메모 삭제하는 함수

  // 메모 불러오는 함수
  Future<List<String>> readMemo() async {
    List<String> itemList = [];

    // 최초 파일 생성
    var dir = await getApplicationDocumentsDirectory();
    var file;
    bool fileExist = await File(dir.path + '/memo.txt').exists();

    // 최초인 경우
    if(fileExist == false) {
      print("최초로 memo.txt 파일 생성");
      // 파일 생성
      file = '';
      File(dir.path + "memo.txt").writeAsStringSync (file);
    }
    // 생성된 파일 읽기
    else {
      file = await File(dir.path + "memo.txt").readAsString();
    }

    if(file == null || file == '') {
      return [];
    }

    // memo.txt => String => List<String> itemList
    var array = file.split('\n');   // \n(엔터) 기준으로 구분
    for(var item in array) {
      if(item != '') {
        itemList.add(item);
      }
    }

    return itemList;
  }

  // 메모 저장하는 함수
  void writeMemo(String data) async {
    // 파일 경로
    var dir = await getApplicationDocumentsDirectory();
    var file = await File(dir.path + "/memo.txt").readAsString();
    if(file == '') {
      file = data;
    } else {
      file = file + '\n' + data;
    }
    // 파일 저장
    File(dir.path + "memo.txt").writeAsStringSync(file);
  }

  // 메모 삭제하는 함수
  Future<bool> deleteMemo(int index) async {
    List<String> copyList = [];
    copyList.addAll(_itemList);
    copyList.removeAt(index);

    // List<String> => String
    var fileData = "";
    for(var i = 0; i < copyList.length; i++) {
      var item = copyList[i];
      if(i < copyList.length - 1) {
        item += '\n';
      }
      fileData += item;
    }
    // 파일 저장 : String => txt
    try {
      var dir = await getApplicationDocumentsDirectory();
      File(dir.path + "/memo.txt").writeAsStringSync(fileData);
    } catch(e) {
      print(e);
      return false;
    }
  return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("메모 앱")),
      body: Container(
        child: Center(
          child: Column(
            children: [
              // 메모 입력
              Padding(
                padding: EdgeInsets.all(20),
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "메모를 입력해주세요."
                  )
                )
              ),

              const SizedBox(height: 10),

              // 메모 리스트
              Expanded(
                child: ListView.builder(
                  itemCount: _itemList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onLongPress: () async {
                        print("카드 길게 누름");
                        bool check = await deleteMemo(index);
                        if(check) {
                          setState(() {
                            _itemList.removeAt(index);
                          });
                        }
                      },
                      child: Card(
                        child: Center(
                          child: Text(_itemList[index], style: TextStyle(fontSize: 20))
                        )
                      )
                    );
                  }
                )
              ),
            ],
          )
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("메모 등록");
          // 입력한 메모 txt 파일에 저장
          writeMemo(_controller.text);
          // 입력한 내용을 itemList 에 추가
          setState(() {
            _itemList.add(_controller.text);
          });
          // 텍스트 필드에 입력한 내용 비우기
          _controller.text = '';
        },
        child: Icon(Icons.create),
      ),
    );
  }
}