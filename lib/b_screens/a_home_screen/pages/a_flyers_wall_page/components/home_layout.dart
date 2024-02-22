import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:basics/components/animators/widget_fader.dart';
import 'package:bldrs/c_protocols/main_providers/home_provider.dart';
import 'package:bldrs/h_navigation/mirage/mirage.dart';
import 'package:bldrs/h_navigation/routing/routing.dart';
import 'package:bldrs/super_dev_test.dart';
import 'package:bldrs/z_components/layouts/download_app_panel/download_app_panel.dart';
import 'package:bldrs/z_components/layouts/main_layout/pre_layout.dart';
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
      // canGoBack: false,
      onBack: Routing.backFromHomeScreen,
      child: Scaffold(
        /// INSETS
        resizeToAvoidBottomInset: true, /// if false : prevents keyboard from pushing pyramids up / bottom sheet
        // resizeToAvoidBottomPadding: false,
        backgroundColor: Colorz.black255,
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
                  key: const ValueKey<String>('k'),
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

              /// ROUTING_TESTER
              // const RoutingTestBar(),

              /// STAR_TEST_BUTTON
              if (showTestButton)
              const TheFastTestButton(
                onTap: superDevTestGoX,
              ),

            ],
          ),
        ),

      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
