import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/a_slate/d_labels/fff_author_label.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bubbles/bubbles.dart';
import 'package:flutter/material.dart';

class BzAuthorsBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzAuthorsBubble({
    @required this.bzModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final BzModel bzModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return Bubble(
      width: BldrsAppBar.width(context),
      bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
        headlineVerse: const Verse(
          id: 'phid_team',
          translate: true,
        ),
      ),
      columnChildren: <Widget>[

        Container(),

        ...List.generate(bzModel.authors.length, (index){

          final AuthorModel _author = bzModel.authors[index];

          return AuthorLabel(
            flyerBoxWidth: BldrsAppBar.width(context),
            authorID: _author.userID,
            bzModel: bzModel,
            showLabel: true,
            labelIsOn: true,
            onLabelTap: ( ){
              _author.blogAuthor();

              },
          );

        }),

      ],
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
