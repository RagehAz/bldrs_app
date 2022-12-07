import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/x_dashboard/backend_lab/cache_viewer/cache_viewer_screen.dart';
import 'package:bldrs/x_dashboard/backend_lab/cloud_tests/cloud_functions_test.dart';
import 'package:bldrs/x_dashboard/backend_lab/cloud_tests/dynamic_links_test_screen.dart';
import 'package:bldrs/x_dashboard/backend_lab/cloud_tests/email_test_screen.dart';
import 'package:bldrs/x_dashboard/backend_lab/deck_model_tested.dart';
import 'package:bldrs/x_dashboard/backend_lab/fire_tests/fire_storage_test.dart';
import 'package:bldrs/x_dashboard/backend_lab/fire_tests/pagination_test_screen.dart';
import 'package:bldrs/x_dashboard/backend_lab/fire_tests/streaming_test.dart';
import 'package:bldrs/x_dashboard/backend_lab/ldb_viewer/ldb_manager_screen.dart';
import 'package:bldrs/x_dashboard/backend_lab/real_tests/real_http_test_screen.dart';
import 'package:bldrs/x_dashboard/backend_lab/real_tests/real_test_screen.dart';
import 'package:bldrs/x_dashboard/provider_viewer/provider_viewer_screen.dart';
import 'package:bldrs/x_dashboard/zz_widgets/layout/dashboard_layout.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/zz_widgets/wide_button.dart';
import 'package:flutter/material.dart';

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
              screen: const LDBViewersScreen(),
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

        const DotSeparator(),
        // ---------------------------------------------------

        /// LOCATION
        WideButton(
          verse: Verse.plain('Location Test screen'),
          icon: Iconz.locationPin,
          onTap: () async {
            await Nav.goToNewScreen(
              context: context,
              screen: const RealHttpTestScreen(),
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

        const Horizon(),

      ],
    );

  }
/// --------------------------------------------------------------------------
}
