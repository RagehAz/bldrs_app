import 'package:bldrs/b_views/z_components/layouts/custom_layouts/floating_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:filers/filers.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:super_box/super_box.dart';

class SuperBoxTestScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SuperBoxTestScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    const double _height = 40;
    const EdgeInsets _margins = EdgeInsets.only(bottom: 10);
    // --------------------
    return MainLayout(
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      title: const Verse(
        id: 'Dialogs',
        translate: false,
      ),
      skyType: SkyType.black,
      appBarRowWidgets: <Widget>[

        const Expander(),

        AppBarButton(
          verse: Verse.plain(''),
        ),

      ],
      child: FloatingList(
        columnChildren: <Widget>[

          /// Without Icon
          SuperBox(
            height: _height,
            text: 'Text Without icon',
            margins: _margins,
            onTap: () => blog('thing'),
          ),

          /// With Icon
          SuperBox(
            height: _height,
            text: 'Text With icon',
            icon: Iconz.dvRageh,
            margins: _margins,
            onTap: () => blog('thingsss'),
          ),

          /// With Icon
          SuperBox(
            height: _height + 20,
            text: 'Text With small icon',
            icon: Iconz.dvRageh,
            margins: _margins,
            iconSizeFactor: 0.5,
            onTap: () => blog('thingsss'),
          ),

          /// With Icon
          SuperBox(
            height: _height * 2,
            text: 'With small icon',
            icon: Iconz.cleopatra,
            iconSizeFactor: 0.5,
            margins: _margins,
            onTap: () => blog('thingsss'),
          ),

          /// With Icon
          SuperBox(
            height: _height * 0.7,
            icon: Iconz.dvRageh2,
            text: 'R',
            // iconSizeFactor: 0.5,
            margins: _margins,
            onTap: () => blog('thingsss'),
          ),

          /// With Icon
          SuperBox(
            height: _height,
            width: 200,
            // icon: Iconz.dvRageh2,
            text: 'Rageh Mohamed Azzazy',
            // iconSizeFactor: 0.5,
            margins: _margins,
            onTap: () => blog('thingsss'),
          ),

          /// With Icon
          SuperBox(
            height: _height,
            width: 200,
            // icon: Iconz.dvRageh2,
            text: 'Rageh Mohamed Azzazy in two lines',
            // iconSizeFactor: 0.5,
            textMaxLines: 2,
            textScaleFactor: 0.7,
            margins: _margins,
            onTap: () => blog('thingsss'),
          ),

        ],
      ),
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
