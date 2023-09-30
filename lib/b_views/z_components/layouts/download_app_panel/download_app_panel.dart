import 'package:basics/animators/widgets/widget_fader.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/classes/space/borderers.dart';
import 'package:basics/helpers/widgets/buttons/stores_buttons/store_button.dart';
import 'package:basics/helpers/widgets/drawing/spacing.dart';
import 'package:bldrs/b_views/z_components/blur/blur_layer.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';

class DownloadAppPanel extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const DownloadAppPanel({
    super.key
  });
  /// ---------------------
  @override
  State<DownloadAppPanel> createState() => _DownloadAppPanelState();
  /// --------------------------------------------------------------------------
}

class _DownloadAppPanelState extends State<DownloadAppPanel> {
  // --------------------------------------------------------------------------
  bool _showPanel = true;
  // ---------------------
  void _onHide(){
    setState(() {
      _showPanel = !_showPanel;
    });
  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    const double _buttonHeight = 40;
    const double _spacing = 10;
    final double _buttonWidth = StoreButton.getWidth(context: context, heightOverride: _buttonHeight);
    final double _boxWidth = _buttonWidth + (_spacing * 2);

    if (_showPanel == true){
      return WidgetFader(
        key: const ValueKey('DownloadAppPanel.show'),
        fadeType: FadeType.fadeOut,
        curve: Curves.fastOutSlowIn,
        duration: const Duration(seconds: 2),
        builder: (double val, Widget? child){

          return Transform.translate(
            offset: Offset(-_boxWidth * val, 0),
            child: child,
          );

          },
        child: DownloadPanel(
          onHide: _onHide,
        ),
      );
    }

    else {
      return WidgetFader(
        key: const ValueKey('DownloadAppPanel.hide'),
        fadeType: FadeType.fadeOut,
        curve: Curves.easeOut,
        duration: const Duration(seconds: 1),
        child: DownloadPanel(
          onHide: _onHide,
        ),
      );
    }

  }
  // --------------------------------------------------------------------------
}

class DownloadPanel extends StatelessWidget {
  // --------------------------------------------------------------------------
  const DownloadPanel({
    required this.onHide,
    super.key
  });
  // -------------------
  final Function onHide;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    const double _buttonHeight = 40;
    const double _spacing = 10;
    final double _buttonWidth = StoreButton.getWidth(context: context, heightOverride: _buttonHeight);
    final double _boxWidth = _buttonWidth + (_spacing * 2);

    const double _topAreaHeight = _buttonHeight;
    const double _noticeHeight = _buttonHeight * 0.8;
    const double _hideHeight = _buttonHeight * 0.6;

    const double _boxHeight =
              (_buttonHeight * 2)
            + (_spacing * 6)
            + _topAreaHeight
            + _noticeHeight
            + _hideHeight;

    return Material(
      child: BlurLayer(
        width: _boxWidth,
        blurIsOn: true,
        height: _boxHeight,
        color: Colorz.yellow125,
        borders: Borderers.cornerOnly(
          appIsLTR: true,
          enBottomRight: _spacing,
          enTopRight: _spacing,
        ),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[

            const Spacing(),

            BldrsBox(
              width: _buttonWidth,
              height: _topAreaHeight,
              icon: Iconz.bldrsAppIcon,
              verse: getVerse('phid_download_app'),
              verseColor: Colorz.black255,
              verseScaleFactor: 0.7,
              verseMaxLines: 2,
              verseWeight: VerseWeight.black,
              verseItalic: true,
              verseCentered: false,
              bubble: false,
            ),

            const Spacing(),

            StoreButton(
              storeType: StoreType.appStore,
              onTap: () => Launcher.launchURL(Standards.iosAppStoreURL),
              height: _buttonHeight,
            ),

            const Spacing(),

            StoreButton(
              storeType: StoreType.googlePlay,
              onTap: () => Launcher.launchURL(Standards.androidAppStoreURL),
              height: _buttonHeight,
            ),

            const Spacing(),

            BldrsText(
              verse: getVerse('phid_better_performance_features'),
              height: _noticeHeight,
              width: _buttonWidth,
              color: Colorz.black255,
              appIsLTR: UiProvider.checkAppIsLeftToRight(),
              textDirection: UiProvider.getAppTextDir(),
              scaleFactor: _noticeHeight * 0.02,
              maxLines: 3,
            ),

            const Spacing(),

            BldrsText(
              verse: getVerse('phid_hide'),
              height: _hideHeight,
              width: _buttonWidth,
              color: Colorz.black255,
              appIsLTR: UiProvider.checkAppIsLeftToRight(),
              textDirection: UiProvider.getAppTextDir(),
              scaleFactor: _noticeHeight * 0.02,
              labelColor: Colorz.white200,
              maxLines: 3,
              onTap: onHide,
            ),

            const Spacing(),

          ],
        ),
      ),
    );

  }
  // --------------------------------------------------------------------------
}
