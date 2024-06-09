import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class UserInfo {

  const UserInfo({
    required this.uid,
    required this.username,
    required this.email,
    required this.avatar,
    required this.creatTime,
    required this.updateTime,
  });

  final String uid;
  final String username;
  final String email;
  final String avatar;
  final String creatTime;
  final String updateTime;

  factory UserInfo.fromJson(Map<String,dynamic> json) => UserInfo(
    uid: json['uid'].toString(),
    username: json['username'].toString(),
    email: json['email'].toString(),
    avatar: json['avatar'].toString(),
    creatTime: json['creatTime'].toString(),
    updateTime: json['updateTime'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'uid': uid,
    'username': username,
    'email': email,
    'avatar': avatar,
    'creatTime': creatTime,
    'updateTime': updateTime
  };

  UserInfo clone() => UserInfo(
    uid: uid,
    username: username,
    email: email,
    avatar: avatar,
    creatTime: creatTime,
    updateTime: updateTime
  );


  UserInfo copyWith({
    String? uid,
    String? username,
    String? email,
    String? avatar,
    String? creatTime,
    String? updateTime
  }) => UserInfo(
    uid: uid ?? this.uid,
    username: username ?? this.username,
    email: email ?? this.email,
    avatar: avatar ?? this.avatar,
    creatTime: creatTime ?? this.creatTime,
    updateTime: updateTime ?? this.updateTime,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is UserInfo && uid == other.uid && username == other.username && email == other.email && avatar == other.avatar && creatTime == other.creatTime && updateTime == other.updateTime;

  @override
  int get hashCode => uid.hashCode ^ username.hashCode ^ email.hashCode ^ avatar.hashCode ^ creatTime.hashCode ^ updateTime.hashCode;
}
