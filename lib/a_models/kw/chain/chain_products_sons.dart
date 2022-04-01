import 'package:bldrs/a_models/kw/chain/chain.dart';

const Chain appliancesChain = Chain(
  id: 'phid__group_prd_appliances',
  icon: 'id',
  phraseID: 'phid_k_group_prd_appliances',
  sons: <Chain>[
    // ----------------------------------
    /// Waste Disposal Appliances
    Chain(
      id: 'phid_k_sub_prd_app_wasteDisposal',
      icon: null,
      phraseID: 'phid_k_sub_prd_app_wasteDisposal',
      sons: <String>[
        'phid_k_prd_app_waste_compactor',
        'phid_k_prd_app_waste_disposer',
      ],
    ),
    // ----------------------------------
    /// Snacks Appliances
    Chain(
      id: 'phid_k_sub_prd_app_snacks',
      icon: null,
      phraseID: 'phid_k_sub_prd_app_snacks',
      sons: <String>[
        'phid_k_prd_app_snack_icecream',
        'phid_k_prd_app_snack_popcorn',
        'phid_k_prd_app_snack_toaster',
        'phid_k_prd_app_snack_waffle',
        'phid_k_prd_app_snack_bread',
        'phid_k_prd_app_snack_canOpener',

      ],
    ),
    // ----------------------------------
    /// Refrigeration
    Chain(
      id: 'phid_k_sub_prd_app_refrigeration',
      icon: null,
      phraseID: 'phid_k_sub_prd_app_refrigeration',
      sons: <String>[
        'phid_k_prd_app_ref_fridge',
        'phid_k_prd_app_ref_freezer',
        'phid_k_prd_app_ref_icemaker',
        'phid_k_prd_app_ref_water',

      ],
    ),
    // ----------------------------------
    /// Outdoor Cooking
    Chain(
      id: 'phid_k_sub_prd_app_outdoorCooking',
      icon: null,
      phraseID: 'phid_k_sub_prd_app_outdoorCooking',
      sons: <String>[
        'phid_k_prd_app_outcook_grill',
        'phid_k_prd_app_outcook_grillTools',
        'phid_k_prd_app_outcook_oven',
        'phid_k_prd_app_outcook_smoker',
      ],
    ),
    // ----------------------------------
    /// Media Appliances
    Chain(
      id: 'phid_k_sub_prd_app_media',
      icon: null,
      phraseID: 'phid_k_sub_prd_app_media',
      sons: <String>[
        'phid_k_prd_app_media_tv',
        'phid_k_prd_app_media_soundSystem',
      ],
    ),
    // ----------------------------------
    /// Indoor Cooking
    Chain(
      id: 'phid_k_sub_prd_app_indoorCooking',
      icon: null,
      phraseID: 'phid_k_sub_prd_app_indoorCooking',
      sons: <String>[
        'phid_k_prd_app_incook_microwave',
        'phid_k_prd_app_incook_fryer',
        'phid_k_prd_app_incook_elecGrill',
        'phid_k_prd_app_incook_cooktop',
        'phid_k_prd_app_incook_range',
        'phid_k_prd_app_incook_oven',
        'phid_k_prd_app_incook_hood',
        'phid_k_prd_app_incook_skillet',
        'phid_k_prd_app_incook_rooster',
        'phid_k_prd_app_incook_hotPlate',
      ],
    ),
    // ----------------------------------
    /// HouseKeeping Appliances
    Chain(
      id: 'phid_k_sub_prd_app_housekeeping',
      icon: null,
      phraseID: 'phid_k_sub_prd_app_housekeeping',
      sons: <String>[
        'phid_k_prd_app_hk_washingMachine',
        'phid_k_prd_app_hk_dishWasher',
        'phid_k_prd_app_hk_warmingDrawers',
        'phid_k_prd_app_hk_vacuum',
        'phid_k_prd_app_hk_iron',
        'phid_k_prd_app_hk_steamer',
        'phid_k_prd_app_hk_carpet',
        'phid_k_prd_app_hk_sewing',
      ],
    ),
    // ----------------------------------
    /// Food Processors
    Chain(
      id: 'phid_k_sub_prd_app_foodProcessors',
      icon: null,
      phraseID: 'phid_k_sub_prd_app_foodProcessors',
      sons: <String>[
        'phid_k_prd_app_pro_slowCooker',
        'phid_k_prd_app_pro_pro',
        'phid_k_prd_app_pro_meat',
        'phid_k_prd_app_pro_rice',
        'phid_k_prd_app_pro_dehydrator',
        'phid_k_prd_app_pro_mixer',
      ],
    ),
    // ----------------------------------
    /// Drinks Appliances
    Chain(
      id: 'phid_k_sub_prd_app_drinks',
      icon: null,
      phraseID: 'phid_k_sub_prd_app_drinks',
      sons: <String>[
        'phid_k_prd_app_drink_coffeeMaker',
        'phid_k_prd_app_drink_coffeeGrinder',
        'phid_k_prd_app_drink_espresso',
        'phid_k_prd_app_drink_blender',
        'phid_k_prd_app_drink_juicer',
        'phid_k_prd_app_drink_kettle',
      ],
    ),
    // ----------------------------------
    /// Bathroom Appliances
    Chain(
      id: 'phid_k_sub_prd_app_bathroom',
      icon: null,
      phraseID: 'phid_k_sub_prd_app_bathroom',
      sons: <String>[
        'phid_k_prd_app_bath_handDryer',
        'phid_k_prd_app_bath_hairDryer',
      ],
    ),

  ],
);

const Chain doorsAndWindowsChain = Chain(
  id: 'phid_k_group_prd_doors',
  icon: 'id',
  phraseID: 'phid_k_group_prd_doors',
  sons: <Chain>[
    // ----------------------------------
    /// Windows
    Chain(
      id: 'phid_k_sub_prd_door_windows',
      icon: null,
      phraseID: 'phid_k_sub_prd_door_windows',
      sons: <String>[
        'phid_k_prd_doors_win_glassPanel',
        'phid_k_prd_doors_win_skyLight',
      ],
    ),
    // ----------------------------------
    /// Shutters
    Chain(
      id: 'phid_k_sub_prd_doors_shutters',
      icon: null,
      phraseID: 'phid_k_sub_prd_doors_shutter',
      sons: <String>[
        'phid_k_prd_doors_shutters_metal',
        'phid_k_prd_doors_shutters_aluminum',
      ],
    ),
    // ----------------------------------
    /// Hardware
    Chain(
      id: 'phid_k_sub_prd_door_hardware',
      icon: null,
      phraseID: 'phid_k_sub_prd_door_hardware',
      sons: <String>[
        'phid_k_prd_doors_hardware_hinges',
        'phid_k_prd_doors_hardware_doorbell',
        'phid_k_prd_doors_hardware_entrySet',
        'phid_k_prd_doors_hardware_lever',
        'phid_k_prd_doors_hardware_knob',
        'phid_k_prd_doors_hardware_knocker',
        'phid_k_prd_doors_hardware_lock',
        'phid_k_prd_doors_hardware_stop',
        'phid_k_prd_doors_hardware_sliding',
        'phid_k_prd_doors_hardware_hook',
        'phid_k_prd_doors_hardware_eye',
        'phid_k_prd_doors_hardware_sign',
        'phid_k_prd_doors_hardware_dust',
        'phid_k_prd_doors_hardware_closer',
        'phid_k_prd_doors_hardware_tint',
      ],
    ),
    // ----------------------------------
    /// Doors
    Chain(
      id: 'phid_k_sub_prd_door_doors',
      icon: null,
      phraseID: 'phid_k_sub_prd_door_doors',
      sons: <String>[
        'phid_k_prd_doors_doors_front',
        'phid_k_prd_doors_doors_interior',
        'phid_k_prd_doors_doors_folding',
        'phid_k_prd_doors_doors_shower',
        'phid_k_prd_doors_doors_patio',
        'phid_k_prd_doors_doors_screen',
        'phid_k_prd_doors_doors_garage',
        'phid_k_prd_doors_doors_metalGate',
        'phid_k_prd_doors_doors_escape',
        'phid_k_prd_doors_doors_blast',

      ],
    ),

  ],
);

