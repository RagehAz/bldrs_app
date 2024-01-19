library mirage;

import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/components/layers/blur_layer.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/maps/map_pathing.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/helpers/strings/pathing.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/layouts/views/floating_list.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/c_chain/aaa_phider.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/x_utilities/badger.dart';
import 'package:bldrs/b_views/a_starters/b_home_screen/x_home_screen_controllers.dart';
import 'package:bldrs/c_protocols/keywords_protocols/keywords_protocols.dart';
import 'package:bldrs/c_protocols/main_providers/home_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/note_protocols/provider/notes_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs/e_back_end/g_storage/storage_path.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/future_model_builders/bz_builder.dart';
import 'package:bldrs/f_helpers/future_model_builders/bzz_builder.dart';
import 'package:bldrs/f_helpers/tabbing/bldrs_tabber.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/buttons/keywords_buttons/sections_button.dart';
import 'package:bldrs/z_components/buttons/multi_button/a_multi_button.dart';
import 'package:bldrs/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/z_components/layouts/pyramids/khufu.dart';
import 'package:bldrs/z_components/layouts/pyramids/pyramids.dart';
import 'package:bldrs/z_components/notes/x_components/red_dot_badge.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// COMPONENTS

// -----------------------
part 'components/bzz_mirage_button.dart';
part 'components/mirage_button.dart';
part 'components/mirage_pyramid.dart';
part 'components/mirage_strip.dart';
part 'components/mirage_strip_floating_list.dart';
/// CONTROLLERS

// -----------------------
part 'controllers/mirage_keywords_controls.dart';
part 'controllers/mirage_my_bzz_controls.dart';
part 'controllers/mirage_my_user_controls.dart';
/// MODELS

// -----------------------
part 'models/mirage_model.dart';
/// STRIPS

// -----------------------
part 'strips/a_main_mirage_strip.dart';
part 'strips/b1_mirage_1_strip_switcher.dart';
part 'strips/b2_my_bzz_mirage_strip.dart';
part 'strips/b3_sections_mirage_strip.dart';
part 'strips/c1_mirage_2_strip_switcher.dart';
part 'strips/c2_user_tabs_mirage_strip.dart';
part 'strips/c3_bz_tabs_mirage_strip.dart';
part 'strips/d_mirage_3_strip_switcher.dart';
part 'strips/e_mirage_4_strip_switcher.dart';
part 'strips/x_map_son_mirage_strip.dart';
/// STRUCTURE

// -----------------------
part 'structure/mirage_nav_bar.dart';
// -----------------------------------------------------------------------------
