class NextEvolution {
  String num;
  String name;

  NextEvolution({required this.num, required this.name});

  factory NextEvolution.fromJson(Map<String, dynamic> json) {
    return NextEvolution(
      num: json['num'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'num': num,
      'name': name,
    };
  }
}