const Chain electricityChain = Chain(
  id: 'phid_k_group_prd_electricity',
  icon: 'id',
  phraseID: 'phid_k_group_prd_electricity',
  sons: <Chain>[
    // ----------------------------------
    /// Power Storage
    Chain(
      id: 'phid_k_sub_prd_elec_powerStorage',
      icon: null,
      phraseID: 'phid_k_sub_prd_elec_powerStorage',
      sons: <String>[
        'phid_k_prd_elec_storage_rechargeable',
        'phid_k_prd_elec_storage_nonRechargeable',
        'phid_k_prd_elec_storage_accessories',
        'phid_k_prd_elec_storage_portable',
      ],
    ),
    // ----------------------------------
    /// Electricity Organizers
    Chain(
      id: 'phid_k_sub_prd_elec_organization',
      icon: null,
      phraseID: 'phid_k_sub_prd_elec_organization',
      sons: <String>[
        'phid_k_prd_elec_org_load',
        'phid_k_prd_elec_org_conduit',
        'phid_k_prd_elec_org_junction',
        'phid_k_prd_elec_org_hook',

      ],
    ),
    // ----------------------------------
    /// Electricity Instruments
    Chain(
      id: 'phid_k_sub_prd_elec_instruments',
      icon: null,
      phraseID: 'phid_k_sub_prd_elec_instruments',
      sons: <String>[
        'phid_k_prd_elec_instr_factor',
        'phid_k_prd_elec_instr_measure',
        'phid_k_prd_elec_instr_clamp',
        'phid_k_prd_elec_instr_powerMeter',
        'phid_k_prd_elec_instr_resistance',
        'phid_k_prd_elec_instr_transformer',
        'phid_k_prd_elec_instr_frequency',
        'phid_k_prd_elec_instr_relay',
        'phid_k_prd_elec_inst_dc',
        'phid_k_prd_elec_inst_inverter',
        'phid_k_prd_elec_inst_regulator',
      ],
    ),
    // ----------------------------------
    /// Electricity Generators
    Chain(
      id: 'phid_k_sub_prd_elec_generators',
      icon: null,
      phraseID: 'phid_k_sub_prd_elec_generators',
      sons: <String>[
        'phid_k_prd_elec_gen_solar',
        'phid_k_prd_elec_gen_wind',
        'phid_k_prd_elec_gen_hydro',
        'phid_k_prd_elec_gen_steam',
        'phid_k_prd_elec_gen_diesel',
        'phid_k_prd_elec_gen_gasoline',
        'phid_k_prd_elec_gen_gas',
        'phid_k_prd_elec_gen_hydrogen',
      ],
    ),
    // ----------------------------------
    /// Electrical Switches
    Chain(
      id: 'phid_k_sub_prd_elec_switches',
      icon: null,
      phraseID: 'phid_k_sub_prd_elec_switches',
      sons: <String>[
        'phid_k_prd_elec_switches_outlet',
        'phid_k_prd_elec_switches_thermostat',
        'phid_k_prd_elec_switches_dimmer',
        'phid_k_prd_elec_switches_plate',
        'phid_k_prd_elec_switches_circuit',
        'phid_k_prd_elec_switches_doorbell',
      ],
    ),
    // ----------------------------------
    /// Electrical Motors
    Chain(
      id: 'phid_k_sub_prd_elec_motors',
      icon: null,
      phraseID: 'phid_k_sub_prd_elec_motors',
      sons: <String>[
        'phid_k_prd_elec_motor_ac',
        'phid_k_prd_elec_motor_dc',
        'phid_k_prd_elec_motor_vibro',
        'phid_k_prd_elec_motor_controller',
        'phid_k_prd_elec_motor_part',
      ],
    ),
    // ----------------------------------
    /// Electrical Connectors
    Chain(
      id: 'phid_k_sub_prd_elec_connectors',
      icon: null,
      phraseID: 'phid_k_sub_prd_elec_connectors',
      sons: <String>[
        'phid_k_prd_elec_connectors_alligator',
        'phid_k_prd_elec_connectors_connector',
        'phid_k_prd_elec_connectors_terminal',
        'phid_k_prd_elec_connectors_strip',
        'phid_k_prd_elec_connectors_socket',
        'phid_k_prd_elec_connectors_adapter',
      ],
    ),
    // ----------------------------------
    /// Cables & Wires
    Chain(
      id: 'phid_k_sub_prd_elec_cables',
      icon: null,
      phraseID: 'phid_k_sub_prd_elec_cables',
      sons: <String>[
        'phid_k_prd_elec_cables_wire',
        'phid_k_prd_elec_cables_extension',
      ],
    ),
  ],
);

const Chain fireFightingChain = Chain(
  id: 'phid_k_group_prd_fireFighting',
  icon: 'id',
  phraseID: 'phid_k_group_prd_fireFighting',
  sons: <Chain>[
    // ----------------------------------
    /// Pumps & Controllers
    Chain(
      id: 'phid_k_sub_prd_fire_pumpsCont',
      icon: null,
      phraseID: 'phid_k_sub_prd_fire_pumpsCont',
      sons: <String>[
        'phid_k_prd_fireFighting_pump_pump',
        'phid_k_prd_fireFighting_pump_filter',
        'phid_k_prd_fireFighting_pump_system',
        'phid_k_prd_fireFighting_pump_foamSystems',
        'phid_k_prd_fireFighting_pump_gasSystems',
      ],
    ),
    // ----------------------------------
    /// Fire Fighting Equipment
    Chain(
      id: 'phid_k_sub_prd_fire_equip',
      icon: null,
      phraseID: 'phid_k_sub_prd_fire_equip',
      sons: <String>[
        'phid_k_prd_fireFighting_equip_hydrant',
        'phid_k_prd_fireFighting_equip_extinguisher',
        'phid_k_prd_fireFighting_equip_pipe',
        'phid_k_prd_fireFighting_equip_reel',
        'phid_k_prd_fireFighting_equip_hose',
        'phid_k_prd_fireFighting_equip_curtains',
      ],
    ),
    // ----------------------------------
    /// Fire Fighting Cloth
    Chain(
      id: 'phid_k_sub_prd_fire_clothes',
      icon: null,
      phraseID: 'phid_k_sub_prd_fire_clothes',
      sons: <String>[
        'phid_k_prd_fireFighting_equip_suit',
        'phid_k_prd_fireFighting_equip_helmet',
        'phid_k_prd_fireFighting_equip_glove',
        'phid_k_prd_fireFighting_equip_boots',
        'phid_k_prd_fireFighting_equip_torches',
        'phid_k_prd_fireFighting_equip_breathing',
      ],
    ),
    // ----------------------------------
    /// Fire Detectors
    Chain(
      id: 'phid_k_sub_prd_fire_detectors',
      icon: null,
      phraseID: 'phid_k_sub_prd_fire_detectors',
      sons: <String>[
        'phid_k_prd_fireFighting_detectors_alarm',
        'phid_k_prd_fireFighting_detectors_control',
      ],
    ),
  ],
);

const Chain floorsAndSkirtingChain = Chain(
  id: 'phid_k_group_prd_floors',
  icon: 'id',
  phraseID: 'phid_k_group_prd_floors',
  sons: <Chain>[
    // ----------------------------------
    /// Skirting
    Chain(
      id: 'phid_k_sub_prd_floors_skirting',
      icon: null,
      phraseID: 'phid_k_sub_prd_floors_skirting',
      sons: <String>[
        'phid_k_prd_floors_skirting_skirting',
      ],
    ),
    // ----------------------------------
    /// Floor Tiles
    Chain(
      id: 'phid_k_sub_prd_floors_tiles',
      icon: null,
      phraseID: 'phid_k_sub_prd_floors_tiles',
      sons: <String>[
        'phid_k_prd_floors_tiles_ceramic',
        'phid_k_prd_floors_tiles_porcelain',
        'phid_k_prd_floors_tiles_mosaic',
        'phid_k_prd_floors_tiles_stones',
        'phid_k_prd_floors_tiles_marble',
        'phid_k_prd_floors_tiles_granite',
        'phid_k_prd_floors_tiles_interlock',
        'phid_k_prd_floors_tiles_cork',
        'phid_k_prd_floors_tiles_parquet',
        'phid_k_prd_floors_tiles_glass',
        'phid_k_prd_floors_tiles_grc',
        'phid_k_prd_floors_tiles_metal',
        'phid_k_prd_floors_tiles_terrazzo',
        'phid_k_prd_floors_tiles_medallions',
      ],
    ),
    // ----------------------------------
    /// Floor Planks
    Chain(
      id: 'phid_k_sub_prd_floors_planks',
      icon: null,
      phraseID: 'phid_k_sub_prd_floors_planks',
      sons: <String>[
        'phid_k_prd_floors_planks_bamboo',
        'phid_k_prd_floors_planks_engineered',
        'phid_k_prd_floors_planks_hardwood',
        'phid_k_prd_floors_planks_laminate',
        'phid_k_prd_floors_planks_wpc',
      ],
    ),
    // ----------------------------------
    /// Floor Paving
    Chain(
      id: 'phid_k_sub_prd_floors_paving',
      icon: null,
      phraseID: 'phid_k_sub_prd_floors_paving',
      sons: <String>[
        'phid_k_prd_floors_paving_screed',
        'phid_k_prd_floors_paving_epoxy',
        'phid_k_prd_floors_paving_asphalt',
      ],
    ),
    // ----------------------------------
    /// Floor Covering
    Chain(
      id: 'phid_k_sub_prd_floors_covering',
      icon: null,
      phraseID: 'phid_k_sub_prd_floors_covering',
      sons: <String>[
        'phid_k_prd_floors_covering_vinyl',
        'phid_k_prd_floors_covering_carpet',
        'phid_k_prd_floors_covering_raised',
        'phid_k_prd_floors_covering_rubber',
      ],
    ),
  ],
);

