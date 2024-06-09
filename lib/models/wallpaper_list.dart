import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class WallpaperList {

  const WallpaperList({
    required this.wallpaperlist,
  });

  final List<WallpaperElement> wallpaperlist;

  factory WallpaperList.fromJson(Map<String,dynamic> json) => WallpaperList(
    wallpaperlist: (json['wallpaperlist'] as List? ?? []).map((e) => WallpaperElement.fromJson(e as Map<String, dynamic>)).toList()
  );
  
  Map<String, dynamic> toJson() => {
    'wallpaperlist': wallpaperlist.map((e) => e.toJson()).toList()
  };

  WallpaperList clone() => WallpaperList(
    wallpaperlist: wallpaperlist.map((e) => e.clone()).toList()
  );


  WallpaperList copyWith({
    List<WallpaperElement>? wallpaperlist
  }) => WallpaperList(
    wallpaperlist: wallpaperlist ?? this.wallpaperlist,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is WallpaperList && wallpaperlist == other.wallpaperlist;

  @override
  int get hashCode => wallpaperlist.hashCode;
}
