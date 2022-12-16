import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/e_back_end/j_ads/google_ads.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/zz_widgets/layout/dashboard_layout.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GoogleAdsTestScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const GoogleAdsTestScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _GoogleAdsTestScreenState createState() => _GoogleAdsTestScreenState();
/// --------------------------------------------------------------------------
}

class _GoogleAdsTestScreenState extends State<GoogleAdsTestScreen> {
  // -----------------------------------------------------------------------------
  BannerAd _bannerAd;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {

        final BannerAd _ad = GoogleAds.createBannerAd();
        await _ad.load();

        setState(() {
          _bannerAd = _ad;
        });

        await _triggerLoading(setTo: false);
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return DashBoardLayout(
      loading: _loading,
      listWidgets: <Widget>[

        if (_bannerAd != null)
        Container(
          width: _bannerAd.size.width.toDouble(),
          height: _bannerAd.size.height.toDouble(),
          decoration: const BoxDecoration(
            borderRadius: BldrsAppBar.corners,
          ),
          child: AdWidget(ad: _bannerAd),
        ),

      ],
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
