import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:basics/components/animators/widget_fader.dart';
import 'package:bldrs/c_protocols/main_providers/home_provider.dart';
import 'package:bldrs/f_helpers/tabbing/bldrs_tabber.dart';
import 'package:bldrs/z_components/layouts/download_app_panel/download_app_panel.dart';
import 'package:bldrs/z_components/layouts/main_layout/pre_layout.dart';
import 'package:bldrs/z_components/layouts/mirage/mirage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeLayout extends StatelessWidget {
  // --------------------------------------------------------------------------
  const HomeLayout({
    super.key
  });
  // --------------------
  ///
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return PreLayout(
      key: const ValueKey<String>('home_screen_tree'),
      connectivitySensorIsOn: true,
      canGoBack: false,
      child: Scaffold(
        /// INSETS
        resizeToAvoidBottomInset: false, /// if false : prevents keyboard from pushing pyramids up / bottom sheet
        // resizeToAvoidBottomPadding: false,
        body: WidgetFader(
          fadeType: FadeType.fadeIn,
          curve: Curves.easeOutSine,
          duration: const Duration(seconds: 1),
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[

              /// SKY
              const Sky(
                key: ValueKey<String>('sky'),
                skyType: SkyType.black,
                // gradientIsOn: false,
              ),

              /// HOME VIEWS
              Selector<HomeProvider, TabController?>(
                  selector: (_, HomeProvider homePro) => homePro.tabBarController,
                  builder: (_, TabController? tabController, Widget? child) {
                    return TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: tabController,
                      children: BldrsTabber.getAllViewsWidgets(),
                    );
                  }
              ),

              /// LAYOUT WIDGET
              const MirageNavBar(),

              /// WEB DOWNLOAD APP PANEL
              if (kIsWeb == true)
                const DownloadAppPanel(),

              // BldrsBox(
              //   height: 60,
              //   width: 60,
              //   icon: Iconz.star,
              //   color: Colorz.bloodTest,
              //   iconSizeFactor: 0.6,
              //   onTap: () async {
              //
              //     await NotesProvider.proSetBadge(
              //         bid: BldrsTabber.bidMySaves,
              //         value: 31,
              //         notify: true,
              //     );
              //
              //     await NotesProvider.proSetBadge(
              //       bid: BldrsTabber.generateBzBid(bzID: 'Gjm747w1UpfsPUlWXtMc', bid: BldrsTabber.bidMyBzTeam),
              //       value: 2,
              //       notify: true,
              //     );
              //
              //     await NotesProvider.proSetBadge(
              //       bid: 'phid_k_flyer_type_equipment/phid_k_group_equip_handling/',
              //       value: 15,
              //       notify: true,
              //     );
              //
              //     // await MirageNav.goToKeyword(
              //     //     phid: 'phid_k_prd_tool_garden_glove',
              //     // );
              //
              //     // await Nav.pushAndRemoveAllBelow(
              //     //     context: context,
              //     //     screen: TheHomeScreen(
              //     //       key: UniqueKey(),
              //     //     ),
              //     // );
              //
              //   },
              // ),

            ],
          ),
        ),

      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
