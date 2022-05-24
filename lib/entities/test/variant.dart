import 'dart:convert';

class Variant {
  String text;
  int id;
  Variant({
    required this.text,
    required this.id,
  });

  Variant copyWith({
    String? text,
    int? id,
  }) {
    return Variant(
      text: text ?? this.text,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'id': id,
    };
  }

  factory Variant.fromMap(Map<String, dynamic> map) {
    //print(map);
    return Variant(
      text: map['text'] ?? '',
      id: map['id']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Variant.fromJson(String source) =>
      Variant.fromMap(json.decode(source));

  @override
  String toString() => 'Variant(text: $text, id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Variant && other.text == text && other.id == id;
  }

  @override
  int get hashCode => text.hashCode ^ id.hashCode;
}
