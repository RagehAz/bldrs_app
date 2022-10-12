import 'dart:async';

import 'package:bldrs/e_back_end/c_real/foundation/real.dart';
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
  final ValueNotifier<bool> _canKeepReading = ValueNotifier(true);
  // --------------------
  PaginationController _paginatorNotifiers;
  // -----------------------------------------------------------------------------
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

    widget.realQueryModel.blogModel();

    /// SCROLLING
    _initializeScrollListeners();

    /// PAGINATOR NOTIFIERS
    _initializePaginatorNotifiers();

    /// ON CHILD ADDED TO PATH
    // _initializeOnChildAddedListener();

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
    _canKeepReading.dispose();

    if (_sub != null){
      _sub.cancel();
    }

    if (widget.paginatorNotifiers == null){
      _paginatorNotifiers.dispose();
    }

    if (widget.scrollController == null){
      _controller.dispose();
    }

    super.dispose();
  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  void _initializeScrollListeners(){
    _controller = widget.scrollController ?? ScrollController();
    Scrollers.createPaginationListener(
        controller: _controller,
        isPaginating: _isPaginating,
        canKeepReading: _canKeepReading,
        onPaginate: () async {
          await _readMore();
        }
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _initializePaginatorNotifiers(){
    _paginatorNotifiers = widget.paginatorNotifiers ?? PaginationController.initialize(
      addExtraMapsAtEnd: false,
    );
    _paginatorNotifiers?.activateListeners(
      mounted: mounted,
      onDataChanged: (List<Map<String, dynamic>> maps){

        // Mapper.blogMaps(maps, methodName: 'RealCollPaginator._paginatorNotifiers.onDataChanged');

      },
    );
  }
  // --------------------
  /// streams the entire path at once
  /*
  void _initializeOnChildAddedListener(){

    _sub = RealStream.streamOnChildAddedToPath(
      path: widget.realQueryModel.path,
      onChildAdded: (dynamic map) async {

        // Mapper.blogMap(map, invoker: 'RealCollPaginator.Real.streamPath');

        if (_isInit == false){
          _paginatorNotifiers.addMap.value = Mapper.getMapFromInternalHashLinkedMapObjectObject(
            internalHashLinkedMapObjectObject: map,
          );
        }

      },
    );

  }
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _readMore() async {

    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: true,
      addPostFrameCallBack: false,
    );

    /// CAN KEEP READING
    if (_canKeepReading.value == true){

      // if (_paginatorNotifiers?.startAfter?.value == null){
      //   blog('should read more : ${_paginatorNotifiers.paginatorMaps.value.length} maps');
      // }
      // else {
      //   blog('x ---> should read more : ${_paginatorNotifiers.paginatorMaps.value.length} maps : '
      //       '${_paginatorNotifiers.startAfter.value['id']} : ${_paginatorNotifiers.startAfter.value['sentTime']}');
      // }

      final List<Map<String, dynamic>> _nextMaps = await Real.readPathMaps(
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
        _canKeepReading.value = false;
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

          return widget.builder(context, maps, _loading.value, child);

        }
    );

  }
// -----------------------------------------------------------------------------
}
