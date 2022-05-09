// import 'package:bldrs/a_models/chain/chain.dart';
//
// abstract class ChainEquipment {
//
//   static const Chain chain = Chain(
//     id: 'phid_k_flyer_type_equipment',
//     sons: <Chain>[
//
//       // -----------------------------------------------
//       /// Handheld equipment & tools
//       Chain(
//         id: 'phid_k_group_equip_handheld',
//         sons: <Chain>[
//           // ----------------------------------
//           /// Power tools
//           Chain(
//             id: 'phid_k_sub_handheld_power',
//             sons: <String>[
//               'phid_k_equip_tool_power_drill',
//               'phid_k_equip_tool_power_saw',
//               'phid_k_equip_tool_power_router',
//               'phid_k_equip_tool_power_grinder',
//               'phid_k_equip_tool_power_compressor',
//               'phid_k_equip_tool_power_sander',
//               'phid_k_equip_tool_power_heatGun',
//             ],
//           ),
//           // ----------------------------------
//           /// Measurement tools
//           Chain(
//             id: 'phid_k_sub_handheld_measure',
//             sons: <String>[
//               'phid_k_equip_tool_measure_lasermeter',
//               'phid_k_equip_tool_measure_tapMeasure',
//               'phid_k_equip_tool_measure_theodolite',
//             ],
//           ),
//           // ----------------------------------
//           /// Handheld machinery
//           Chain(
//             id: 'phid_k_sub_handheld_machinery',
//             sons: <String>[
//               'phid_k_equip_handheld_paver',
//               'phid_k_equip_handheld_rammer',
//               'phid_k_equip_handheld_jack',
//               'phid_k_equip_handheld_troweller',
//               'phid_k_equip_handheld_spray',
//             ],
//           ),
//           // ----------------------------------
//           /// Hand tools
//           Chain(
//             id: 'phid_k_sub_handheld_handTools',
//             sons: <String>[
//               'phid_k_equip_tool_hand_workbench',
//               'phid_k_equip_tool_hand_bits',
//               'phid_k_equip_tool_hand_screws',
//               'phid_k_equip_tool_hand_ladder',
//               'phid_k_equip_tool_hand_paint',
//               'phid_k_equip_tool_hand_screwDriver',
//               'phid_k_equip_tool_hand_clamp',
//             ],
//           ),
//           // ----------------------------------
//           /// Garden Tools
//           Chain(
//             id: 'phid_k_sub_handheld_gardenTools',
//             sons: <String>[
//               'phid_k_prd_tool_garden_fork',
//               'phid_k_prd_tool_garden_pruning',
//               'phid_k_prd_tool_garden_wheel',
//               'phid_k_prd_tool_garden_barrel',
//               'phid_k_prd_tool_garden_sprayer',
//               'phid_k_prd_tool_garden_hose',
//               'phid_k_prd_tool_garden_hoseReel',
//               'phid_k_prd_tool_garden_sprinkler',
//               'phid_k_prd_tool_garden_glove',
//             ],
//           ),
//           // ----------------------------------
//           /// Cleaning Tools
//           Chain(
//             id: 'phid_k_sub_handheld_cleaning',
//             sons: <String>[
//               'phid_k_prd_tool_hk_floorcare',
//               'phid_k_prd_tool_hk_mop',
//             ],
//           ),
//           // ----------------------------------
//         ],
//       ),
//       // -----------------------------------------------
//       /// Material handling equipment
//       Chain(
//         id: 'phid_k_group_equip_handling',
//         sons: <String>[
//           'phid_k_equip_mat_crane',
//           'phid_k_equip_mat_conveyor',
//           'phid_k_equip_mat_forklift',
//           'phid_k_equip_mat_hoist',
//         ],
//       ),
//       // -----------------------------------------------
//       /// Heavy machinery
//       Chain(
//         id: 'phid_k_group_equip_heavy',
//         sons: <String>[
//           'phid_k_equip_machinery_stoneCrusher',
//           'phid_k_equip_machinery_tunneling',
//           'phid_k_equip_machinery_mixer',
//           'phid_k_equip_machinery_mixPlant',
//         ],
//       ),
//       // -----------------------------------------------
//       /// Construction preparations
//       Chain(
//         id: 'phid_k_group_equip_prep',
//         sons: <String>[
//          'phid_k_equip_prep_scaffold',
//          'phid_k_equip_prep_cone',
//          'phid_k_equip_prep_signage',
//         ],
//       ),
//       // -----------------------------------------------
//       /// Vehicles
//       Chain(
//         id: 'phid_k_group_equip_vehicle',
//         sons: <Chain>[
//           // ----------------------------------
//           /// Earth moving vehicles
//           Chain(
//             id: 'phid_k_sub_vehicle_earthmoving',
//             sons: <String>[
//               'phid_k_equip_earth_excavator',
//               'phid_k_equip_earth_backhoe',
//               'phid_k_equip_earth_loader',
//               'phid_k_equip_earth_bulldozer',
//               'phid_k_equip_earth_trencher',
//               'phid_k_equip_earth_grader',
//               'phid_k_equip_earth_scrapper',
//               'phid_k_equip_earth_crawlerLoader',
//               'phid_k_equip_earth_crawler',
//               'phid_k_equip_earth_excavator',
//             ],
//           ),
//           // ----------------------------------
//           /// Transporting vehicles
//           Chain(
//             id: 'phid_k_sub_vehicle_transport',
//             sons: <String>[
//               'phid_k_equip_vehicle_dumper',
//               'phid_k_equip_vehicle_tanker',
//               'phid_k_equip_vehicle_mixer',
//             ],
//           ),
//           // ----------------------------------
//           /// Paving vehicles
//           Chain(
//             id: 'phid_k_sub_vehicle_paving',
//             sons: <String>[
//               'phid_k_equip_paving_roller',
//               'phid_k_equip_paving_asphalt',
//               'phid_k_equip_paving_slurry',
//             ],
//           ),
//         ],
//       ),
//       // -----------------------------------------------
//
//     ],
//   );
//
// }
