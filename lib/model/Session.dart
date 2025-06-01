class Session {
  final int id;
  final String name;

  Session({required this.id, required this.name});

  factory Session.fromJson(Map<String, dynamic> json) {
    final id = json['ID'];
    final name = json['SessionName'];

    if (id == null || name == null) {
      throw Exception("SessionID or SessionName is null");
    }

    return Session(id: id, name: name);
  }

  @override
  String toString() => name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Session &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
