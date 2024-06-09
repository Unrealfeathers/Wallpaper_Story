import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class WallpaperElement {

  const WallpaperElement({
    required this.wid,
    required this.title,
  });

  final String wid;
  final String title;

  factory WallpaperElement.fromJson(Map<String,dynamic> json) => WallpaperElement(
    wid: json['wid'].toString(),
    title: json['title'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'wid': wid,
    'title': title
  };

  WallpaperElement clone() => WallpaperElement(
    wid: wid,
    title: title
  );


  WallpaperElement copyWith({
    String? wid,
    String? title
  }) => WallpaperElement(
    wid: wid ?? this.wid,
    title: title ?? this.title,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is WallpaperElement && wid == other.wid && title == other.title;

  @override
  int get hashCode => wid.hashCode ^ title.hashCode;
}
