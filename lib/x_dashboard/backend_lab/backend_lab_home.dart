import 'package:bldrs/b_views/z_components/buttons/wide_button.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:bldrs/x_dashboard/backend_lab/affiliate_tests/affiliate_test_screen.dart';
import 'package:bldrs/x_dashboard/backend_lab/cache_viewer/cache_viewer_screen.dart';
import 'package:bldrs/x_dashboard/backend_lab/cloud_tests/cloud_functions_test.dart';
import 'package:bldrs/x_dashboard/backend_lab/cloud_tests/dynamic_links_test_screen.dart';
import 'package:bldrs/x_dashboard/backend_lab/cloud_tests/email_test_screen.dart';
import 'package:bldrs/x_dashboard/backend_lab/deck_model_tested.dart';
import 'package:bldrs/x_dashboard/backend_lab/fire_tests/fire_storage_test.dart';
import 'package:bldrs/x_dashboard/backend_lab/fire_tests/pagination_test_screen.dart';
import 'package:bldrs/x_dashboard/backend_lab/fire_tests/streaming_test.dart';
import 'package:bldrs/x_dashboard/backend_lab/google_ads_test/google_ads_test_screen.dart';
import 'package:bldrs/x_dashboard/backend_lab/permissions_tests/permissions_test_screen.dart';
import 'package:bldrs/x_dashboard/backend_lab/protocols_tester/protocols_tester_screen.dart';
import 'package:bldrs/x_dashboard/backend_lab/real_tests/real_http_test_screen.dart';
import 'package:bldrs/x_dashboard/backend_lab/real_tests/real_test_screen.dart';
import 'package:bldrs/x_dashboard/backend_lab/web_scrapper/web_scrapping_test_screen.dart';
import 'package:bldrs/x_dashboard/provider_viewer/provider_viewer_screen.dart';
import 'package:bldrs/x_dashboard/zones_manager/location_test/locations_test_screen.dart';
import 'package:bldrs/x_dashboard/zz_widgets/dashboard_layout.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:ldb/ldb.dart';

