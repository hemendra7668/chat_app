// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ChatRoomModel {
  String? chatroomid;
  Map<String, dynamic>? participants;
  String? lastmessage;
  ChatRoomModel({
    this.chatroomid,
    this.participants,
    this.lastmessage,
  });

  ChatRoomModel copyWith({
    String? chatroomid,
    Map<String, dynamic>? participants,
    String? lastmessage,
  }) {
    return ChatRoomModel(
      chatroomid: chatroomid ?? this.chatroomid,
      participants: participants ?? this.participants,
      lastmessage: lastmessage ?? this.lastmessage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chatroomid': chatroomid,
      'participants': participants,
      'lastmessage': lastmessage,
    };
  }

  factory ChatRoomModel.fromMap(Map<String, dynamic> map) {
    return ChatRoomModel(
      chatroomid: map['chatroomid'],
      participants: map['participants'],
      lastmessage: map['lastmessage'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatRoomModel.fromJson(String source) =>
      ChatRoomModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ChatRoomModel(chatroomid: $chatroomid, participants: $participants, lastmessage: $lastmessage)';

  @override
  bool operator ==(covariant ChatRoomModel other) {
    if (identical(this, other)) return true;

    return other.chatroomid == chatroomid &&
        mapEquals(other.participants, participants) &&
        other.lastmessage == lastmessage;
  }

  @override
  int get hashCode =>
      chatroomid.hashCode ^ participants.hashCode ^ lastmessage.hashCode;
}
