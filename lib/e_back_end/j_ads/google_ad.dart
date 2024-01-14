// import 'package:basics/bldrs_theme/classes/colorz.dart';
// import 'package:basics/bldrs_theme/classes/iconz.dart';
// import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
// import 'package:bldrs/z_components/layouts/main_layout/app_bar/bldrs_app_bar.dart';
// import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
// import 'package:bldrs/e_back_end/j_ads/google_ads.dart';
// import 'package:basics/helpers/files/filers.dart';
// 
// import 'package:flutter/foundation.dart';
//
// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
//
// class GoogleAd extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const GoogleAd({
//     required this.adSize,
//     this.stretchToWidth,
//     this.scale,
//     super.key
//   });
//   /// --------------------------------------------------------------------------
//   final AdSize adSize;
//   final double stretchToWidth;
//   final double scale;
//   /// --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//
//     if (kDebugMode == true) {
//
//       return BldrsBox(
//         height: adSize.height.toDouble(),
//         width: BldrsAppBar.width(),//adSize.width.toDouble(),
//         icon: Iconz.advertise,
//         iconSizeFactor: 0.5,
//         iconColor: Colorz.white10,
//         bubble: false,
//         color: Colorz.white10,
//       );
//
//     }
//
//     else {
//       return GoogleAdStarter(
//         adSize: adSize,
//         scale: scale,
//         stretchToWidth: stretchToWidth,
//       );
//     }
//
//   }
//   /// --------------------------------------------------------------------------
// }
//
// class GoogleAdStarter extends StatefulWidget {
//   /// --------------------------------------------------------------------------
//   const GoogleAdStarter({
//     required this.adSize,
//     this.stretchToWidth,
//     this.scale,
//     super.key
//   });
//   /// --------------------------------------------------------------------------
//   final AdSize adSize;
//   final double stretchToWidth;
//   final double scale;
//   /// --------------------------------------------------------------------------
//   @override
//   _GoogleAdStarterState createState() => _GoogleAdStarterState();
//   /// --------------------------------------------------------------------------
// }
//
// class _GoogleAdStarterState extends State<GoogleAdStarter> {
//   // -----------------------------------------------------------------------------
//   Ad _ad;
//   // -----------------------------------------------------------------------------
//   /// --- LOADING
//   final ValueNotifier<bool> _loading = ValueNotifier(false);
//   // --------------------
//   Future<void> _triggerLoading({required bool setTo}) async {
//     setNotifier(
//       notifier: _loading,
//       mounted: mounted,
//       value: setTo,
//     );
//   }
//   // -----------------------------------------------------------------------------
//   @override
//   void initState() {
//     super.initState();
//   }
//   // --------------------
//   bool _isInit = true;
//   @override
//   void didChangeDependencies() {
//
//     if (_isInit && mounted) {
//       _isInit = false; // good
//
//       _triggerLoading(setTo: true).then((_) async {
//
//         await _initializeBannerAd();
//
//         await _triggerLoading(setTo: false);
//       });
//
//     }
//     super.didChangeDependencies();
//   }
//   // --------------------
//   @override
//   void dispose() {
//     _loading.dispose();
//     super.dispose();
//   }
//   // --------------------
//   @override
//   void didUpdateWidget(covariant GoogleAdStarter oldWidget) {
//
//     if (
//         widget.adSize.width != oldWidget.adSize.width ||
//         widget.adSize.height != oldWidget.adSize.height ||
//         widget.stretchToWidth != oldWidget.stretchToWidth ||
//         widget.scale != oldWidget.scale
//     ) {
//
//       // Future.delayed(Duration.zero, () async {
//
//         // await GoogleAds.disposeAd(_ad);
//
//         // await _initializeBannerAd();
//
//       // });
//
//     }
//
//     super.didUpdateWidget(oldWidget);
//   }
//   // -----------------------------------------------------------------------------
//   /*
//   /// TESTED : WORKS PERFECT
//   Future<void> _initializeBannerAd() async {
//
//
//     final BannerAd _bannerAd = GoogleAds.createBannerAd(
//       adSize: widget.adSize,
//     );
//     await _bannerAd.load();
//
//     setState(() {
//       _ad = _bannerAd;
//     });
//
//     blog('_initializeBannerAd : CREATED NEW AD');
//
//   }
//    */
//   // -----------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//     // --------------------
//     final double _finalWidth = widget.stretchToWidth ?? widget.adSize.width.toDouble();
//     final double _sizingFactor = widget.scale ?? (_finalWidth / widget.adSize.width.toDouble());
//     final double _finalHeight = widget.adSize.height.toDouble() * _sizingFactor;
//
//     return Center(
//       child: ClipRRect(
//         borderRadius: BldrsAppBar.corners,
//         child: Container(
//           width: _finalWidth,
//           height: _finalHeight,
//           decoration: const BoxDecoration(
//             borderRadius: BldrsAppBar.corners,
//             color: Colorz.white10,
//           ),
//           alignment: Alignment.center,
//           child:
//           _ad == null ?
//           const SizedBox()
//               :
//           Transform.scale(
//             scale: _sizingFactor,
//             child: AdWidget(
//               ad: _ad,
//             ),
//           ),
//         ),
//       ),
//     );
//     // --------------------
//   }
// // -----------------------------------------------------------------------------
// }
//
// /// STRIP AD => BANNER
// class GoogleAdStripBanner extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const GoogleAdStripBanner({
//     super.key
//   });
//   /// --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//     return GoogleAd(
//       adSize: AdSize.banner,
//       stretchToWidth: BldrsAppBar.width(),
//     );
//   }
//   /// --------------------------------------------------------------------------
// }
//
// /// RECTANGLE AD => LARGE BANNER
// class GoogleAdRectangleBanner extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const GoogleAdRectangleBanner({
//     super.key
//   });
//   /// --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//     return GoogleAd(
//       adSize: AdSize.largeBanner,
//       stretchToWidth: BldrsAppBar.width(),
//     );
//   }
// /// --------------------------------------------------------------------------
// }
//
// /// SQUARE AD => MEDIUM RECTANGLE
// class GoogleAdSquareBanner extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const GoogleAdSquareBanner({
//     super.key
//   });
//   /// --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//
//     return GoogleAd(
//       adSize: AdSize.mediumRectangle,
//       stretchToWidth: BldrsAppBar.width(),
//     );
//
//   }
//   /// --------------------------------------------------------------------------
// }
//
// /// SLIDE AD => CUSTOM
// class GoogleAdSlideBanner extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const GoogleAdSlideBanner({
//     this.flyerBoxWidth,
//     super.key
//   });
//   /// --------------------------------------------------------------------------
//   final double flyerBoxWidth;
//   /// --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//
//     final double _slideWidth = flyerBoxWidth ?? BldrsAppBar.width();
//
//     return GoogleAd(
//       adSize: AdSize(
//         width: _slideWidth.toInt(),
//         height: FlyerDim.flyerHeightByFlyerWidth(
//           flyerBoxWidth: _slideWidth,
//         ).toInt(),
//       ),
//       stretchToWidth: _slideWidth,
//       scale: 1.08,
//     );
//
//   }
//   /// --------------------------------------------------------------------------
// }
