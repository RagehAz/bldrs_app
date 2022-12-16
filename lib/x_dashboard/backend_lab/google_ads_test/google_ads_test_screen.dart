import 'package:bldrs/a_models/x_utilities/dimensions_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:bldrs/e_back_end/j_ads/google_ads.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
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
  AdSize _adSize;
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

    final Dimensions _screenDims = UiProvider.proGetScreenDimensions(
      context: context,
      listen: false,
    );

    _adSize = AdSize(
      width: _screenDims.width.toInt(),
      height: _screenDims.height.toInt(),
    );

    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {



        final BannerAd _ad = GoogleAds.createBannerAd(
          adSize: _adSize,
        );
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
    final double _neededWidth = BldrsAppBar.width(context);
    final double _scaleFactor = _neededWidth / _adSize.width;
    // --------------------
    return DashBoardLayout(
      loading: _loading,
      listWidgets: <Widget>[

        Center(
          child: Container(
            width: _adSize.width.toDouble() * _scaleFactor,
            height: _adSize.height.toDouble() * _scaleFactor,
            decoration: const BoxDecoration(
              borderRadius: BldrsAppBar.corners,
              color: Colorz.bloodTest,
            ),
            child: ClipRRect(
              borderRadius: BldrsAppBar.corners,
              child:
              _bannerAd == null ?
              const SizedBox()
                  :
              AdWidget(
                ad: _bannerAd,
              ),
            ),
          ),
        ),

      ],
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