class BackendLabHome extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BackendLabHome({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return DashBoardLayout(
      pageTitle: 'Back End Lab',
      listWidgets: <Widget>[

        // ---------------------------------------------------

        /// LDB VIEWER
        WideButton(
          verse: Verse.plain('LDB Viewer screen'),
          icon: Iconz.form,
          onTap: () async {
            await Nav.goToNewScreen(
              context: context,
              screen: const LDBBrowserScreen(
                docs: LDBDoc.allDocs,
              ),
            );
          },
        ),

        /// PROVIDER VIEWER
        WideButton(
          verse: Verse.plain('Provider Viewer screen'),
          icon: Iconz.check,
          onTap: () async {
            await Nav.goToNewScreen(
              context: context,
              screen: const ProvidersViewerScreen(),
            );
          },
        ),

        const DotSeparator(),
        // ---------------------------------------------------

        /// FIRE PAGINATOR TEST
        if (isRage7() == true)
        WideButton(
          verse: Verse.plain('Fire paginator test'),
          icon: Iconz.statistics,
          onTap: () async {
            await Nav.goToNewScreen(
              context: context,
              screen: const PaginatorTest(),
            );
          },
        ),

        /// FIRE STREAMING TEST
        if (isRage7() == true)
        WideButton(
          verse: Verse.plain('Fire Streaming test'),
          icon: Iconz.statistics,
          onTap: () async {
            await Nav.goToNewScreen(
              context: context,
              screen: const StreamingTest(),
            );
          },
        ),

        /// FIRE STORAGE TEST
        if (isRage7() == true)
        WideButton(
          verse: Verse.plain('Storage test'),
          icon: Iconz.phoneGallery,
          onTap: () async {
            await Nav.goToNewScreen(
              context: context,
              screen: const PicProtocolsTest(),
            );
          },
        ),

        const DotSeparator(),
        // ---------------------------------------------------

        /// CLOUD FUNCTIONS TEST
        if (isRage7() == true)
        WideButton(
          verse: Verse.plain('Cloud Functions test'),
          icon: Iconz.gears,
          onTap: () async {
            await Nav.goToNewScreen(
              context: context,
              screen: const CloudFunctionsTest(),
            );
          },
        ),

        /// DYNAMIC LINKS
        WideButton(
          verse: Verse.plain('Dynamic links test'),
          icon: Iconz.reload,
          onTap: () async {
            await Nav.goToNewScreen(
              context: context,
              screen: const DynamicLinksTestScreen(),
            );
          },
        ),

        /// EMAIL SENDER TEST
        WideButton(
          verse: Verse.plain('Email sender test'),
          icon: Iconz.comEmail,
          onTap: () async {
            await Nav.goToNewScreen(
              context: context,
              screen: const EmailTestScreen(),
            );
          },
        ),

        const DotSeparator(),
        // ---------------------------------------------------

        /// REAL TEST
        if (isRage7() == true)
        WideButton(
          verse: Verse.plain('REAL TEST'),
          icon: Iconz.clock,
          onTap: () async {
            await Nav.goToNewScreen(
              context: context,
              screen: const RealTestScreen(),
            );
          },
        ),

        /// REAL HTTP TEST
        if (isRage7() == true)
        WideButton(
          verse: Verse.plain('REAL HTTP TEST'),
          icon: Iconz.clock,
          onTap: () async {
            await Nav.goToNewScreen(
              context: context,
              screen: const RealHttpTestScreen(),
            );
          },
        ),

        if (isRage7() == true)
        const DotSeparator(),
        // ---------------------------------------------------

        /// LOCATION
        WideButton(
          verse: Verse.plain('Location Test screen'),
          icon: Iconz.locationPin,
          onTap: () async {
            await Nav.goToNewScreen(
              context: context,
              screen: const LocationsTestScreen(),
            );
          },
        ),

        const DotSeparator(),
        // ---------------------------------------------------

        /// CACHE VIEWER
        WideButton(
          verse: Verse.plain('Cache viewer screen'),
          icon: Iconz.dvGouran,
          onTap: () async {
            await Nav.goToNewScreen(
              context: context,
              screen: const CacheViewerScreen(),
            );
          },
        ),

        const DotSeparator(),
        // ---------------------------------------------------

        /// DECK MODEL
        WideButton(
          verse: Verse.plain('Deck Model'),
          icon: Iconz.flyerCollection,
          onTap: () async {
            await Nav.goToNewScreen(
              context: context,
              screen: const DeckModelTester(),
            );
          },
        ),

        const DotSeparator(),
        // ---------------------------------------------------

        /// GOOGLE ADS TEST
        WideButton(
          verse: Verse.plain('Google ads test'),
          icon: Iconz.flyerCollection,
          onTap: () async {
            await Nav.goToNewScreen(
              context: context,
              screen: const GoogleAdsTestScreen(),
            );
          },
        ),

        const DotSeparator(),
        // ---------------------------------------------------

        /// PERMISSIONS TEST
        WideButton(
          verse: Verse.plain('Permissions test'),
          icon: Iconz.yellowAlert,
          onTap: () async {
            await Nav.goToNewScreen(
              context: context,
              screen: const PermissionScreen(),
            );
          },
        ),

        const DotSeparator(),
        // ---------------------------------------------------

        /// WEB SCRAPPING TEST
        WideButton(
          verse: Verse.plain('Web Scrapper'),
          icon: Iconz.comWebsite,
          onTap: () async {
            await Nav.goToNewScreen(
              context: context,
              screen: const WebScrappingTestScreen(),
            );
          },
        ),

        const DotSeparator(),
        // ---------------------------------------------------

        /// PROTOCOLS TESTER
        WideButton(
          icon: Iconz.statistics,
          verse: Verse.plain('Protocols Tester'),
          onTap: () => Nav.goToNewScreen(
              context: context,
              screen: const ProtocolsTester(),
          ),
        ),

        /// AFFILIATE TESTER
        WideButton(
          icon: Iconz.more,
          verse: Verse.plain('Affiliate Tester'),
          onTap: () => Nav.goToNewScreen(
              context: context,
              screen: const AffiliateTestScreen(),
          ),
        ),

        const Horizon(),

      ],
    );

  }
  /// --------------------------------------------------------------------------
}
