import 'Dog.dart';

class Person {
  // 멤버 변수
  // Dart 에서는 Public, private(_)
  // - public : 외부에서 접근 가능
  // - private : 외부에서 접근 불가능(_)
  String name; // public
  int _age; // private

  // 생성자
  Person(this.name, this._age);

  // 메서드
  void introduce() {
    print('안녕하세요, 제 이름은 $name 이고, 나이는 $_age세입니다.');
  }
}

void main(List<String> args) {
  // 객체 생성
  Person person = Person('김조은', 30);
  person.introduce();

  person.name = "트럼프";
  // 같은 파일 내에서는 private 변수에 접근 가능
  person._age = 77;

  person.introduce();

  // 외부 다트 파일 가져오기 : import
  Dog dog = Dog('바둑이', 3);
  dog.bark();

  dog.name = '뭉치';
  // dog._age = 3; // private 이라 불가능
  dog.bark();
}
