import 'package:bldrs/e_db/fire/fire_models/query_models/query_parameters.dart';
import 'package:bldrs/e_db/fire/foundation/firestore.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scrollers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FireCollPaginator extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FireCollPaginator({
    @required this.queryModel,
    @required this.builder,
    @required this.scrollController,
    this.extraMaps,
    this.loadingWidget,
    this.addExtraMapsAtEnd = true,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final FireQueryModel queryModel;
  final Widget Function(BuildContext, List<Map<String, dynamic>>, bool) builder;
  final Widget loadingWidget;
  final ScrollController scrollController;
  final ValueNotifier<List<Map<String, dynamic>>> extraMaps;
  final bool addExtraMapsAtEnd;
  /// --------------------------------------------------------------------------
  @override
  _FireCollPaginatorState createState() => _FireCollPaginatorState();
/// --------------------------------------------------------------------------
}

class _FireCollPaginatorState extends State<FireCollPaginator> {
// -----------------------------------------------------------------------------
  final ValueNotifier<List<Map<String, dynamic>>> _maps = ValueNotifier(<Map<String, dynamic>>[]);
  QueryDocumentSnapshot  _startAfter;
  bool _isPaginating = false;
// -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
// -----------
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'FireCollPaginator',);
    }
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    widget.scrollController.addListener(() async {

      final bool _canPaginate = Scrollers.canPaginate(
        scrollController: widget.scrollController,
        isPaginating: _isPaginating,
        paginationHeight: 0,
      );

        Scrollers.blogScrolling(
          scrollController: widget.scrollController,
          isPaginating: _isPaginating,
          paginationHeight: 0,
        );

      if (_canPaginate == true){

        _isPaginating = true;

        await _readMore();

        _isPaginating = false;

      }

    });

    if (widget.extraMaps != null){
      widget.extraMaps.addListener(() {

        // blog('extra maps changed agoooooooooo');
        // Mapper.blogMaps(widget.extraMaps.value, methodName: 'a7oooooo');

        final List<Map<String, dynamic>> _combinedMaps = _addMapsToLocalMaps(
          mapsToAdd: widget.extraMaps.value,
          addAtEnd: true,
        );
        _maps.value = _combinedMaps;

      });
    }

  }
// -----------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _loading.dispose();
    super.dispose(); /// tamam
  }
// -----------------------------------------------------------------------------
  Future<void> _readMore() async {

    _loading.value = true;

    final List<Map<String, dynamic>> _nextMaps = await Fire.superCollPaginator(
      context: context,
      queryModel: widget.queryModel.copyWith(
        startAfter: _startAfter,
      ),
      addDocsIDs: true,
      addDocSnapshotToEachMap: true,
    );

    if (Mapper.checkCanLoopList(_nextMaps) == true){

      final List<Map<String, dynamic>> _combinedMaps = _addMapsToLocalMaps(
        mapsToAdd: _nextMaps,
        addAtEnd: true,
      );

      _maps.value = _combinedMaps;
      _startAfter = _combinedMaps.last['docSnapshot'];

      if (widget.queryModel.onDataChanged != null){
        widget.queryModel.onDataChanged(_combinedMaps);
      }

    }

    _loading.value = false;

  }
// -----------------------------------------------------------------------------
  List<Map<String, dynamic>> _addMapsToLocalMaps({
    @required List<Map<String, dynamic>> mapsToAdd,
    @required bool addAtEnd,
  }){

    List<Map<String, dynamic>> _combinedMaps = [..._maps.value];

    if (mapsToAdd!= null){
      if (addAtEnd == true){
        _combinedMaps = [..._maps.value, ...mapsToAdd];
      }
      else {
        _combinedMaps = [ ...mapsToAdd, ..._maps.value,];
      }
    }

    return _combinedMaps;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        valueListenable: _loading,
        builder: (_, bool isLoading, Widget child){

          return ValueListenableBuilder(
              valueListenable: _maps,
              builder: (_, List<Map<String, dynamic>> maps, Widget child){

                return widget.builder(context, maps, isLoading);

          }
          );

        }
    );

  }
}