const Chain furnitureChain = Chain(
  id: 'phid_k_group_prd_furniture',
  icon: 'id',
  phraseID: 'phid_k_group_prd_furniture',
  sons: <Chain>[
    // ----------------------------------
    /// Waste Disposal
    Chain(
      id: 'phid_k_sub_prd_furn_wasteDisposal',
      icon: null,
      phraseID: 'phid_k_sub_prd_furn_wasteDisposal',
      sons: <String>[
        'phid_k_prd_furn_waste_small',
        'phid_k_prd_furn_waste_large',
        'phid_k_prd_furn_waste_pull',
      ],
    ),
    // ----------------------------------
    /// Vanity Tops
    Chain(
      id: 'phid_k_sub_prd_furn_tops',
      icon: null,
      phraseID: 'phid_k_sub_prd_furn_tops',
      sons: <String>[
        'phid_k_prd_furn_tops_bathVanity',
        'phid_k_prd_furn_tops_kit',
      ],
    ),
    // ----------------------------------
    /// Tables
    Chain(
      id: 'phid_k_sub_prd_furn_tables',
      icon: null,
      phraseID: 'phid_k_sub_prd_furn_tables',
      sons: <String>[
        'phid_k_prd_furn_tables_dining',
        'phid_k_prd_furn_tables_bistro',
        'phid_k_prd_furn_tables_coffee',
        'phid_k_prd_furn_tables_folding',
        'phid_k_prd_furn_tables_console',
        'phid_k_prd_furn_tables_meeting',
        'phid_k_prd_furn_tables_side',
      ],
    ),
    // ----------------------------------
    /// Seating Benches
    Chain(
      id: 'phid_k_sub_prd_furn_seatingBench',
      icon: null,
      phraseID: 'phid_k_sub_prd_furn_seatingBench',
      sons: <String>[
        'phid_k_prd_furn_bench_shower',
        'phid_k_prd_furn_bench_bedVanity',
        'phid_k_prd_furn_bench_bedBench',
        'phid_k_prd_furn_bench_storage',
      ],
    ),
    // ----------------------------------
    /// Planting
    Chain(
      id: 'phid_k_sub_prd_furn_planting',
      icon: null,
      phraseID: 'phid_k_sub_prd_furn_planting',
      sons: <String>[
        'phid_k_prd_furn_planting_stand',
        'phid_k_prd_furn_planting_potting',
        'phid_k_prd_furn_planting_pot',
        'phid_k_prd_furn_planting_vase',
      ],
    ),
    // ----------------------------------
    /// Outdoor Tables
    Chain(
      id: 'phid_k_sub_prd_furn_outTables',
      icon: null,
      phraseID: 'phid_k_sub_prd_furn_outTables',
      sons: <String>[
        'phid_k_prd_furn_outTable_coffee',
        'phid_k_prd_furn_outTable_side',
        'phid_k_prd_furn_outTable_dining',
        'phid_k_prd_furn_outTable_cart',
      ],
    ),
    // ----------------------------------
    /// Outdoor Seating
    Chain(
      id: 'phid_k_sub_prd_furn_outSeating',
      icon: null,
      phraseID: 'phid_k_sub_prd_furn_outSeating',
      sons: <String>[
        'phid_k_prd_furn_outSeat_lounge',
        'phid_k_prd_furn_outSeat_dining',
        'phid_k_prd_furn_outSeat_bar',
        'phid_k_prd_furn_outSeat_chaise',
        'phid_k_prd_furn_outSeat_glider',
        'phid_k_prd_furn_outSeat_rocking',
        'phid_k_prd_furn_outSeat_adirondack',
        'phid_k_prd_furn_outSeat_love',
        'phid_k_prd_furn_outSeat_poolLounger',
        'phid_k_prd_furn_outSeat_bench',
        'phid_k_prd_furn_outSeat_swing',
        'phid_k_prd_furn_outSeat_sofa',
      ],
    ),
    // ----------------------------------
    /// Organizers
    Chain(
      id: 'phid_k_sub_prd_furn_organizers',
      icon: null,
      phraseID: 'phid_k_sub_prd_furn_organizers',
      sons: <String>[
        'phid_k_prd_furn_org_shelf',
        'phid_k_prd_furn_org_drawer',
        'phid_k_prd_furn_org_closet',
      ],
    ),
    // ----------------------------------
    /// Office Furniture
    Chain(
      id: 'phid_k_sub_prd_furn_office',
      icon: null,
      phraseID: 'phid_k_sub_prd_furn_office',
      sons: <String>[
        'phid_k_prd_furn_office_desk',
        'phid_k_prd_furn_office_deskAccess',
        'phid_k_prd_furn_office_drafting',
        'phid_k_prd_furn_officeStore_filing',
        'phid_k_prd_furn_officeStore_cart',
      ],
    ),
    // ----------------------------------
    /// Living Storage
    Chain(
      id: 'phid_k_sub_prd_furn_livingStorage',
      icon: null,
      phraseID: 'phid_k_sub_prd_furn_livingStorage',
      sons: <String>[
        'phid_k_prd_furn_living_blanket',
        'phid_k_prd_furn_living_chest',
        'phid_k_prd_furn_living_bookcase',
        'phid_k_prd_furn_living_media',
        'phid_k_prd_furn_living_mediaRack',
        'phid_k_prd_furn_living_hallTree',
        'phid_k_prd_furn_living_barCart',
        'phid_k_prd_furn_living_umbrella',
      ],
    ),
    // ----------------------------------
    /// Laundry
    Chain(
      id: 'phid_k_sub_prd_furn_laundry',
      icon: null,
      phraseID: 'phid_k_sub_prd_furn_laundry',
      sons: <String>[
        'phid_k_prd_furn_laundry_dryingRack',
        'phid_k_prd_furn_laundry_ironingTable',
        'phid_k_prd_furn_laundry_hamper',
      ],
    ),
    // ----------------------------------
    /// Kitchen Storage
    Chain(
      id: 'phid_k_sub_prd_furn_kitchenStorage',
      icon: null,
      phraseID: 'phid_k_sub_prd_furn_kitchenStorage',
      sons: <String>[
        'phid_k_prd_furn_kitStore_cabinet',
        'phid_k_prd_furn_kitStore_pantry',
        'phid_k_prd_furn_kitStore_baker',
        'phid_k_prd_furn_kitStore_island',
        'phid_k_prd_furn_kitStore_utilityShelf',
        'phid_k_prd_furn_kitStore_utilityCart',
        'phid_k_prd_furn_kitStore_kitCart',
      ],
    ),
    // ----------------------------------
    /// Kitchen Accessories
    Chain(
      id: 'phid_k_sub_prd_furn_Kitchen Accessories',
      icon: null,
      phraseID: 'phid_k_sub_prd_furn_Kitchen Accessories',
      sons: <String>[
        'phid_k_prd_furn_kitaccess_rack',
        'phid_k_prd_furn_kitaccess_drawerOrg',
        'phid_k_prd_furn_kitaccess_paperHolder',
        'phid_k_prd_furn_kitaccess_shelfLiner',
        'phid_k_prd_furn_kitaccess_bookstand',
      ],
    ),
    // ----------------------------------
    /// Kids Furniture
    Chain(
      id: 'phid_k_sub_prd_furn_kids',
      icon: null,
      phraseID: 'phid_k_sub_prd_furn_kids',
      sons: <String>[
        'phid_k_prd_furn_kids_set',
        'phid_k_prd_furn_kids_vanity',
        'phid_k_prd_furn_kids_highChair',
        'phid_k_prd_furn_kids_chair',
        'phid_k_prd_furn_kids_dresser',
        'phid_k_prd_furn_kids_bookcase',
        'phid_k_prd_furn_kids_nightstand',
        'phid_k_prd_furn_kids_box',
        'phid_k_prd_furn_kids_rug',
        'phid_k_prd_furn_kids_bed',
        'phid_k_prd_furn_kids_cradle',
        'phid_k_prd_furn_kids_desk',
      ],
    ),
    // ----------------------------------
    /// Furniture Parts
    Chain(
      id: 'phid_k_sub_prd_furn_parts',
      icon: null,
      phraseID: 'phid_k_sub_prd_furn_parts',
      sons: <String>[
        'phid_k_prd_furn_parts_tableLeg',
        'phid_k_prd_furn_parts_tableTop',
      ],
    ),
    // ----------------------------------
    /// Furniture Accessories
    Chain(
      id: 'phid_k_sub_prd_furn_accessories',
      icon: null,
      phraseID: 'phid_k_sub_prd_furn_accessories',
      sons: <String>[
        'phid_k_prd_furn_access_mirror',
        'phid_k_prd_furn_access_clock',
        'phid_k_prd_furn_access_step',
        'phid_k_prd_furn_access_charging',
        'phid_k_prd_furn_access_magazine',
        'phid_k_prd_furn_org_wall',
        'phid_k_prd_furn_access_furnProtector',
      ],
    ),
    // ----------------------------------
    /// Dressing Storage
    Chain(
      id: 'phid_k_sub_prd_furn_dressingStorage',
      icon: null,
      phraseID: 'phid_k_sub_prd_furn_dressingStorage',
      sons: <String>[
        'phid_k_prd_furn_dressStore_wardrobe',
        'phid_k_prd_furn_dressStore_dresser',
        'phid_k_prd_furn_dressStore_shoe',
        'phid_k_prd_furn_dressStore_clothRack',
        'phid_k_prd_furn_dressStore_valet',
        'phid_k_prd_furn_dressStore_jewelry',
      ],
    ),
    // ----------------------------------
    /// Dining Storage
    Chain(
      id: 'phid_k_sub_prd_furn_diningStorage',
      icon: null,
      phraseID: 'phid_k_sub_prd_furn_diningStorage',
      sons: <String>[
        'phid_k_prd_furn_dinStore_china',
        'phid_k_prd_furn_dinStore_buffet',
      ],
    ),
    // ----------------------------------
    /// Cushions & Pillows
    Chain(
      id: 'phid_k_sub_prd_furn_cushions',
      icon: null,
      phraseID: 'phid_k_sub_prd_furn_cushions',
      sons: <String>[
        'phid_k_prd_furn_cush_pillow',
        'phid_k_prd_furn_cush_seat',
        'phid_k_prd_furn_cush_throw',
        'phid_k_prd_furn_cush_floorPillow',
        'phid_k_prd_furn_cush_pouf',
        'phid_k_prd_furn_cush_cush',
        'phid_k_prd_furn_cush_ottoman',
        'phid_k_prd_furn_cush_beanbag',
        'phid_k_prd_furn_cush_outOttoman',
        'phid_k_prd_furn_cush_outCushion',
      ],
    ),
    // ----------------------------------
    /// Couches
    Chain(
      id: 'phid_k_sub_prd_furn_couch',
      icon: null,
      phraseID: 'phid_k_sub_prd_furn_couch',
      sons: <String>[
        'phid_k_prd_furn_couch_chaise',
        'phid_k_prd_furn_couch_banquette',
        'phid_k_prd_furn_couch_sofa',
        'phid_k_prd_furn_couch_sectional',
        'phid_k_prd_furn_couch_futon',
        'phid_k_prd_furn_couch_love',
        'phid_k_prd_furn_couch_sleeper',
      ],
    ),
    // ----------------------------------
    /// Complete Sets
    Chain(
      id: 'phid_k_sub_prd_furn_sets',
      icon: null,
      phraseID: 'phid_k_sub_prd_furn_sets',
      sons: <String>[
        'phid_k_prd_furn_sets_dining',
        'phid_k_prd_furn_sets_bistro',
        'phid_k_prd_furn_sets_living',
        'phid_k_prd_furn_sets_tv',
        'phid_k_prd_furn_sets_bathVanity',
        'phid_k_prd_furn_sets_bedroom',
        'phid_k_prd_furn_sets_bedVanity',
        'phid_k_prd_furn_sets_outLounge',
        'phid_k_prd_furn_sets_outDining',
        'phid_k_prd_furn_sets_outBistro',
      ],
    ),
    // ----------------------------------
    /// Chairs
    Chain(
      id: 'phid_k_sub_prd_furn_chairs',
      icon: null,
      phraseID: 'phid_k_sub_prd_furn_chairs',
      sons: <String>[
        'phid_k_prd_furn_chair_bar',
        'phid_k_prd_furn_chair_dining',
        'phid_k_prd_furn_chair_diningBench',
        'phid_k_prd_furn_chair_arm',
        'phid_k_prd_furn_chair_recliner',
        'phid_k_prd_furn_chair_glider',
        'phid_k_prd_furn_chair_rocking',
        'phid_k_prd_furn_chair_hanging',
        'phid_k_prd_furn_chair_lift',
        'phid_k_prd_furn_chair_massage',
        'phid_k_prd_furn_chair_sleeper',
        'phid_k_prd_furn_chair_theatre',
        'phid_k_prd_furn_chair_folding',
        'phid_k_prd_furn_chair_office',
        'phid_k_prd_furn_chair_gaming',
      ],
    ),
    // ----------------------------------
    /// Carpets & Rugs
    Chain(
      id: 'phid_k_sub_prd_furn_carpetsRugs',
      icon: null,
      phraseID: 'phid_k_sub_prd_furn_carpetsRugs',
      sons: <String>[
        'phid_k_prd_furn_carpet_bathMat',
        'phid_k_prd_furn_carpet_rug',
        'phid_k_prd_furn_carpet_doorMat',
        'phid_k_prd_furn_carpet_runner',
        'phid_k_prd_furn_carpet_kitchen',
        'phid_k_prd_furn_carpet_outdoor',
        'phid_k_prd_furn_carpet_pad',
        'phid_k_prd_furn_carpet_handmade',
      ],
    ),
    // ----------------------------------
    /// Cabinet Hardware
    Chain(
      id: 'phid_k_sub_prd_furn_cabinetHardware',
      icon: null,
      phraseID: 'phid_k_sub_prd_furn_cabinetHardware',
      sons: <String>[
        'phid_k_prd_furn_cabhard_pull',
        'phid_k_prd_furn_cabhard_knob',
        'phid_k_prd_furn_cabhard_hook',
        'phid_k_prd_furn_cabhard_hinge',
      ],
    ),
    // ----------------------------------
    /// Boxes
    Chain(
      id: 'phid_k_sub_prd_furn_boxes',
      icon: null,
      phraseID: 'phid_k_sub_prd_furn_boxes',
      sons: <String>[
        'phid_k_prd_furn_boxes_bin',
        'phid_k_prd_furn_boxes_outdoor',
        'phid_k_prd_furn_boxes_ice',
        'phid_k_prd_furn_boxes_basket',
      ],
    ),
    // ----------------------------------
    /// Blinds & Curtains
    Chain(
      id: 'phid_k_sub_prd_furn_blindsCurtains',
      icon: null,
      phraseID: 'phid_k_sub_prd_furn_blindsCurtains',
      sons: <String>[
        'phid_k_prd_furn_curtain_shower',
        'phid_k_prd_furn_curtain_shade',
        'phid_k_prd_furn_curtain_horizontal',
        'phid_k_prd_furn_curtain_vertical',
        'phid_k_prd_furn_curtain_rod',
        'phid_k_prd_furn_curtain_valance',
        'phid_k_prd_furn_curtain_curtain',
        'phid_k_prd_furn_curtain_tassel',
        'phid_k_prd_furn_curtain_bendRail',
      ],
    ),
    // ----------------------------------
    /// Beds & Headboards
    Chain(
      id: 'phid_k_sub_prd_furn_beds',
      icon: null,
      phraseID: 'phid_k_sub_prd_furn_beds',
      sons: <String>[
        'phid_k_prd_furn_beds_bed',
        'phid_k_prd_furn_beds_board',
        'phid_k_prd_furn_beds_mattress',
        'phid_k_prd_furn_beds_frame',
        'phid_k_prd_furn_beds_blanket',
        'phid_k_prd_furn_beds_panel',
        'phid_k_prd_furn_beds_platform',
        'phid_k_prd_furn_beds_sleigh',
        'phid_k_prd_furn_beds_bunk',
        'phid_k_prd_furn_beds_loft',
        'phid_k_prd_furn_beds_day',
        'phid_k_prd_furn_beds_murphy',
        'phid_k_prd_furn_beds_folding',
        'phid_k_prd_furn_beds_adjustable',
      ],
    ),
    // ----------------------------------
    /// Bathroom Storage
    Chain(
      id: 'phid_k_sub_prd_furn_bathStorage',
      icon: null,
      phraseID: 'phid_k_sub_prd_furn_bathStorage',
      sons: <String>[
        'phid_k_prd_furn_bathStore_medicine',
        'phid_k_prd_furn_bathStore_cabinet',
        'phid_k_prd_furn_bathStore_shelf',
        'phid_k_prd_furn_bathStore_sink',
        'phid_k_prd_furn_bedStore_nightstand',
      ],
    ),
    // ----------------------------------
    /// Bathroom Hardware
    Chain(
      id: 'phid_k_sub_prd_furn_bathHardware',
      icon: null,
      phraseID: 'phid_k_sub_prd_furn_bathHardware',
      sons: <String>[
        'phid_k_prd_furn_bathHard_towelBar',
        'phid_k_prd_furn_bathHard_mirror',
        'phid_k_prd_furn_bathHard_makeup',
        'phid_k_prd_furn_bathHard_rack',
        'phid_k_prd_furn_bathHard_grab',
        'phid_k_prd_furn_bathHard_caddy',
        'phid_k_prd_furn_bathHard_safetyRail',
        'phid_k_prd_furn_bathHard_toiletHolder',
        'phid_k_prd_furn_bathHard_commode',
      ],
    ),
    // ----------------------------------
    /// Artworks
    Chain(
      id: 'phid_k_sub_prd_furn_artworks',
      icon: null,
      phraseID: 'phid_k_sub_prd_furn_artworks',
      sons: <String>[
        'phid_k_prd_furn_art_painting',
        'phid_k_prd_furn_art_photo',
        'phid_k_prd_furn_art_illustration',
        'phid_k_prd_furn_art_print',
        'phid_k_prd_furn_art_sculpture',
        'phid_k_prd_furn_art_letter',
        'phid_k_prd_furn_art_frame',
        'phid_k_prd_furn_art_bulletin',
        'phid_k_prd_furn_art_decals',
        'phid_k_prd_furn_art_tapestry',
      ],
    ),
  ],
);

