import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/bz_profile/appbar/bz_credits_counter.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/bz_logo.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/my_bz_screen_pages.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart' as Numeric;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/new_navigators/nav_model.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/new_navigators/obelisk_layout.dart';
import 'package:flutter/material.dart';

class MyBzScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const MyBzScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final BzModel _bzModel = BzzProvider.proGetActiveBzModel(context: context, listen: true);

    return ObeliskLayout(
      isFlashing: ValueNotifier<bool>(false),
      initiallyExpanded: true,
      appBarRowWidgets: <Widget>[

        const Expander(),

        BzCreditsCounter(
          width: Ratioz.appBarButtonSize * 1.4,
          slidesCredit: Numeric.formatNumToCounterCaliber(context, 1234),
          ankhsCredit: Numeric.formatNumToCounterCaliber(context, 123),
        ),

        BzLogo(
          width: 40,
          image: _bzModel.logo,
          margins: const EdgeInsets.symmetric(horizontal: 5),
          corners: superBorderAll(context, Ratioz.appBarCorner - 5),
        ),

      ],
      navModels: <NavModel>[

        ...List.generate(BzModel.bzTabsList.length, (index){

          final BzTab _bzTab = BzModel.bzTabsList[index];

          return NavModel(
            id: NavModel.getBzTabNavID(bzTab: _bzTab, bzID: _bzModel.id),
            title: BzModel.translateBzTab(context: context, bzTab: _bzTab),
            icon: BzModel.getBzTabIcon(_bzTab),
            screen: MyBzScreenPages.pages[index],
          );

        }),

      ],

    );
  }
}
