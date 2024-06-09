import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class WallpaperInfo {

  const WallpaperInfo({
    required this.wid,
    required this.uid,
    required this.title,
    required this.url,
    required this.tags,
    required this.likeAccount,
    required this.collectAccount,
    required this.creatTime,
    required this.updateTime,
  });

  final String wid;
  final String uid;
  final String title;
  final String url;
  final List<String> tags;
  final String likeAccount;
  final String collectAccount;
  final String creatTime;
  final String updateTime;

  factory WallpaperInfo.fromJson(Map<String,dynamic> json) => WallpaperInfo(
    wid: json['wid'].toString(),
    uid: json['uid'].toString(),
    title: json['title'].toString(),
    url: json['url'].toString(),
    tags: (json['tags'] as List? ?? []).map((e) => e as String).toList(),
    likeAccount: json['likeAccount'].toString(),
    collectAccount: json['collectAccount'].toString(),
    creatTime: json['creatTime'].toString(),
    updateTime: json['updateTime'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'wid': wid,
    'uid': uid,
    'title': title,
    'url': url,
    'tags': tags.map((e) => e.toString()).toList(),
    'likeAccount': likeAccount,
    'collectAccount': collectAccount,
    'creatTime': creatTime,
    'updateTime': updateTime
  };

  WallpaperInfo clone() => WallpaperInfo(
    wid: wid,
    uid: uid,
    title: title,
    url: url,
    tags: tags.toList(),
    likeAccount: likeAccount,
    collectAccount: collectAccount,
    creatTime: creatTime,
    updateTime: updateTime
  );


  WallpaperInfo copyWith({
    String? wid,
    String? uid,
    String? title,
    String? url,
    List<String>? tags,
    String? likeAccount,
    String? collectAccount,
    String? creatTime,
    String? updateTime
  }) => WallpaperInfo(
    wid: wid ?? this.wid,
    uid: uid ?? this.uid,
    title: title ?? this.title,
    url: url ?? this.url,
    tags: tags ?? this.tags,
    likeAccount: likeAccount ?? this.likeAccount,
    collectAccount: collectAccount ?? this.collectAccount,
    creatTime: creatTime ?? this.creatTime,
    updateTime: updateTime ?? this.updateTime,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is WallpaperInfo && wid == other.wid && uid == other.uid && title == other.title && url == other.url && tags == other.tags && likeAccount == other.likeAccount && collectAccount == other.collectAccount && creatTime == other.creatTime && updateTime == other.updateTime;

  @override
  int get hashCode => wid.hashCode ^ uid.hashCode ^ title.hashCode ^ url.hashCode ^ tags.hashCode ^ likeAccount.hashCode ^ collectAccount.hashCode ^ creatTime.hashCode ^ updateTime.hashCode;
}
