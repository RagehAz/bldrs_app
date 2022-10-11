import 'dart:async';

import 'package:bldrs/e_back_end/c_real/foundation/real.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_stream.dart';
import 'package:bldrs/e_back_end/c_real/real_models/real_query_model.dart';
import 'package:bldrs/e_back_end/z_helpers/paginator_notifiers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scrollers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class RealCollPaginator extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const RealCollPaginator({
    @required this.builder,
    this.scrollController,
    this.realQueryModel,
    this.paginatorNotifiers,
    this.loadingWidget,
    this.child,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ScrollController scrollController;
  final RealQueryModel realQueryModel;
  final PaginationController paginatorNotifiers;
  final Widget loadingWidget;
  final Widget child;
  final Widget Function(
      BuildContext,
      List<Map<String, dynamic>> maps,
      bool isLoading,
      Widget child
      ) builder;
  /// --------------------------------------------------------------------------
  @override
  _RealCollPaginatorState createState() => _RealCollPaginatorState();
  /// --------------------------------------------------------------------------
}

class _RealCollPaginatorState extends State<RealCollPaginator> {
  // -----------------------------------------------------------------------------
  ScrollController _controller;
  // --------------------
  final ValueNotifier<bool> _isPaginating = ValueNotifier(false);
  PaginationController _paginatorNotifiers;
  // -----------------------------------------------------------------------------
  // List<Map<String, dynamic>> _maps;
  // Map<String, dynamic> _startAfter;

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
    // _maps = <Map<String, dynamic>>[];

    /// LISTEN TO SCROLL
    _controller = widget.scrollController ?? ScrollController();
    Scrollers.createPaginationListener(
        controller: _controller,
        isPaginating: _isPaginating,
        onPaginate: () async {
          await _readMore();
        }
    );

    /// LISTEN TO PAGINATOR NOTIFIERS (AddMap - replaceMap - deleteMap - onDataChanged)
    _paginatorNotifiers = widget.paginatorNotifiers ?? PaginationController.initialize(
      addExtraMapsAtEnd: false,
    );
    _paginatorNotifiers?.activateListeners(
      mounted: mounted,
      onDataChanged: (List<Map<String, dynamic>> maps){

        // Mapper.blogMaps(maps, methodName: 'RealCollPaginator._paginatorNotifiers.onDataChanged');

      },
    );


    /// CREATE LISTENERS NEW CHILD ADDED TO PATH
    _sub = RealStream.streamOnChildAddedToPath(
      path: widget.realQueryModel.path,
      onChildAdded: (dynamic map) async {

        Mapper.blogMap(map, invoker: 'RealCollPaginator.Real.streamPath');

        if (_isInit == false){
          _paginatorNotifiers.addMap.value = Mapper.getMapFromInternalHashLinkedMapObjectObject(
            internalHashLinkedMapObjectObject: map,
          );
        }

      },
    );

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

    if (widget.paginatorNotifiers == null){
      _paginatorNotifiers.dispose();
    }

    if (widget.scrollController == null){
      _controller.dispose();
    }

    super.dispose();
  }
  // -----------------------------------------------------------------------------
  bool _canKeepReading = true;
  Future<void> _readMore() async {

    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: true,
      addPostFrameCallBack: false,
    );

    /// CAN KEEP READING
    if (_canKeepReading == true){

      const bool _limitToFirst = true;
      blog('should read more : _limitToFirst : $_limitToFirst : ${_paginatorNotifiers?.startAfter?.value}');

      final List<Map<String, dynamic>> _nextMaps = await Real.readPathMaps(
        context: context,
        startAfter: _paginatorNotifiers.startAfter.value,
        realQueryModel: widget.realQueryModel,
        // addDocIDToEachMap: true,
      );


      if (Mapper.checkCanLoopList(_nextMaps) == true){

        PaginationController.addMapsToLocalMaps(
          mapsToAdd: _nextMaps,
          addAtEnd: true,
          mounted: mounted,
          startAfter: _paginatorNotifiers.startAfter,
          paginatorMaps: _paginatorNotifiers.paginatorMaps,
        );

      }

      else {
        _canKeepReading = false;
      }

    }

    /// NO MORE MAPS TO READ
    else {
      // blog('FireCollPaginator : _readMore : _canKeepReading : $_canKeepReading : NO MORE MAPS AFTER THIS ${_startAfter.toString()}');
    }

    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: false,
      addPostFrameCallBack: false,
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        valueListenable: _paginatorNotifiers.paginatorMaps,
        child: widget.child,
        builder: (_, List<Map<String, dynamic>> maps, Widget child){

          // Mapper.blogMaps(maps, methodName: 'FireCollPaginator : builder');

          return widget.builder(context, maps, _loading.value, child);

        }
    );

  }
// -----------------------------------------------------------------------------
}
