import 'package:bldrs/e_db/fire/fire_models/query_parameters.dart';
import 'package:bldrs/e_db/fire/foundation/firestore.dart' as Fire;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FireCollPaginator extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FireCollPaginator({
    @required this.queryParameters,
    @required this.builder,
    @required this.scrollController,
    this.loadingWidget,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final QueryParameters queryParameters;
  final Widget Function(BuildContext, List<Map<String, dynamic>>, bool) builder;
  final Widget loadingWidget;
  final ScrollController scrollController;
  /// --------------------------------------------------------------------------
  @override
  _FireCollPaginatorState createState() => _FireCollPaginatorState();
}

class _FireCollPaginatorState extends State<FireCollPaginator> {
// -----------------------------------------------------------------------------
  List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];
  QueryDocumentSnapshot  _startAfter;
  bool _canPaginate = true;
// -----------------------------------------------------------------------------
  /// --- LOCAL LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
// -----------------------------------
  Future<void> _triggerLoading() async {
    _loading.value = !_loading.value;
    blogLoading(
      loading: _loading.value,
      callerName: 'BzAuthorsPage',
    );
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    widget.scrollController.addListener(() async {

      final double _maxScroll = widget.scrollController.position.maxScrollExtent;
      final double _currentScroll = widget.scrollController.position.pixels;
      const double _paginationHeightLight = Ratioz.horizon * 3;

      blog('inn : scroll is at : $_currentScroll');

      if (_maxScroll - _currentScroll <= _paginationHeightLight && _canPaginate == true){

        _canPaginate = false;

        await _readMore();

        _canPaginate = true;

      }

    });

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

    final List<Map<String, dynamic>> _nextMaps = await Fire.readCollectionDocs(
      context: context,
      collName: widget.queryParameters.collName,
      orderBy: widget.queryParameters.orderBy,
      startAfter: _startAfter,
      limit: widget.queryParameters.limit,
      addDocsIDs: true,
      addDocSnapshotToEachMap: true,
      finders: widget.queryParameters.finders,
    );

    if (Mapper.checkCanLoopList(_nextMaps) == true){
      _maps = [..._maps, ..._nextMaps];
      _startAfter = _maps.last['docSnapshot'];
      widget.queryParameters.onDataChanged(_maps);
    }

    _loading.value = false;

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        valueListenable: _loading,
        builder: (_, bool isLoading, Widget child){

          return widget.builder(context, _maps, isLoading);

        }
    );

  }
}
