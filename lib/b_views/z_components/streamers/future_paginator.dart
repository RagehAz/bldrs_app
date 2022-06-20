// import 'package:bldrs/d_providers/flyers_provider.dart';
// import 'package:bldrs/f_helpers/drafters/tracers.dart';
// import 'package:bldrs/f_helpers/theme/ratioz.dart';
// import 'package:flutter/material.dart';
//
// // class FuturePaginator extends StatefulWidget {
// //
// //   const FuturePaginator({
// //     @required this.builder,
// //     @required this.scrollController,
// //     @required this.future,
// //     this.limit = 6,
// //     this.loadingWidget,
// //     Key key
// //   }) : super(key: key);
// //
// //   final Widget Function(BuildContext, List<Map<String, dynamic>>, bool) builder;
// //   final Widget loadingWidget;
// //   final ScrollController scrollController;
// //   final Future<Object> future;
// //   final int limit;
// //
// //   @override
// //   State<FuturePaginator> createState() => _FuturePaginatorState();
// // }
// //
// // class _FuturePaginatorState extends State<FuturePaginator> {
// // // -----------------------------------------------------------------------------
// //   List<dynamic> _object;
// //   QueryDocumentSnapshot  _startAfter;
// //   bool _canPaginate = true;
// // // -----------------------------------------------------------------------------
// //   /// --- LOCAL LOADING BLOCK
// //   final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
// // // -----------------------------------
// //   Future<void> _triggerLoading() async {
// //     _loading.value = !_loading.value;
// //     blogLoading(
// //       loading: _loading.value,
// //       callerName: 'FuturePaginator',
// //     );
// //   }
// // // -----------------------------------------------------------------------------
// //   @override
// //   void initState() {
// //     super.initState();
// //
// //     _object = <dynamic>[];
// //
// //     widget.scrollController.addListener(() async {
// //
// //       final double _maxScroll = widget.scrollController.position.maxScrollExtent;
// //       final double _currentScroll = widget.scrollController.position.pixels;
// //       const double _paginationHeightLight = Ratioz.horizon * 3;
// //
// //       blog('inn : scroll is at : $_currentScroll');
// //
// //       if (_maxScroll - _currentScroll <= _paginationHeightLight && _canPaginate == true){
// //
// //         _canPaginate = false;
// //
// //         await _readMore();
// //
// //         _canPaginate = true;
// //
// //       }
// //
// //     });
// //
// //   }
// // // -----------------------------------------------------------------------------
// //   bool _isInit = true;
// //   @override
// //   void didChangeDependencies() {
// //     if (_isInit && mounted) {
// //
// //       _triggerLoading().then((_) async {
// //
// //         await _readMore();
// //
// //       });
// //
// //       _isInit = false;
// //     }
// //     super.didChangeDependencies();
// //   }
// // // -----------------------------------------------------------------------------
// //   @override
// //   void dispose() {
// //     _loading.dispose();
// //     super.dispose(); /// tamam
// //   }
// // // -----------------------------------------------------------------------------
// //   Future<void> _readMore() async {
// //
// //     _loading.value = true;
// //
// //     final List<dynamic> _nextObject = await widget.future();
// //
// //     if (Mapper.checkCanLoopList(_nextObject) == true){
// //       _object = [..._object, ..._nextObject];
// //       _startAfter = _object.last['docSnapshot'];
// //       widget.queryParameters.onDataChanged(_object);
// //     }
// //
// //     _loading.value = false;
// //
// //   }
// // // -----------------------------------------------------------------------------
// //   @override
// //   Widget build(BuildContext context) {
// //
// //     return FutureBuilder(
// //         future: future,
// //         builder: (_ , AsyncSnapshot<Object> snap){
// //
// //           return Container();
// //
// //         }
// //     );
// //
// //   }
// // }