const Chain hvacChain = Chain(
  id: 'phid_k_group_prd_hvac',
  icon: 'id',
  phraseID: 'phid_k_group_prd_hvac',
  sons: <Chain>[
    // ----------------------------------
    /// Ventilation
    Chain(
      id: 'phid_k_sub_prd_hvac_ventilation',
      icon: null,
      phraseID: 'phid_k_sub_prd_hvac_ventilation',
      sons: <String>[
        'phid_k_prd_hvac_vent_fan',
        'phid_k_prd_hvac_vent_exhaust',
        'phid_k_prd_hvac_vent_curtain',
        'phid_k_prd_hvac_vent_ceilingFan',
      ],
    ),
    // ----------------------------------
    /// Heating
    Chain(
      id: 'phid_k_sub_prd_hvac_heating',
      icon: null,
      phraseID: 'phid_k_sub_prd_hvac_heating',
      sons: <String>[
        'phid_k_prd_hvac_heating_electric',
        'phid_k_prd_hvac_heating_radiators',
        'phid_k_prd_hvac_heating_floor',
      ],
    ),
    // ----------------------------------
    /// Fireplaces
    Chain(
      id: 'phid_k_sub_prd_hvac_fireplaces',
      icon: null,
      phraseID: 'phid_k_sub_prd_hvac_fireplaces',
      sons: <String>[
        'phid_k_prd_fireplace_fire_mantle',
        'phid_k_prd_fireplace_fire_tabletop',
        'phid_k_prd_fireplace_fire_freeStove',
        'phid_k_prd_fireplace_fire_outdoor',
        'phid_k_prd_fireplace_fire_chiminea',
        'phid_k_prd_fireplace_fire_pit',
      ],
    ),
    // ----------------------------------
    /// Fireplace Equipment
    Chain(
      id: 'phid_k_sub_prd_hvac_fireplaceEquip',
      icon: null,
      phraseID: 'phid_k_sub_prd_hvac_fireplaceEquip',
      sons: <String>[
        'phid_k_prd_fireplace_equip_tools',
        'phid_k_prd_fireplace_equip_rack',
        'phid_k_prd_fireplace_equip_fuel',
        'phid_k_prd_fireplace_equip_grate',
      ],
    ),
    // ----------------------------------
    /// Air Conditioning
    Chain(
      id: 'phid_k_sub_prd_hvac_ac',
      icon: null,
      phraseID: 'phid_k_sub_prd_hvac_ac',
      sons: <String>[
        'phid_k_prd_hvac_ac_chiller',
        'phid_k_prd_hvac_ac_ac',
        'phid_k_prd_hvac_ac_vent',
        'phid_k_prd_hvac_ac_humidifier',
        'phid_k_prd_hvac_ac_dehumidifier',
        'phid_k_prd_hvac_ac_purifier',
      ],
    ),
  ],
);

