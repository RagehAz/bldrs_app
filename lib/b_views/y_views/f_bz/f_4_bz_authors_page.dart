import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/widgets/general/bubbles/contacts_bubble.dart';
import 'package:bldrs/b_views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/author_bubble/author_label.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BzAuthorsPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzAuthorsPage({
    @required this.bzModel,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final BzModel bzModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final List<AuthorModel> _authors = bzModel.authors;

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: <Widget>[

        /// AUTHORS
        ...List.generate(_authors.length, (index){

          final AuthorModel _author = _authors[index];

          return AuthorCard(
            author: _author,
            bzModel: bzModel,
          );

        }),

        /// ADD AUTHORS BUTTON
        Align(
          alignment: Aligners.superCenterAlignment(context),
          child: DreamBox(
            height: 60,
            verse: 'Add Authors to the team',
            icon: Iconz.plus,
            iconSizeFactor: 0.6,
            margins: 10,
            onTap: (){
              blog('Should go to add author page naaw');
            },
          ),
        ),

        const Horizon(),

      ],
    );
  }
}

class AuthorCard extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AuthorCard({
    @required this.author,
    @required this.bzModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final AuthorModel author;
  final BzModel bzModel;
  /// --------------------------------------------------------------------------
  static List<FlyerModel> _getNumberOfAuthorFlyers({
    @required AuthorModel author,
    @required BuildContext context,
  }){

    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
    final List<FlyerModel> _bzFlyers = _bzzProvider.myActiveBzFlyer;

    final List<FlyerModel> _authorFlyers = FlyerModel.getFlyersFromFlyersByAuthorID(
      flyers: _bzFlyers,
      authorID: author.userID,
    );

    return _authorFlyers;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // const double _picSize = 80;

    final List<FlyerModel> _authorFlyers = _getNumberOfAuthorFlyers(author: author, context: context);

    final int _authorNumberOfFlyers = _authorFlyers.length;

    return Container(
      width: Scale.appBarWidth(context),
      decoration: BoxDecoration(
        borderRadius: Borderers.superBorderAll(context, Ratioz.appBarCorner),
        color: Colorz.white10,
      ),
      padding: const EdgeInsets.all(Ratioz.appBarPadding),
      child: Column(
        children: <Widget>[

          OldAuthorLabel(
            flyerBoxWidth: Scale.superScreenWidth(context) * 1.5,
            authorID: author.userID,
            bzModel: bzModel,
            showLabel: true,
            authorGalleryCount: _authorNumberOfFlyers,
            labelIsOn: true,
            onTap: null,
          ),

          const SizedBox(
            width: Ratioz.appBarPadding,
            height: Ratioz.appBarPadding,
          ),

          ContactsBubble(
            contacts: author.contacts,
            stretchy: true,
            onTap: (){
              blog('wtfffffffffffffff');
            },
          ),

        ],
      ),
    );
  }
}
