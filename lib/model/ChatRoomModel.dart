// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ChatRoomModel {
  String? chatroomid;
  List<String>? participants;
  ChatRoomModel({
    this.chatroomid,
    this.participants,
  });
  

  ChatRoomModel copyWith({
    String? chatroomid,
    List<String>? participants,
  }) {
    return ChatRoomModel(
      chatroomid: chatroomid ?? this.chatroomid,
      participants: participants ?? this.participants,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chatroomid': chatroomid,
      'participants': participants,
    };
  }

  factory ChatRoomModel.fromMap(Map<String, dynamic> map) {
    return ChatRoomModel(
      chatroomid: map['chatroomid'] != null ? map['chatroomid'] as String : null,
      participants: map['participants'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatRoomModel.fromJson(String source) => ChatRoomModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ChatRoomModel(chatroomid: $chatroomid, participants: $participants)';

  @override
  bool operator ==(covariant ChatRoomModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.chatroomid == chatroomid &&
      listEquals(other.participants, participants);
  }

  @override
  int get hashCode => chatroomid.hashCode ^ participants.hashCode;
}
