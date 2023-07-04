import 'dart:async';
import 'package:bldrs/e_back_end/h_caching/cache_ops.dart';
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
    unawaited(CacheOps.wipeCaches());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return widget.child;

  }

}
