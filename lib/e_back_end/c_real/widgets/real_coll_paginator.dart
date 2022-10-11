import 'dart:async';

import 'package:bldrs/e_back_end/c_real/foundation/real.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_stream.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scrollers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class RealCollPaginator extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const RealCollPaginator({
    @required this.builder,
    @required this.nodePath,
    this.scrollController,
    this.limit = 5,
    this.realOrderBy,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Widget Function(BuildContext, List<Map<String, dynamic>> maps, bool isLoading) builder;
  final ScrollController scrollController;
  final String nodePath;
  final int limit;
  final RealPaginator realOrderBy;
  /// --------------------------------------------------------------------------
  @override
  _RealCollPaginatorState createState() => _RealCollPaginatorState();
  /// --------------------------------------------------------------------------
}

class _RealCollPaginatorState extends State<RealCollPaginator> {
  // -----------------------------------------------------------------------------
  List<Map<String, dynamic>> _maps;
  ScrollController _controller;
  Map<String, dynamic> _startAfter;
  final ValueNotifier<bool> _isPaginating = ValueNotifier(false);

  StreamSubscription _sub;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
  // --------------------
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'RealCollPaginator',);
    }
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    blog('init : real coll paginator');

    _maps = <Map<String, dynamic>>[];
    _controller = widget.scrollController ?? ScrollController();

    _sub = RealStream.streamOnChildAddedToPath(
      path: widget.nodePath,
      onChildAdded: (dynamic map) async {

        Mapper.blogMap(map, invoker: 'RealCollPaginator.Real.streamPath');

      },
    );

    Scrollers.createPaginationListener(
        controller: _controller,
        isPaginating: _isPaginating,
        onPaginate: () async {

          await _readMore();

        }
    );

    // _controller.addListener(() async {
    //
    //   final bool _canPaginate = Scrollers.canPaginate(
    //     scrollController: _controller,
    //     paginationHeight: Ratioz.horizon * 3,
    //     isPaginating: _isPaginating,
    //   );
    //
    //   final double _currentScroll = _controller.position.pixels;
    //
    //
    //   if (_canPaginate == true){
    //
    //     _isPaginating = true;
    //
    //     await _readMore();
    //
    //     _isPaginating = true;
    //
    //   }
    //
    // });

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {
      _triggerLoading().then((_) async {
        await _readMore();
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    _isPaginating.dispose();

    _sub.cancel();

    if (widget.scrollController == null) {
      _controller.dispose();
    }

    super.dispose();
  }
  // -----------------------------------------------------------------------------
  Future<void> _readMore() async {
    _loading.value = true;

    blog('should read more : startAfter is $_startAfter');

    final List<Map<String, dynamic>> _nextMaps = await Real.readColl(
      context: context,
      nodePath: widget.nodePath,
      startAfter: _startAfter,
      limit: widget.limit,
      realOrderBy: widget.realOrderBy,
      limitToFirst: false,
      // realOrderBy:
    );

    if (Mapper.checkCanLoopList(_nextMaps) == true){
      _maps = <Map<String, dynamic>>[..._maps, ..._nextMaps];
      _startAfter = _maps.last;
      // widget.queryParameters.onDataChanged(_maps);
    }

    _loading.value = false;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        valueListenable: _loading,
        builder: (_, bool isLoading, Widget child) {
          return widget.builder(context, _maps, isLoading);
        }
    );

  }
// -----------------------------------------------------------------------------
}
