import 'package:bldrs/e_db/real/real.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class RealCollPaginator extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const RealCollPaginator({
    @required this.builder,
    this.scrollController,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Widget Function(BuildContext, List<Map<String, dynamic>> maps, bool isLoading) builder;
  final ScrollController scrollController;
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
  bool _canPaginate = true;
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

    if (widget.scrollController == null) {
      _controller.dispose();
    }

    super.dispose();

    /// tamam
  }
// -----------------------------------------------------------------------------
  Future<void> _readMore() async {
    _loading.value = true;

    blog('should read more : startAfter is $_startAfter');

    final List<Map<String, dynamic>> _nextMaps = await Real.readColl(
      context: context,
      collName: 'colors',
      startAfter: _startAfter,
      limit: 7,
      realOrderBy: RealOrderBy.key,
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
}
