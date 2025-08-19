enum Gender { male, female }

enum SelectionMode { inOrder, random }

class Player {
  String name;
  Gender gender;

  Player({required this.name, required this.gender});
}
