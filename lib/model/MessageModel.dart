// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MessageModel {
  String? messageid;
  String? sender;
  String? text;
  DateTime? createdon;
  bool? seen;
  MessageModel({
    this.messageid,
    this.sender,
    this.text,
    this.createdon,
    this.seen,
  });

  MessageModel copyWith({
    String? messageid,
    String? sender,
    String? text,
    DateTime? createdon,
    bool? seen,
  }) {
    return MessageModel(
      messageid: messageid ?? this.messageid,
      sender: sender ?? this.sender,
      text: text ?? this.text,
      createdon: createdon ?? this.createdon,
      seen: seen ?? this.seen,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'messageid': messageid,
      'sender': sender,
      'text': text,
      'createdon': createdon?.millisecondsSinceEpoch,
      'seen': seen,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      messageid: map['messageid'] != null ? map['messageid'] as String : null,
      sender: map['sender'] != null ? map['sender'] as String : null,
      text: map['text'] != null ? map['text'] as String : null,
      createdon: map['createdon'] != null ? DateTime.fromMillisecondsSinceEpoch(map['createdon'] as int) : null,
      seen: map['seen'] != null ? map['seen'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MessageModel(messageid: $messageid, sender: $sender, text: $text, createdon: $createdon, seen: $seen)';
  }

  @override
  bool operator ==(covariant MessageModel other) {
    if (identical(this, other)) return true;

    return other.messageid == messageid &&
        other.sender == sender &&
        other.text == text &&
        other.createdon == createdon &&
        other.seen == seen;
  }

  @override
  int get hashCode {
    return messageid.hashCode ^
        sender.hashCode ^
        text.hashCode ^
        createdon.hashCode ^
        seen.hashCode;
  }
}
