import 'dart:async';
import 'package:basics/filing/filing.dart';
import 'package:flutter/material.dart';

class CacheCleaner extends StatefulWidget {

  const CacheCleaner({
    required this.child,
    super.key
  });
  
  final Widget child;

  @override
  _CacheCleanerState createState() => _CacheCleanerState();
}

class _CacheCleanerState extends State<CacheCleaner> {

  @override
  void dispose() {
    unawaited(ImageCacheOps.wipeCaches());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return widget.child;

  }

}
