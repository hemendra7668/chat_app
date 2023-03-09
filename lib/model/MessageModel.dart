// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MessageModel {
  String? sender;
  String? text;
  String? createdon;
  bool? seen;
  MessageModel({
    this.sender,
    this.text,
    this.createdon,
    this.seen,
  });

  MessageModel copyWith({
    String? sender,
    String? text,
    String? createdon,
    bool? seen,
  }) {
    return MessageModel(
      sender: sender ?? this.sender,
      text: text ?? this.text,
      createdon: createdon ?? this.createdon,
      seen: seen ?? this.seen,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sender': sender,
      'text': text,
      'createdon': createdon,
      'seen': seen,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      sender: map['sender'] != null ? map['sender'] as String : null,
      text: map['text'] != null ? map['text'] as String : null,
      createdon: map['createdon'] != null ? map['createdon'] as String : null,
      seen: map['seen'] != null ? map['seen'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) => MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MessageModel(sender: $sender, text: $text, createdon: $createdon, seen: $seen)';
  }

  @override
  bool operator ==(covariant MessageModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.sender == sender &&
      other.text == text &&
      other.createdon == createdon &&
      other.seen == seen;
  }

  @override
  int get hashCode {
    return sender.hashCode ^
      text.hashCode ^
      createdon.hashCode ^
      seen.hashCode;
  }
}
