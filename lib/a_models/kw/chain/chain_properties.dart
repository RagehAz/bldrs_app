import 'package:bldrs/a_models/kw/chain/chain.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;

abstract class ChainProperties {

  static const Chain chain = Chain(
    id: 'phid_k_flyer_type_property',
    icon: Iconz.bxPropertiesOff,
    sons: <Chain>[

      // -----------------------------------------------
      /// Industrial
      Chain(
        id: 'phid_k_ppt_lic_industrial',
        icon: null,
        sons: <String>['phid_k_pt_factory',],
      ),
      // -----------------------------------------------
      /// Educational
      Chain(
        id: 'phid_k_ppt_lic_educational',
        icon: null,
        sons: <String>['phid_k_pt_school',],
      ),
      // -----------------------------------------------
      /// Hotel
      Chain(
        id: 'phid_k_ppt_lic_hotel',
        icon: null,
        sons: <String>['phid_k_pt_hotel'],
      ),
      // -----------------------------------------------
      /// Entertainment
      Chain(
        id: 'phid_k_ppt_lic_entertainment',
        icon: null,
        sons: <String>[
          'phid_k_pt_gallery',
          'phid_k_pt_theatre',
        ],
      ),
      // -----------------------------------------------
      /// Medical
      Chain(
        id: 'phid_k_ppt_lic_medical',
        icon: null,
        sons: <String>[
          'phid_k_pt_clinic',
          'phid_k_pt_hospital',
        ],
      ),
      // -----------------------------------------------
      /// Sports
      Chain(
        id: 'phid_k_ppt_lic_sports',
        icon: null,
        sons: <String>[
          'phid_k_pt_football',
          'phid_k_pt_tennis',
          'phid_k_pt_basketball',
          'phid_k_pt_gym',
        ],
      ),
      // -----------------------------------------------
      /// Residential
      Chain(
        id: 'phid_k_ppt_lic_residential',
        icon: null,
        sons: <String>[
          'phid_k_pt_apartment',
          'phid_k_pt_furnishedApartment',
          'phid_k_pt_loft',
          'phid_k_pt_penthouse',
          'phid_k_pt_chalet',
          'phid_k_pt_twinhouse',
          'phid_k_pt_bungalow',
          'phid_k_pt_villa',
          'phid_k_pt_condo',
          'phid_k_pt_farm',
          'phid_k_pt_townHome',
          'phid_k_pt_sharedRoom',
          'phid_k_pt_duplix',
          'phid_k_pt_hotelApartment',
          'phid_k_pt_studio',
        ],
      ),
      // -----------------------------------------------
      /// Retail
      Chain(
        id: 'phid_k_ppt_lic_retail',
        icon: null,
        sons: <String>[
          'phid_k_pt_store',
          'phid_k_pt_supermarket',
          'phid_k_pt_warehouse',
          'phid_k_pt_hall',
          'phid_k_pt_bank',
          'phid_k_pt_restaurant',
          'phid_k_pt_pharmacy',
          'phid_k_pt_studio',
        ],
      ),
      // -----------------------------------------------
      /// Administration
      Chain(
        id: 'phid_k_ppt_lic_administration',
        icon: null,
        sons: <String>['phid_k_pt_office',],
      ),
      // -----------------------------------------------

    ],
  );

}
