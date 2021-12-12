import 'package:bldrs/helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/helpers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/general/artworks/bldrs_name_logo_slogan.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/views/widgets/general/loading/loading.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class LogoScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const LogoScreen({
    @required this.error,
    @required this.loading,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String error;
  final bool loading;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      pyramids: Iconz.pyramidzYellow,
      appBarType: AppBarType.non,
      loading: loading,
      layoutWidget: Stack(
        children: <Widget>[

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              const LogoSlogan(
                showTagLine: true,
                showSlogan: true,
                sizeFactor: 0.8,
              ),

              const SizedBox(height: Ratioz.appBarMargin,),

              if (loading == true)
              Center(
                child: Loading(
                  loading: loading,
                ),
              ),

              if (error != null)
              SuperVerse(
                verse: error,
                weight: VerseWeight.thin,
              ),

              const SizedBox(height: Ratioz.appBarMargin,),

            ],
          ),

          // // --- SKIP BUTTON
          // BtSkipAuth(),

        ],
      ),
    );
  }
}
