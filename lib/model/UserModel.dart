// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  String? uid;
  String? fullname;
  String? email;
  UserModel({
    this.uid,
    this.fullname,
    this.email,
  });

  UserModel copyWith({
    String? uid,
    String? fullname,
    String? email,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      fullname: fullname ?? this.fullname,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'fullname': fullname,
      'email': email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] != null ? map['uid'] as String : null,
      fullname: map['fullname'] != null ? map['fullname'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'UserModel(uid: $uid, fullname: $fullname, email: $email)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.fullname == fullname &&
        other.email == email;
  }

  @override
  int get hashCode => uid.hashCode ^ fullname.hashCode ^ email.hashCode;
}
