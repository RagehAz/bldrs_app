import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/x_screens/g_bz/a_bz_profile/aa_my_bz_screen_pages.dart';
import 'package:bldrs/b_views/z_components/bz_profile/appbar/bz_credits_counter.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/bz_logo.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/streamers/fire/fire_doc_streamer.dart';
import 'package:bldrs/c_controllers/g_bz_controllers/a_bz_profile/a_my_bz_screen_controllers.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/e_db/fire/foundation/paths.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart' as AuthFireOps;
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart' as Numeric;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/go_back_widget_test.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/new_navigators/nav_model.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/new_navigators/obelisk_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyBzScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const MyBzScreen({
    this.initialTab = BzTab.flyers,
    Key key
  }) : super(key: key);

  final BzTab initialTab;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// NO NEED TO REBUILD WHEN BZ MODEL CHANGES
    final BzzProvider _bzzPro = Provider.of<BzzProvider>(context, listen: false);
    final String bzID = _bzzPro.myActiveBz?.id;

    blog('my bz screen reloaded');

    return FireDocStreamer(
      collName: FireColl.bzz,
      docName: bzID,
      onDataChanged: (BuildContext ctx, Map<String, dynamic> oldMap, Map<String, dynamic> newMap) async {

        final BzzProvider _bzzProvider = Provider.of<BzzProvider>(ctx, listen: false);

        await onMyActiveBzStreamChanged(
          context: ctx,
          oldMap: oldMap,
          newMap: newMap,
          bzzProvider: _bzzProvider,
        );

      },
      builder: (_, Map<String, dynamic> map){


        return Selector<BzzProvider, BzModel>(
          selector: (_, bzzProvider) => bzzProvider.myActiveBz,
          child: Container(),
          builder: (_, BzModel _bzModel, Widget child){

            final bool _areIdentical = BzModel.checkBzzAreIdentical(
                bz1: _bzModel,
                bz2: BzModel.decipherBz(map: map, fromJSON: false),
            );

            blog('MyBzScreen : streamBz == proMyActiveBz ? : $_areIdentical');
            // _bzModel?.blogBz(methodName: 'My Bz Screen : pro bz');

            final bool _authorsContainMyUserID = AuthorModel.checkAuthorsContainUserID(
              authors: _bzModel?.authors,
              userID: AuthFireOps.superUserID(),
            );

            if (_bzModel == null || _authorsContainMyUserID == false){

              blog('my bz screen should go back now yabn el a7ba');

              return const GoBackWidget();

            }

            else {

              return ObeliskLayout(
                initiallyExpanded: true,
                onBack: (){

                  _bzzPro.clearMyActiveBz(notify: false);

                },
                initialIndex: BzModel.getBzTabIndex(initialTab),

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

          },
        );

      },
    );

  }
}
