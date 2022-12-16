import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/x_dashboard/backend_lab/google_ads_test/google_ad.dart';
import 'package:bldrs/x_dashboard/zz_widgets/layout/dashboard_layout.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// class GoogleAdsTestScreen extends StatefulWidget {
//   /// --------------------------------------------------------------------------
//   const GoogleAdsTestScreen({
//     Key key
//   }) : super(key: key);
//   /// --------------------------------------------------------------------------
//   @override
//   _GoogleAdsTestScreenState createState() => _GoogleAdsTestScreenState();
// /// --------------------------------------------------------------------------
// }
//
// class _GoogleAdsTestScreenState extends State<GoogleAdsTestScreen> {
//   // -----------------------------------------------------------------------------
//   BannerAd _bannerAd;
//   AdSize _adSize;
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
//   @override
//   void initState() {
//
//     final Dimensions _screenDims = UiProvider.proGetScreenDimensions(
//       context: context,
//       listen: false,
//     );
//
//     _adSize = AdSize(
//       width: _screenDims.width.toInt(),
//       height: _screenDims.width.toInt(),
//     );
//
//     super.initState();
//   }
//   // --------------------
//   bool _isInit = true;
//   @override
//   void didChangeDependencies() {
//     if (_isInit && mounted) {
//
//       _triggerLoading(setTo: true).then((_) async {
//
//
//
//
//         await _triggerLoading(setTo: false);
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
//     super.dispose();
//   }
//   // -----------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//     // --------------------
//     final double _neededWidth = BldrsAppBar.width(context);
//     final double _scaleFactor = _neededWidth / _adSize.width;
//     // --------------------
//     return DashBoardLayout(
//       loading: _loading,
//       listWidgets: <Widget>[
//
//         Center(
//           child: Container(
//             width: _adSize.width.toDouble() * _scaleFactor,
//             height: _adSize.height.toDouble() * _scaleFactor,
//             decoration: const BoxDecoration(
//               borderRadius: BldrsAppBar.corners,
//               color: Colorz.bloodTest,
//             ),
//             child: ClipRRect(
//               borderRadius: BldrsAppBar.corners,
//               child:
//               _bannerAd == null ?
//               const SizedBox()
//                   :
//               AdWidget(
//                 ad: _bannerAd,
//               ),
//             ),
//           ),
//         ),
//
//       ],
//     );
//     // --------------------
//   }
// // -----------------------------------------------------------------------------
// }

class GoogleAdsTestScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const GoogleAdsTestScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    /// --------------------
    final double _neededWidth = BldrsAppBar.width(context);
    // final Dimensions _screenDims = UiProvider.proGetScreenDimensions(
    //   context: context,
    //   listen: false,
    // );
    // final AdSize _adSize = AdSize(
    //   width: _screenDims.width.toInt(),
    //   height: _screenDims.width.toInt(),
    // );
    // final double _scaleFactor = _neededWidth / _adSize.width;
    /// --------------------
    return DashBoardLayout(
      listWidgets: <Widget>[

        /// BANNER
        _Verse('Banner : (320 * 50) : ${AdSize.banner.width} * ${AdSize.banner.height}'),
        const GoogleAdStripBanner(),

        /// ---
        const SizedBox(height: 10,),

        /// FULL BANNER
        _Verse('fullBanner : (468 * 60) : ${AdSize.fullBanner.width} * ${AdSize.fullBanner.height}'),
        GoogleAd(
          adSize: AdSize.fullBanner,
          stretchToWidth: _neededWidth,
        ),

        /// ---
        const SizedBox(height: 10,),

        /// LARGE BANNER
        _Verse('largeBanner : (320 * 100) : ${AdSize.largeBanner.width} * ${AdSize.largeBanner.height}'),
        const GoogleAdRectangleBanner(),

        /// ---
        const SizedBox(height: 10,),

        /// LEADERBOARD
        _Verse('leaderboard : (728 * 90) : ${AdSize.leaderboard.width} * ${AdSize.leaderboard.height}'),
        GoogleAd(
          adSize: AdSize.leaderboard,
          stretchToWidth: _neededWidth,
        ),

        /// ---
        const SizedBox(height: 10,),

        /// MEDIUM RECTANGLE
        _Verse('mediumRectangle : (320 * 250) : ${AdSize.mediumRectangle.width} * ${AdSize.mediumRectangle.height}'),
        const GoogleAdSquareBanner(),

        /// ---
        const SizedBox(height: 10,),

        /// CUSTOM
        const _Verse('custom : (flyer slide)'),
        const GoogleAdSlideBanner(
          flyerBoxWidth: 250,
        ),

        const Horizon(),

      ],
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}

class _Verse extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const _Verse(this.text, {Key key}) : super(key: key);
  /// --------------------------------------------------------------------------
  final String text;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return SuperVerse(
      verse: Verse.plain(text),
      width: BldrsAppBar.width(context),
      centered: false,
      size: 1,
      italic: true,
      margin: const EdgeInsets.all(5),
    );
  }
  /// --------------------------------------------------------------------------
}