const Chain plantingAndLandscapeChain = Chain(
  id: 'phid_k_group_prd_landscape',
  icon: 'id',
  phraseID: 'phid_k_group_prd_landscape',
  sons: <Chain>[
    // ----------------------------------
    /// Pots & Vases
    Chain(
      id: 'phid_k_sub_prd_scape_potsVases',
      icon: null,
      phraseID: 'phid_k_sub_prd_scape_potsVases',
      sons: <String>[
        'phid_k_prd_landscape_pots_vase',
        'phid_k_prd_landscape_pots_indoorPlanter',
        'phid_k_prd_landscape_pots_outdoorPlanter',
        'phid_k_prd_landscape_pots_bin',
      ],
    ),
    // ----------------------------------
    /// Live Plants
    Chain(
      id: 'phid_k_sub_prd_scape_livePlants',
      icon: null,
      phraseID: 'phid_k_sub_prd_scape_livePlants',
      sons: <String>[
        'phid_k_prd_landscape_live_tree',
        'phid_k_prd_landscape_live_grass',
        'phid_k_prd_landscape_live_bush',
      ],
    ),
    // ----------------------------------
    /// Hardscape
    Chain(
      id: 'phid_k_sub_prd_scape_hardscape',
      icon: null,
      phraseID: 'phid_k_sub_prd_scape_hardscape',
      sons: <String>[
        'phid_k_prd_landscape_hardscape_trellis',
        'phid_k_prd_landscape_hardscape_flag',
      ],
    ),
    // ----------------------------------
    /// Fountains & Ponds
    Chain(
      id: 'phid_k_sub_prd_scape_fountainsPonds',
      icon: null,
      phraseID: 'phid_k_sub_prd_scape_fountainsPonds',
      sons: <String>[
        'phid_k_prd_landscape_fountain_indoor',
        'phid_k_prd_landscape_fountain_outdoor',
      ],
    ),
    // ----------------------------------
    /// Birds fixtures
    Chain(
      id: 'phid_k_sub_prd_scape_birds',
      icon: null,
      phraseID: 'phid_k_sub_prd_scape_birds',
      sons: <String>[
        'phid_k_prd_landscape_birds_feeder',
        'phid_k_prd_landscape_birds_bath',
        'phid_k_prd_landscape_birds_house',
      ],
    ),
    // ----------------------------------
    /// Artificial plants
    Chain(
      id: 'phid_k_sub_prd_scape_artificial',
      icon: null,
      phraseID: 'phid_k_sub_prd_scape_artificial',
      sons: <String>[
        'phid_k_prd_landscape_artificial_tree',
        'phid_k_prd_landscape_artificial_plant',
        'phid_k_prd_landscape_artificial_grass',
      ],
    ),
  ],
);

const Chain lightingChain = Chain(
  id: 'phid_k_group_prd_lighting',
  icon: 'id',
  phraseID: 'phid_k_group_prd_lighting',
  sons: <Chain>[
    // ----------------------------------
    /// Wall Lighting
    Chain(
      id: 'phid_k_sub_prd_light_wall',
      icon: null,
      phraseID: 'phid_k_sub_prd_light_wall',
      sons: <String>[
        'phid_k_prd_lighting_wall_applique',
        'phid_k_prd_lighting_wall_vanity',
        'phid_k_prd_lighting_wall_picture',
        'phid_k_prd_lighting_wall_swing',
      ],
    ),
    // ----------------------------------
    /// Outdoor Lighting
    Chain(
      id: 'phid_k_sub_prd_light_outdoor',
      icon: null,
      phraseID: 'phid_k_sub_prd_light_outdoor',
      sons: <String>[
        'phid_k_prd_lighting_outdoor_wall',
        'phid_k_prd_lighting_outdoor_flush',
        'phid_k_prd_lighting_outdoor_hanging',
        'phid_k_prd_lighting_outdoor_deck',
        'phid_k_prd_lighting_outdoor_inground',
        'phid_k_prd_lighting_outdoor_path',
        'phid_k_prd_lighting_outdoor_step',
        'phid_k_prd_lighting_outdoor_floorSpot',
        'phid_k_prd_lighting_outdoor_lamp',
        'phid_k_prd_lighting_outdoor_table',
        'phid_k_prd_lighting_outdoor_string',
        'phid_k_prd_lighting_outdoor_post',
        'phid_k_prd_lighting_outdoor_torch',
        'phid_k_prd_lighting_outdoor_gardenSpot',
      ],
    ),
    // ----------------------------------
    /// Lighting Accessories
    Chain(
      id: 'phid_k_sub_prd_light_access',
      icon: null,
      phraseID: 'phid_k_sub_prd_light_access',
      sons: <String>[
        'phid_k_prd_lighting_accessories_shade',
        'phid_k_prd_lighting_accessories_timer',
        'phid_k_prd_lighting_accessories_lightingHardware',
        'phid_k_prd_lighting_accessories_flash',
        'phid_k_prd_lighting_accessories_diffuser',
      ],
    ),
    // ----------------------------------
    /// Light bulbs
    Chain(
      id: 'phid_k_sub_prd_light_bulbs',
      icon: null,
      phraseID: 'phid_k_sub_prd_light_bulbs',
      sons: <String>[
        'phid_k_prd_lighting_bulbs_fluorescent',
        'phid_k_prd_lighting_bulbs_led',
        'phid_k_prd_lighting_bulbs_halogen',
        'phid_k_prd_lighting_bulbs_incandescent',
        'phid_k_prd_lighting_bulbs_tube',
        'phid_k_prd_lighting_bulbs_krypton',
      ],
    ),
    // ----------------------------------
    /// Lamps
    Chain(
      id: 'phid_k_sub_prd_light_lamps',
      icon: null,
      phraseID: 'phid_k_sub_prd_light_lamps',
      sons: <String>[
        'phid_k_prd_lighting_lamp_table',
        'phid_k_prd_lighting_lamp_floor',
        'phid_k_prd_lighting_lamp_desk',
        'phid_k_prd_lighting_lamp_set',
        'phid_k_prd_lighting_lamp_piano',
        'phid_k_prd_lighting_lamp_kids',
        'phid_k_prd_lighting_lamp_emergency',
      ],
    ),
    // ----------------------------------
    /// Ceiling Lighting
    Chain(
      id: 'phid_k_sub_prd_light_ceiling',
      icon: null,
      phraseID: 'phid_k_sub_prd_light_ceiling',
      sons: <String>[
        'phid_k_prd_lighting_ceiling_chandelier',
        'phid_k_prd_lighting_ceiling_pendant',
        'phid_k_prd_lighting_ceiling_flush',
        'phid_k_prd_lighting_ceiling_kitchenIsland',
        'phid_k_prd_lighting_ceiling_underCabinet',
        'phid_k_prd_lighting_ceiling_track',
        'phid_k_prd_lighting_ceiling_recessed',
        'phid_k_prd_lighting_ceiling_pool',
        'phid_k_prd_lighting_ceiling_spot',
        'phid_k_prd_lighting_ceiling_kids',
      ],
    ),
  ],
);

