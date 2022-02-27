import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/widgets/general/bubbles/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/bz/author_card.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';

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
    final int _numberOfAuthors = _authors.length;

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: _numberOfAuthors + 1,
      itemBuilder: (_, index){

        /// ADD AUTHORS BUTTON
        if (index == _numberOfAuthors){
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              const BubblesSeparator(),

              DreamBox(
                width: Scale.superScreenWidth(context) - 20,
                height: 80,
                bubble: false,
                color: Colorz.white20,
                verseCentered: false,
                verse: 'Add Authors to the team',
                icon: Iconz.plus,
                iconSizeFactor: 0.5,
                verseScaleFactor: 1.4,
                margins: 10,
                corners: AuthorCard.bubbleCornerValue(),
                onTap: (){
                  blog('Should go to add author page naaw');
                },
              ),

            ],
          );
        }

        /// AUTHOR CARDS
        else {
          final AuthorModel _author = _authors[index];
          return AuthorCard(
            author: _author,
            bzModel: bzModel,
          );
        }

        },
    );
  }
}
