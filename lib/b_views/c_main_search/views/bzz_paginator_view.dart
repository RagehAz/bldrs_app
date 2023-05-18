import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/super_fire/super_fire.dart';
import 'package:bldrs/b_views/f_bz/z_components/bzz_list.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';

class BzzPaginatorView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzzPaginatorView({
    @required this.paginationController,
    @required this.fireQueryModel,
    Key key
  }) : super(key: key);
  // --------------------
  final FireQueryModel fireQueryModel;
  final PaginationController paginationController;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return  FireCollPaginator(
        paginationQuery: fireQueryModel,
        paginationController: paginationController,
        builder: (_, List<Map<String, dynamic>> maps, bool isLoading, Widget child){

          final List<BzModel> _bzz = BzModel.decipherBzz(
              maps: maps,
              fromJSON: false,
          );

          return BzzList(
            width: Scale.screenWidth(context),
            bzz: _bzz,
            scrollController: paginationController.scrollController,
            scrollPadding: Stratosphere.getStratosphereSandwich(
                context: context,
                appBarType: AppBarType.search,
            ),
          );

        },
      );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}