const Chain constructionMaterials = Chain(
  id: 'phid_k_group_prd_materials',
  icon: 'id',
  phraseID: 'phid_k_group_prd_materials',
  sons: <Chain>[
    // ----------------------------------
    /// Wood Coats
    Chain(
      id: 'phid_k_sub_prd_mat_woodCoats',
      icon: null,
      phraseID: 'phid_k_sub_prd_mat_woodCoats',
      sons: <String>[
        'phid_k_prd_mat_woodPaint_lacquer',
        'phid_k_prd_mat_woodPaint_polyurethane',
        'phid_k_prd_mat_woodPaint_polycrylic',
        'phid_k_prd_mat_woodPaint_varnish',
        'phid_k_prd_mat_woodPaint_polyester',
      ],
    ),
    // ----------------------------------
    /// Water Proofing
    Chain(
      id: 'phid_k_sub_prd_mat_waterProofing',
      icon: null,
      phraseID: 'phid_k_sub_prd_mat_waterProofing',
      sons: <String>[
        'phid_k_prd_mat_waterProof_rubber',
        'phid_k_prd_mat_waterProof_bitumen',
        'phid_k_prd_mat_waterProof_pvc',
        'phid_k_prd_mat_waterProof_tpo',
        'phid_k_prd_mat_waterProof_polyurethane',
        'phid_k_prd_mat_waterProof_acrylic',
        'phid_k_prd_mat_waterProof_cementitious',
      ],
    ),
    // ----------------------------------
    /// Synthetic Heat Insulation
    Chain(
      id: 'phid_k_sub_prd_mat_heatSynth',
      icon: null,
      phraseID: 'phid_k_sub_prd_mat_heatSynth',
      sons: <String>[
        'phid_k_prd_mat_heatSynth_reflective',
        'phid_k_prd_mat_heatSynth_polystyrene',
        'phid_k_prd_mat_heatSynth_styro',
        'phid_k_prd_mat_heatSynth_purSheet',
        'phid_k_prd_mat_heatSynth_purSpray',
        'phid_k_prd_mat_heatSynth_purSection',
        'phid_k_prd_mat_heatSynth_phenolic',
        'phid_k_prd_mat_heatSynth_aerogel',
      ],
    ),
    // ----------------------------------
    /// Stones
    Chain(
      id: 'phid_k_sub_prd_mat_stones',
      icon: null,
      phraseID: 'phid_k_sub_prd_mat_stones',
      sons: <String>[
        'phid_k_prd_mat_stone_marble',
        'phid_k_prd_mat_stone_granite',
        'phid_k_prd_mat_stone_slate',
        'phid_k_prd_mat_stone_quartzite',
        'phid_k_prd_mat_stone_soap',
        'phid_k_prd_mat_stone_travertine',
      ],
    ),
    // ----------------------------------
    /// Steel
    Chain(
      id: 'phid_k_sub_prd_mat_steel',
      icon: null,
      phraseID: 'phid_k_sub_prd_mat_steel',
      sons: <String>[
        'phid_k_prd_mat_steel_rebar',
        'phid_k_prd_mat_steel_section',
      ],
    ),
    // ----------------------------------
    /// Solid Wood
    Chain(
      id: 'phid_k_sub_prd_mat_solidWood',
      icon: null,
      phraseID: 'phid_k_sub_prd_mat_solidWood',
      sons: <String>[
        'phid_k_prd_mat_wood_oak',
        'phid_k_prd_mat_wood_beech',
        'phid_k_prd_mat_wood_mahogany',
        'phid_k_prd_mat_wood_beechPine',
        'phid_k_prd_mat_wood_ash',
        'phid_k_prd_mat_wood_walnut',
        'phid_k_prd_mat_wood_pine',
        'phid_k_prd_mat_wood_teak',
        'phid_k_prd_mat_wood_rose',
        'phid_k_prd_mat_wood_palisander',
        'phid_k_prd_mat_wood_sandal',
        'phid_k_prd_mat_wood_cherry',
        'phid_k_prd_mat_wood_ebony',
        'phid_k_prd_mat_wood_maple',
      ],
    ),
    // ----------------------------------
    /// Sand & Rubble
    Chain(
      id: 'phid_k_sub_prd_mat_sandRubble',
      icon: null,
      phraseID: 'phid_k_sub_prd_mat_sandRubble',
      sons: <String>[
        'prd_mat_sand_sand',
      ],
    ),
    // ----------------------------------
    /// Paints
    Chain(
      id: 'phid_k_sub_prd_mat_paints',
      icon: null,
      phraseID: 'phid_k_sub_prd_mat_paints',
      sons: <String>[
        'phid_k_prd_mat_paint_cement',
        'phid_k_prd_mat_paint_outdoor',
        'phid_k_prd_mat_paint_primer',
        'phid_k_prd_mat_paint_acrylic',
        'phid_k_prd_mat_paint_duco',
        'phid_k_prd_mat_paint_heatproof',
        'phid_k_prd_mat_paint_fire',
      ],
    ),
    // ----------------------------------
    /// Mineral Heat Insulation
    Chain(
      id: 'phid_k_sub_prd_mat_heatIMin',
      icon: null,
      phraseID: 'phid_k_sub_prd_mat_heatIMin',
      sons: <String>[
        'phid_k_prd_mat_heatmin_vermiculite',
        'phid_k_prd_mat_heatmin_cellulose',
        'phid_k_prd_mat_heatmin_perlite',
        'phid_k_prd_mat_heatmin_foamGlass',
        'phid_k_prd_mat_heatmin_fiberglassWool',
        'phid_k_prd_mat_heatmin_fiberglassPipe',
        'phid_k_prd_mat_heatmin_rockWool',
      ],
    ),
    // ----------------------------------
    /// Metals
    Chain(
      id: 'phid_k_sub_prd_mat_metals',
      icon: null,
      phraseID: 'phid_k_sub_prd_mat_metals',
      sons: <String>[
        'phid_k_prd_mat_metal_iron',
        'phid_k_prd_mat_metal_steel',
        'phid_k_prd_mat_metal_aluminum',
        'phid_k_prd_mat_metal_copper',
        'phid_k_prd_mat_metal_silver',
        'phid_k_prd_mat_metal_gold',
        'phid_k_prd_mat_metal_bronze',
        'phid_k_prd_mat_metal_stainless',
        'phid_k_prd_mat_metal_chrome',
      ],
    ),
    // ----------------------------------
    /// Manufactured Wood
    Chain(
      id: 'phid_k_sub_prd_mat_manuWood',
      icon: null,
      phraseID: 'phid_k_sub_prd_mat_manuWood',
      sons: <String>[
        'phid_k_prd_mat_manWood_mdf',
        'phid_k_prd_mat_manWood_veneer',
        'phid_k_prd_mat_manWood_compressed',
        'phid_k_prd_mat_manWood_formica',
        'phid_k_prd_mat_manWood_engineered',
        'phid_k_prd_mat_manWood_ply',
        'phid_k_prd_mat_manWood_cork',
      ],
    ),
    // ----------------------------------
    /// Gypsum
    Chain(
      id: 'phid_k_sub_prd_mat_gypsum',
      icon: null,
      phraseID: 'phid_k_sub_prd_mat_gypsum',
      sons: <String>[
        'phid_k_prd_mat_gypsum_board',
        'phid_k_prd_mat_gypsum_powder',
      ],
    ),
    // ----------------------------------
    /// Glass
    Chain(
      id: 'phid_k_sub_prd_mat_glass',
      icon: null,
      phraseID: 'phid_k_sub_prd_mat_glass',
      sons: <String>[
        'phid_k_prd_mat_glass_float',
        'phid_k_prd_mat_glass_bullet',
        'phid_k_prd_mat_glass_block',
        'phid_k_prd_mat_glass_tempered',
        'phid_k_prd_mat_glass_obscured',
        'phid_k_prd_mat_glass_mirrored',
        'phid_k_prd_mat_glass_tinted',
        'phid_k_prd_mat_glass_wired',
      ],
    ),
    // ----------------------------------
    /// Fabrics
    Chain(
      id: 'phid_k_sub_prd_mat_fabrics',
      icon: null,
      phraseID: 'phid_k_sub_prd_mat_fabrics',
      sons: <String>[
        'phid_k_prd_mat_fabric_wool',
        'phid_k_prd_mat_fabric_moquette',
        'phid_k_prd_mat_fabric_leather',
        'phid_k_prd_mat_fabric_upholstery',
        'phid_k_prd_mat_fabric_polyester',
        'phid_k_prd_mat_fabric_silk',
        'phid_k_prd_mat_fabric_rayon',
        'phid_k_prd_mat_fabric_cotton',
        'phid_k_prd_mat_fabric_linen',
        'phid_k_prd_mat_fabric_velvet',
        'phid_k_prd_mat_fabric_voile',
        'phid_k_prd_mat_fabric_lace',
      ],
    ),
    // ----------------------------------
    /// Cement
    Chain(
      id: 'phid_k_sub_prd_mat_cement',
      icon: null,
      phraseID: 'phid_k_sub_prd_mat_cement',
      sons: <String>[
        'phid_k_prd_mat_cement_white',
        'phid_k_prd_mat_cement_portland',
        'phid_k_prd_mat_cement_board',
      ],
    ),
    // ----------------------------------
    /// Bricks
    Chain(
      id: 'phid_k_sub_prd_mat_bricks',
      icon: null,
      phraseID: 'phid_k_sub_prd_mat_bricks',
      sons: <String>[
        'phid_k_prd_mat_brick_cement',
        'phid_k_prd_mat_brick_red',
        'phid_k_prd_mat_brick_white',
      ],
    ),
    // ----------------------------------
    /// Acrylic
    Chain(
      id: 'phid_k_sub_prd_mat_acrylic',
      icon: null,
      phraseID: 'phid_k_sub_prd_mat_acrylic',
      sons: <String>[
        'phid_k_prd_mat_acrylic_tinted',
        'phid_k_prd_mat_acrylic_frosted',
        'phid_k_prd_mat_acrylic_opaque',
      ],
    ),
  ],
);

