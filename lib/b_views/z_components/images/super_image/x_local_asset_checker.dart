// import 'package:bldrs/f_helpers/drafters/floaters.dart';
// import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
// import 'package:bldrs/f_helpers/drafters/tracers.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// class LocalAssetChecker extends StatefulWidget {
//   /// --------------------------------------------------------------------------
//   const LocalAssetChecker({
//     @required this.child,
//     @required this.asset,
//     Key key
//   }) : super(key: key);
//   /// --------------------------------------------------------------------------
//   final Widget child;
//   final dynamic asset;
//   /// --------------------------------------------------------------------------
//   @override
//   State<LocalAssetChecker> createState() => _LocalAssetCheckerState();
//   // ---------------------------------------
//   /// TESTED : WORKS PERFECT
//   static Future<bool> localAssetExists(dynamic asset) async {
//     bool _isFound = false;
//
//     if (asset is String){
//       if (TextCheck.isEmpty(asset) == false){
//
//         final ByteData _bytes = await Floaters.getByteDataFromPath(asset).catchError((Object error){
//
//           // blog('LocalAssetChecker : _checkAsset : error : ${error.toString()}');
//
//           if (error == null){
//             _isFound = true;
//           }{
//             _isFound = false;
//           }
//
//         },);
//
//         _isFound = _bytes != null;
//
//       }
//     }
//
//     return _isFound;
//   }
//   /// --------------------------------------------------------------------------
// }
//
// class _LocalAssetCheckerState extends State<LocalAssetChecker> {
//   // -----------------------------------------------------------------------------
//   /// --- LOADING
//   final ValueNotifier<bool> _loading = ValueNotifier(false);
//   // --------------------
//   Future<void> _triggerLoading({@required bool setTo}) async {
//     setNotifier(
//       notifier: _loading,
//       mounted: mounted,
//       value: setTo,
//     );
//   }
//   // -----------------------------------------------------------------------------
//   final ValueNotifier<bool> _exists = ValueNotifier(false);
//   // -----------------------------------------------------------------------------
//   @override
//   void initState() {
//     super.initState();
//   }
//   // --------------------
//   bool _isInit = true;
//   @override
//   void didChangeDependencies() {
//     if (_isInit && mounted && _exists != null) {
//
//       _triggerLoading(setTo: true).then((_) async {
//
//         final bool _assetExists = await LocalAssetChecker.localAssetExists(widget.asset);
//
//         setNotifier(
//             notifier: _exists,
//             mounted: mounted,
//             value: _assetExists,
//         );
//
//         await _triggerLoading(setTo: false);
//
//       });
//
//       _isInit = false;
//     }
//     super.didChangeDependencies();
//   }
//   // --------------------
//   @override
//   void dispose() {
//     _loading.dispose();
//     _exists.dispose();
//     super.dispose();
//   }
//   // -----------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//
//     if (widget.asset == null){
//       return const SizedBox();
//     }
//
//     else {
//
//       return ValueListenableBuilder(
//           key: const ValueKey<String>('LocalAssetChecker'),
//           valueListenable: _exists,
//           child: widget.child,
//           builder: (_, bool assetExists, Widget child){
//
//             /// WHEN ASSET FOUND
//             if (assetExists == true){
//               return child;
//             }
//
//             /// WHEN ASSET NOT FOUND
//             else {
//               return const SizedBox();
//             }
//
//           }
//       );
//
//     }
//
//   }
// // -----------------------------------------------------------------------------
// }
