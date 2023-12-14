import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:basics/helpers/classes/space/borderers.dart';
import 'package:basics/super_box/src/f_super_box_tap_layer/x_tap_layer.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/b_views/j_flyer/a_flyer_screen/xx_header_controllers.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/a_slate/d_labels/ffff_author_pic.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:flutter/material.dart';

class AuthorsWrap extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const AuthorsWrap({
    required this.bzModel,
    required this.boxWidth,
    this.picSize = 50,
    super.key
  });
  // --------------------
  final BzModel? bzModel;
  final double boxWidth;
  final double picSize;
  // -----------------------------------------------------------------------------
  Future<void> onAuthorTap(AuthorModel author) async {

    await onCallTap(
        bzModel: bzModel?.copyWith(
          authors: [author],
        ),
        flyerModel: null,
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final List<AuthorModel>? _authors = bzModel?.authors;

    return Container(
      width: boxWidth,
      // constraints: const BoxConstraints(
      //   maxHeight: 200,
      // ),
      decoration: const BoxDecoration(
        // color: Colorz.white10,
        borderRadius: Borderers.constantCornersAll10,
      ),
      child: Wrap(
        // crossAxisAlignment: CrossAxisAlignment.start,
        runSpacing: 10,
        spacing: 10,
        children: <Widget>[

          if (Lister.checkCanLoop(_authors) == true)
            ...List.generate( _authors!.length, (index){

              final AuthorModel _author = _authors[index];

              return TapLayer(
                width: picSize,
                height: picSize,
                onTap: () => onAuthorTap(_author),
                corners: FlyerDim.authorPicCornersByPicSize(
                  context: context,
                  picSize: picSize,
                ),
                child: AuthorPic(
                  size: picSize,
                  authorPic: _author.picModel?.bytes ?? _author.picPath,
                ),
              );

            }),

        ],
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