const Chain plumbingAndSanitaryChain = Chain(
  id: 'phid_k_group_prd_plumbing',
  icon: 'id',
  phraseID: 'phid_k_group_prd_plumbing',
  sons: <Chain>[
    // ----------------------------------
    /// Water Treatment
    Chain(
      id: 'phid_k_sub_prd_plumb_treatment',
      icon: null,
      phraseID: 'phid_k_sub_prd_plumb_treatment',
      sons: <String>[
        'phid_k_prd_plumbing_treatment_filter',
        'phid_k_prd_plumbing_treatment_system',
        'phid_k_prd_plumbing_treatment_tank',
        'phid_k_prd_plumbing_treatment_heater',
      ],
    ),
    // ----------------------------------
    /// Tub Sanitary ware
    Chain(
      id: 'phid_k_sub_prd_plumb_tub',
      icon: null,
      phraseID: 'phid_k_sub_prd_plumb_tub',
      sons: <String>[
        'phid_k_prd_plumbing_tub_bathTubs',
        'phid_k_prd_plumbing_tub_faucet',
      ],
    ),
    // ----------------------------------
    /// Toilet Sanitary ware
    Chain(
      id: 'phid_k_sub_prd_plumb_toilet',
      icon: null,
      phraseID: 'phid_k_sub_prd_plumb_toilet',
      sons: <String>[
        'phid_k_prd_plumbing_toilet_floorDrain',
        'phid_k_prd_plumbing_toilet_urinal',
        'phid_k_prd_plumbing_toilet_bidet',
        'phid_k_prd_plumbing_toilet_bidetFaucet',
        'phid_k_prd_plumbing_toilet_toilet',
        'phid_k_prd_plumbing_toilet_rinser',
      ],
    ),
    // ----------------------------------
    /// Shower Sanitary ware
    Chain(
      id: 'phid_k_sub_prd_plumb_shower',
      icon: null,
      phraseID: 'phid_k_sub_prd_plumb_shower',
      sons: <String>[
        'phid_k_prd_plumbing_shower_head',
        'phid_k_prd_plumbing_shower_panel',
        'phid_k_prd_plumbing_shower_steam',
        'phid_k_prd_plumbing_shower_faucet',
        'phid_k_prd_plumbing_shower_base',
        'phid_k_prd_plumbing_shower_accessory',
      ],
    ),
    // ----------------------------------
    /// Sanitary ware
    Chain(
      id: 'phid_k_sub_prd_plumb_sanitary',
      icon: null,
      phraseID: 'phid_k_sub_prd_plumb_sanitary',
      sons: <String>[
        'phid_k_prd_plumbing_sanitary_drain',
        'phid_k_prd_plumbing_sanitary_bibbs',
      ],
    ),
    // ----------------------------------
    /// Kitchen Sanitary ware
    Chain(
      id: 'phid_k_sub_prd_plumb_kitchen',
      icon: null,
      phraseID: 'phid_k_sub_prd_plumb_kitchen',
      sons: <String>[
        'phid_k_prd_plumbing_kitchen_rinser',
        'phid_k_prd_plumbing_kitchen_sink',
        'phid_k_prd_plumbing_kitchen_faucet',
        'phid_k_prd_plumbing_kitchen_potFiller',
        'phid_k_prd_plumbing_kitchen_barSink',
        'phid_k_prd_plumbing_kitchen_barFaucet',
        'phid_k_prd_plumbing_kitchen_floorDrain',
      ],
    ),
    // ----------------------------------
    /// Handwash Sanitary ware
    Chain(
      id: 'phid_k_sub_prd_plumb_handwash',
      icon: null,
      phraseID: 'phid_k_sub_prd_plumb_handwash',
      sons: <String>[
        'phid_k_prd_plumbing_handwash_washBasins',
        'phid_k_prd_plumbing_handwash_faucet',
        'phid_k_prd_plumbing_handwash_accessories',
        'phid_k_prd_plumbing_handwash_soap',
      ],
    ),
    // ----------------------------------
    /// Connections
    Chain(
      id: 'phid_k_sub_prd_plumb_connections',
      icon: null,
      phraseID: 'phid_k_sub_prd_plumb_connections',
      sons: <String>[
        'phid_k_prd_plumbing_connections_pipes',
        'phid_k_prd_plumbing_connections_fittings',
        'phid_k_prd_plumbing_connections_valve',
      ],
    ),
  ],
);

const Chain poolsAndSpaChain = Chain(
  id: 'phid_k_group_prd_poolSpa',
  icon: 'id',
  phraseID: 'phid_k_group_prd_poolSpa',
  sons: <Chain>[
    // ----------------------------------
    /// Swimming Pools
    Chain(
      id: 'phid_k_sub_prd_pool_pools',
      icon: null,
      phraseID: 'phid_k_sub_prd_pool_pools',
      sons: <String>[
        'phid_k_prd_poolSpa_pools_fiberglass',
        'phid_k_prd_poolSpa_pools_above',
        'phid_k_prd_poolSpa_pools_inflatable',
      ],
    ),
    // ----------------------------------
    /// Spa
    Chain(
      id: 'phid_k_sub_prd_pool_spa',
      icon: null,
      phraseID: 'phid_k_sub_prd_pool_spa',
      sons: <String>[
        'phid_k_prd_poolSpa_spa_sauna',
        'phid_k_prd_poolSpa_spa_steam',
        'phid_k_prd_poolSpa_spa_steamShower',
        'phid_k_prd_poolSpa_spa_jacuzzi',
      ],
    ),
    // ----------------------------------
    /// Pools Equipment
    Chain(
      id: 'phid_k_sub_prd_pool_equipment',
      icon: null,
      phraseID: 'phid_k_sub_prd_pool_equipment',
      sons: <String>[
        'phid_k_prd_poolSpa_equip_cleaning',
        'phid_k_prd_poolSpa_equip_pump',
        'phid_k_prd_poolSpa_equip_filter',
      ],
    ),
    // ----------------------------------
    /// Pool Accessories
    Chain(
      id: 'phid_k_sub_prd_pool_accessories',
      icon: null,
      phraseID: 'phid_k_sub_prd_pool_accessories',
      sons: <String>[
        'phid_k_prd_poolSpa_access_handrail',
        'phid_k_prd_poolSpa_access_grate',
        'phid_k_prd_poolSpa_access_light',
        'phid_k_prd_poolSpa_access_shower',
      ],
    ),
  ],
);

const Chain roofingChain = Chain(
  id: 'phid_k_group_prd_roofing',
  icon: 'id',
  phraseID: 'phid_k_group_prd_roofing',
  sons: <Chain>[
    // ----------------------------------
    /// Roof Drainage
    Chain(
      id: 'phid_k_sub_prd_roof_drainage',
      icon: null,
      phraseID: 'phid_k_sub_prd_roof_drainage',
      sons: <String>[
        'prd_roof_drainage_gutter',
      ],
    ),
    // ----------------------------------
    /// Roof Cladding
    Chain(
      id: 'phid_k_sub_prd_roof_cladding',
      icon: null,
      phraseID: 'phid_k_sub_prd_roof_cladding',
      sons: <String>[
        'phid_k_prd_roof_cladding_brick',
        'phid_k_prd_roof_cladding_bitumen',
        'phid_k_prd_roof_cladding_metal',
      ],
    ),
  ],
);

