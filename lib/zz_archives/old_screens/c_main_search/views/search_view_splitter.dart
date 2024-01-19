import 'package:bldrs/a_models/g_statistics/records/record_type.dart';
import 'package:bldrs/a_models/m_search/search_model.dart';
import 'package:bldrs/zz_archives/old_screens/c_main_search/views/bzz_paginator_view.dart';
import 'package:bldrs/zz_archives/old_screens/c_main_search/views/flyers_paginator_view.dart';
import 'package:bldrs/zz_archives/old_screens/c_main_search/views/history_view.dart';
import 'package:bldrs/zz_archives/old_screens/c_main_search/views/users_paginator_view.dart';
import 'package:bldrs/flyer/z_components/c_groups/grid/flyers_grid.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';

class SearchViewSplitter extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const SearchViewSplitter({
    required this.searchType,
    required this.flyersQuery,
    required this.flyersController,
    required this.bzzQuery,
    required this.bzzController,
    required this.usersQuery,
    required this.usersController,
    required this.onDeleteHistoryModel,
    required this.onHistoryModelTap,
    required this.searchHistoryModels,
    super.key
  });
  // --------------------
  final ModelType? searchType;
  final FireQueryModel? flyersQuery;
  final PaginationController flyersController;
  final FireQueryModel? bzzQuery;
  final PaginationController bzzController;
  final FireQueryModel? usersQuery;
  final PaginationController usersController;
  final Function(SearchModel) onHistoryModelTap;
  final Function(SearchModel) onDeleteHistoryModel;
  final List<SearchModel> searchHistoryModels;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// FLYERS PAGINATION
    if (searchType == ModelType.flyer){
      return FlyersPaginatorView(
        fireQueryModel: flyersQuery,
        paginationController: flyersController,
        gridType: FlyerGridType.zoomable,
        hasResponsiveSideMargin: true,
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

    /// HISTORY VIEW
    else {
      return SearchHistoryView(
        onDeleteHistoryModel: onDeleteHistoryModel,
        onHistoryModelTap: onHistoryModelTap,
        searchHistoryModels: searchHistoryModels,
      );
    }

  }
  // -----------------------------------------------------------------------------
}
