library bldrs_routing;

import 'dart:async';
import 'package:basics/components/super_image/super_image.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/helpers/strings/text_mod.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:basics/legalizer/legalizer.dart';
import 'package:basics/mediator/models/dimension_model.dart';
import 'package:basics/z_grid/z_grid.dart';
import 'package:bldrs/a_models/f_flyer/sub/review_model.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/b_screens/0_logo_screen/logo_screen.dart';
import 'package:bldrs/b_screens/a_home_screen/the_home_screen.dart';
import 'package:bldrs/b_screens/b_user_screens/d_user_preview_screen/user_preview_screen.dart';
import 'package:bldrs/b_screens/c_bz_screens/f_bz_preview_screen/a_bz_preview_screen.dart';
import 'package:bldrs/b_screens/x_situational_screens/banner_screen.dart';
import 'package:bldrs/b_screens/x_situational_screens/delete_my_data_screen.dart';
import 'package:bldrs/b_screens/x_situational_screens/under_construction_screen.dart';
import 'package:bldrs/c_protocols/main_providers/home_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:bldrs/g_flyer/a_flyer_screen/a_flyer_preview_screen.dart';
import 'package:bldrs/g_flyer/b_slide_full_screen/a_slide_full_screen.dart';
import 'package:bldrs/g_flyer/z_components/c_groups/grid/components/flyers_z_grid.dart';
import 'package:bldrs/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/maps/map_pathing.dart';
import 'package:basics/helpers/strings/pathing.dart';
import 'package:basics/helpers/strings/stringer.dart';
import 'package:bldrs/a_models/c_keywords/keyworder.dart';
import 'package:bldrs/c_protocols/keywords_protocols/keywords_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/z_components/layouts/mirage/mirage.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/a_flyers_wall_page/flyers_wall_page.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/b_zones_page/a_zone_page.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/c_user_pages/a_my_profile_page/aaa1_user_profile_page.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/c_user_pages/b_my_saves_page/saved_flyers_screen.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/c_user_pages/c_my_notifications_page/user_notes_page.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/c_user_pages/d_user_follows_page/user_following_page.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/c_user_pages/e_my_settings_page/user_settings_page.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/d_auth_page/auth_page.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/d_my_bz_pages/a_bz_about_page/bz_about_page.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/d_my_bz_pages/b_bz_flyer_page/my_bz_flyers_page.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/d_my_bz_pages/c_bz_team_page/bz_team_page.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/e_app_settings_page/app_settings_page.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/d_my_bz_pages/d_bz_notes_page/bz_notes_page.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/d_my_bz_pages/e_bz_settings_page/bz_settings_page.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';

part 'pathing/a_route_name.dart';
part 'pathing/b_route_pather.dart';
part 'pathing/bldrs_tabber.dart';

part 'routers/a_screen_router.dart';
part 'routers/b_bldrs_nav.dart';
part 'routers/c_mirage_nav.dart';