const Chain safetyChain = Chain(
  id: 'phid_k_group_prd_safety',
  icon: 'id',
  phraseID: 'phid_k_group_prd_safety',
  sons: <Chain>[
    // ----------------------------------
    /// Safety Equipment
    Chain(
      id: 'phid_k_sub_prd_safety_equip',
      icon: null,
      phraseID: 'phid_k_sub_prd_safety_equip',
      sons: <String>[
        'phid_k_prd_safety_equip_gasDetector',
        'phid_k_prd_safety_equip_rescue',
        'phid_k_prd_safety_equip_firstAid',
      ],
    ),
    // ----------------------------------
    /// Safety Clothes
    Chain(
      id: 'phid_k_sub_prd_safety_clothes',
      icon: null,
      phraseID: 'phid_k_sub_prd_safety_clothes',
      sons: <String>[
        'phid_k_prd_safety_clothes_coverall',
        'phid_k_prd_safety_clothes_chemicalSuit',
        'phid_k_prd_safety_clothes_eyeProtection',
        'phid_k_prd_safety_clothes_earProtection',
        'phid_k_prd_safety_clothes_helmet',
        'phid_k_prd_safety_clothes_glove',
        'phid_k_prd_safety_clothes_shoe',
        'phid_k_prd_safety_clothes_respirator',
      ],
    ),
    // ----------------------------------
    /// Floor Protection
    Chain(
      id: 'phid_k_sub_prd_safety_floorProtection',
      icon: null,
      phraseID: 'phid_k_sub_prd_safety_floorProtection',
      sons: <String>[
        'phid_k_prd_safety_floorProtection_cardboard',
        'phid_k_prd_safety_floorProtection_plastic',
      ],
    ),
    // ----------------------------------
  ],
);

const Chain securityChain = Chain(
  id: 'phid_k_group_prd_security',
  icon: 'id',
  phraseID: 'phid_k_group_prd_security',
  sons: <Chain>[
    // ----------------------------------
    /// Surveillance Systems
    Chain(
      id: 'phid_k_sub_prd_security_surveillance',
      icon: null,
      phraseID: 'phid_k_sub_prd_security_surveillance',
      sons: <String>[
        'phid_k_prd_security_surv_camera',
        'phid_k_prd_security_surv_thermal',
        'phid_k_prd_security_surv_motion',
      ],
    ),
    // ----------------------------------
    /// Security Safes
    Chain(
      id: 'phid_k_sub_prd_security_safes',
      icon: null,
      phraseID: 'phid_k_sub_prd_security_safes',
      sons: <String>[
        'phid_k_prd_security_safes_wall',
        'phid_k_prd_security_safes_portable',
        'phid_k_prd_security_safes_mini',
        'phid_k_prd_security_safes_vault',
        'phid_k_prd_security_safes_fire',
      ],
    ),
    // ----------------------------------
    /// Road Control
    Chain(
      id: 'phid_k_sub_prd_security_roadControl',
      icon: null,
      phraseID: 'phid_k_sub_prd_security_roadControl',
      sons: <String>[
        'phid_k_prd_security_road_bollard',
        'phid_k_prd_security_road_tire',
        'phid_k_prd_security_road_barrier',
      ],
    ),
    // ----------------------------------
    /// Accessibility Systems
    Chain(
      id: 'phid_k_sub_prd_security_accessibility',
      icon: null,
      phraseID: 'phid_k_sub_prd_security_accessibility',
      sons: <String>[
        'phid_k_prd_security_access_accessControl',
        'phid_k_prd_security_access_eas',
        'phid_k_prd_security_access_detector',
        'phid_k_prd_security_access_turnstile',
      ],
    ),
  ],
);

const Chain smartHomeChain = Chain(
  id: 'phid_k_group_prd_smartHome',
  icon: 'id',
  phraseID: 'phid_k_group_prd_smartHome',
  sons: <Chain>[
    // ----------------------------------
    /// Automation Systems
    Chain(
      id: 'phid_k_sub_prd_smart_automation',
      icon: null,
      phraseID: 'phid_k_sub_prd_smart_automation',
      sons: <String>[
        'phid_k_prd_smart_auto_center',
        'phid_k_prd_smart_auto_system',
      ],
    ),
    // ----------------------------------
    /// Audio Systems
    Chain(
      id: 'phid_k_sub_prd_smart_audio',
      icon: null,
      phraseID: 'phid_k_sub_prd_smart_audio',
      sons: <String>[
        'phid_k_prd_smart_audio_system',
        'phid_k_prd_smart_audio_theatre',
        'phid_k_prd_smart_audio_speaker',
        'phid_k_prd_smart_audio_wirelessSpeaker',
        'phid_k_prd_smart_audio_controller',
      ],
    ),
    // ----------------------------------
  ],
);

const Chain stairsChain = Chain(
  id: 'phid_k_group_prd_stairs',
  icon: 'id',
  phraseID: 'phid_k_group_prd_stairs',
  sons: <Chain>[
    // ----------------------------------
    /// Handrails
    Chain(
      id: 'phid_k_sub_prd_stairs_handrails',
      icon: null,
      phraseID: 'phid_k_sub_prd_stairs_handrails',
      sons: <String>[
        'phid_k_prd_stairs_handrails_wood',
        'phid_k_prd_stairs_handrails_metal',
        'phid_k_prd_stairs_handrails_parts',
      ],
    ),
    // ----------------------------------
  ],
);

const Chain lightStructureChain = Chain(
  id: 'phid_k_group_prd_structure',
  icon: 'id',
  phraseID: 'phid_k_group_prd_structure',
  sons: <Chain>[
    // ----------------------------------
    /// Shades
    Chain(
      id: 'phid_k_sub_prd_struc_shades',
      icon: null,
      phraseID: 'phid_k_sub_prd_struc_shades',
      sons: <String>[
        'phid_k_prd_structure_shades_pergola',
        'phid_k_prd_structure_shades_gazebo',
        'phid_k_prd_structure_shades_sail',
        'phid_k_prd_structure_shades_canopy',
        'phid_k_prd_structure_shades_awning',
        'phid_k_prd_structure_shades_tent',
        'phid_k_prd_structure_shades_umbrella',
      ],
    ),
    // ----------------------------------
    /// Light Structures
    Chain(
      id: 'phid_k_sub_prd_struc_light',
      icon: null,
      phraseID: 'phid_k_sub_prd_struc_light',
      sons: <String>[
        'phid_k_prd_structure_light_arbor',
        'phid_k_prd_structure_light_shed',
        'phid_k_prd_structure_light_kiosk',
        'phid_k_prd_structure_light_playhouse',
        'phid_k_prd_structure_light_greenHouse',
        'phid_k_prd_structure_light_glassHouse',
        'phid_k_prd_structure_light_trailer',
      ],
    ),
  ],
);

const Chain wallsAndRoomsPartitions = Chain(
  id: 'phid_k_group_prd_walls',
  icon: 'id',
  phraseID: 'phid_k_group_prd_walls',
  sons: <Chain>[
    // ----------------------------------
    /// Wall Cladding
    Chain(
      id: 'phid_k_sub_prd_walls_cladding',
      icon: null,
      phraseID: 'phid_k_sub_prd_walls_cladding',
      sons: <String>[
        'phid_k_prd_walls_cladding_mosaic',
        'phid_k_prd_walls_cladding_murals',
        'phid_k_prd_walls_cladding_borders',
        'phid_k_prd_walls_cladding_tiles',
        'phid_k_prd_walls_cladding_veneer',
        'phid_k_prd_walls_cladding_panels',
        'phid_k_prd_walls_cladding_wood',
        'phid_k_prd_walls_cladding_metal',
        'phid_k_prd_walls_cladding_wallpaper',
      ],
    ),
    // ----------------------------------
    /// Room Partitions
    Chain(
      id: 'phid_k_sub_prd_walls_partitions',
      icon: null,
      phraseID: 'phid_k_sub_prd_walls_partitions',
      sons: <String>[
        'prd_walls_partitions_screens',
        'prd_walls_partitions_showerStalls',
        'prd_walls_partitions_doubleWalls',
      ],
    ),
    // ----------------------------------
    /// Moldings & Millwork
    Chain(
      id: 'phid_k_sub_prd_walls_moldings',
      icon: null,
      phraseID: 'phid_k_sub_prd_walls_moldings',
      sons: <String>[
        'prd_walls_molding_rail',
        'prd_walls_molding_onlay',
        'prd_walls_molding_column',
        'prd_walls_molding_medallion',
        'prd_walls_molding_corbel',
      ],
    ),
    // ----------------------------------
    /// Ceiling Cladding
    Chain(
      id: 'phid_k_sub_prd_walls_ceiling',
      icon: null,
      phraseID: 'phid_k_sub_prd_walls_ceiling',
      sons: <String>[
        'prd_walls_ceiling_tiles',
      ],
    ),
  ],
);
