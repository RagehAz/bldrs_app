library bldrs_app_bar;
// -----------------------------------------------------------------------------
import 'package:basics/components/super_box/super_box.dart';
import 'package:basics/helpers/animators/sliders.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/components/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/helpers/strings/text_mod.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/g_flyer/z_components/x_helpers/x_flyer_color.dart';
import 'package:bldrs/z_components/buttons/general_buttons/back_anb_search_button.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/layouts/layout_visibility_listener.dart';
import 'package:bldrs/z_components/layouts/main_layout/app_bar/structure/c_app_bar_blur_layer.dart';
import 'package:bldrs/z_components/layouts/main_layout/app_bar/variants/line_with_search_bar.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/static_progress_bar/progress_bar_model.dart';
import 'package:bldrs/z_components/static_progress_bar/static_progress_bar.dart';
import 'package:bldrs/z_components/texting/bldrs_text_field/bldrs_text_field.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_aligners.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// COMPONENTS

// --------------------
part 'components/app_bar_button.dart';
part 'components/app_bar_title.dart';
part 'components/app_bar_zone_button.dart';
part 'components/line_box.dart';
part 'components/scrollable_app_bar_widgets.dart';
// -----------------------------------------------------------------------------

/// STRUCTURE

// --------------------
part 'structure/a_bldrs_app_bar.dart';
part 'structure/b_bldrs_app_bar_tree.dart';
part 'structure/c_first_app_bar_line.dart';
part 'structure/d_search_bar.dart';
part 'structure/e_app_bar_progress_bar.dart';
part 'structure/f_app_bar_filters.dart';
// -----------------------------------------------------------------------------

/// LINES

// --------------------
part 'variants/line_with_back_and_title.dart';
part 'variants/line_with_back_and_title_and_widgets.dart';
part 'variants/line_with_back_and_widgets.dart';
// -----------------------------------------------------------------------------

/// VARIANTS

// --------------------
part 'variants/line_with_back_button_only.dart';
// -----------------------------------------------------------------------------
