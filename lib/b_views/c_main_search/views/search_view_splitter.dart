import 'package:bldrs/a_models/k_statistics/record_model.dart';
import 'package:bldrs/b_views/c_main_search/views/flyers_paginator_view.dart';
import 'package:bldrs/b_views/c_main_search/views/users_paginator_view.dart';
import 'package:bldrs/super_fire/super_fire.dart';
import 'package:flutter/material.dart';
import 'bzz_paginator_view.dart';

class SearchViewSplitter extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const SearchViewSplitter({
    @required this.searchType,
    @required this.flyersQuery,
    @required this.flyersController,
    @required this.bzzQuery,
    @required this.bzzController,
    @required this.usersQuery,
    @required this.usersController,
    Key key
  }) : super(key: key);

  final ModelType searchType;
  final FireQueryModel flyersQuery;
  final PaginationController flyersController;
  final FireQueryModel bzzQuery;
  final PaginationController bzzController;
  final FireQueryModel usersQuery;
  final PaginationController usersController;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// FLYERS PAGINATION
    if (searchType == ModelType.flyer){
      return FlyersPaginatorView(
        fireQueryModel: flyersQuery,
        paginationController: flyersController,
      );
    }

    /// BZZ PAGINATION
    else if (searchType == ModelType.bz){
      return BzzPaginatorView(
        fireQueryModel: bzzQuery,
        paginationController: bzzController,
      );
    }

    /// USERS PAGINATION
    else if (searchType == ModelType.user){
      return UsersPaginatorView(
        fireQueryModel: usersQuery,
        paginationController: usersController,
      );
    }

    else {
      return const SizedBox.shrink();
    }

  }
  // -----------------------------------------------------------------------------
}
