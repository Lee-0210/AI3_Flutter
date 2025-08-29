class Dog {
  String name;
  int _age;

  Dog(this.name, this._age);

  void bark() {
    print("$name : 멍멍!, 나이 : $_age");
  }
}
