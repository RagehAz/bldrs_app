import 'package:bldrs/e_back_end/b_fire/fire_models/fire_query_model.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire.dart';
import 'package:bldrs/e_back_end/z_helpers/paginator_notifiers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scrollers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class FireCollPaginator extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FireCollPaginator({
    @required this.queryModel,
    @required this.builder,
    this.scrollController,
    this.loadingWidget,
    this.child,
    this.paginatorController,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final FireQueryModel queryModel;
  final Widget loadingWidget;
  final ScrollController scrollController;
  final Widget child;
  final PaginationController paginatorController;
  final Widget Function(
      BuildContext context,
      List<Map<String, dynamic>> maps,
      bool isLoading,
      Widget child
      ) builder;
  /// --------------------------------------------------------------------------
  @override
  _FireCollPaginatorState createState() => _FireCollPaginatorState();
  /// --------------------------------------------------------------------------
}

class _FireCollPaginatorState extends State<FireCollPaginator> {
  // -----------------------------------------------------------------------------
  ScrollController _controller;
  // --------------------
  final ValueNotifier<bool> _isPaginating = ValueNotifier(false);
  final ValueNotifier<bool> _canKeepReading = ValueNotifier(true);
  // --------------------
  PaginationController _paginatorController;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void>  _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
      addPostFrameCallBack: false,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    /// LISTEN TO SCROLL
    _initializeScrollListener();

    /// PAGINATOR CONTROLLER
    _initializePaginatorController();

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {

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

    if (widget.paginatorController == null){
      _paginatorController.dispose();
    }

    if (widget.scrollController == null){
      _controller.dispose();
    }

    super.dispose();
  }
  // --------------------
  @override
  void didUpdateWidget(covariant FireCollPaginator oldWidget) {

    _triggerLoading(setTo: true).then((_) async {

      if (
      FireQueryModel.checkQueriesHaveNotChanged(
        model1: oldWidget.queryModel,
        model2: widget.queryModel,
      ) == false
      ){

        _paginatorController.clear();
        _canKeepReading.value = true;
        await _readMore();

      }

    });


    super.didUpdateWidget(oldWidget);
  }
  // -----------------------------------------------------------------------------

    /// INITIALIZATION

  // --------------------
  /// TESTED : WORKS PERFECT
  void _initializeScrollListener(){

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
  void _initializePaginatorController(){

    /// LISTEN TO PAGINATOR CONTROLLER NOTIFIERS (AddMap - replaceMap - deleteMap - onDataChanged)
    _paginatorController = widget.paginatorController ?? PaginationController.initialize(
      addExtraMapsAtEnd: true,
    );
    _paginatorController?.activateListeners(
      mounted: mounted,
      onDataChanged: widget.queryModel.onDataChanged,
    );

  }
  // -----------------------------------------------------------------------------

  /// READING

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

      final List<Map<String, dynamic>> _nextMaps = await Fire.superCollPaginator(
        queryModel: widget.queryModel.copyWith(
          startAfter: _paginatorController.startAfter.value,
        ),
        addDocsIDs: true,
        addDocSnapshotToEachMap: true,
      );

      if (Mapper.checkCanLoopList(_nextMaps) == true){

        PaginationController.addMapsToLocalMaps(
          mapsToAdd: _nextMaps,
          addAtEnd: true,
          mounted: mounted,
          startAfter: _paginatorController.startAfter,
          paginatorMaps: _paginatorController.paginatorMaps,
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
        valueListenable: _paginatorController.paginatorMaps,
        child: widget.child,
        builder: (_, List<Map<String, dynamic>> maps, Widget child){

          // Mapper.blogMaps(maps, methodName: 'FireCollPaginator : builder');

          return widget.builder(context, maps, _loading.value, child);

        }
    );

  }
// -----------------------------------------------------------------------------
}
