// import 'dart:async';
// import 'dart:ui' as ui;
// import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
// import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
// import 'package:bldrs/x_dashboard/zz_widgets/dashboard_layout.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:filers/filers.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_earth/flutter_earth.dart';
// import 'package:flutter_cube/flutter_cube.dart';
// import 'package:scale/scale.dart';
//
// class PlanetTestScreen extends StatefulWidget {
// // -----------------------------------------------------------------------------
//   const PlanetTestScreen({
//     Key key
//   }) : super(key: key);
//
//   @override
//   State<PlanetTestScreen> createState() => _PlanetTestScreenState();
// }
//
// class _PlanetTestScreenState extends State<PlanetTestScreen> {
//   // -----------------------------------------------------------------------------
//   ValueNotifier<bool> _isMoving = ValueNotifier(false);
//   // Declare a boolean variable to keep track of whether the camera is moving or not
//   bool _isCameraMoving = false;
//   // Declare a Timer variable to handle the cooldown period
//   Timer _cooldownTimer;
//   // -----------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//
//     return DashBoardLayout(
//         listWidgets: <Widget>[
//
//
//
//         Center(
//           child: Container(
//             width: Scale.screenWidth(context),
//             height: Scale.screenWidth(context),
//             child: FlutterEarth(
//               // key: ,
//               url: 'http://mt0.google.com/vt/lyrs=y&hl=en&x={x}&y={y}&z={z}',
//               radius: Scale.screenWidth(context) / 2,
//               maxVertexCount: 1500,
//               onCameraMove: (LatLon latlon, double zoom) async {
//                 blog('onCameraMove: ${latlon} : zoom ${zoom}');
//
//                 // Set the _isCameraMoving flag to true
//                 _isCameraMoving = true;
//
//                 // Cancel any previous cooldown timers
//                 _cooldownTimer?.cancel();
//
//                 // Start a new cooldown timer that will set _isCameraMoving to false
//                 // after 1 second
//                 _cooldownTimer = Timer(const Duration(seconds: 1), () async {
//                   _isCameraMoving = false;
//                   blog('stopped moving');
//
//                   final ZoneModel _zoneModel = await ZoneProtocols.fetchZoneModelByGeoPoint(
//                     context: context,
//                     geoPoint: GeoPoint(latlon.latitude, latlon.longitude,),
//                   );
//
//                   _zoneModel?.blogZone();
//
//                 });
//
//               },
//               onMapCreated: (FlutterEarthController controller) async {
//                 // blog('onMapCreated: ${controller}');
//                 // final LatLon latlon = controller.position;
//                 // final bool isAnimating = controller.isAnimating;
//                 // final double zoom = controller.zoom;
//                 // final EulerAngles angs = controller.eulerAngles;
//                 // final Quaternion quat = controller.quaternion;
//                 //
//                 // blog('onMapCreated : latlon: $latlon : isAnimating: $isAnimating : zoom: $zoom : '
//                 //     '$angs : ${angs.pitch} : ${angs.yaw} : ${angs.roll} : ${quat}');
//               },
//               onTileEnd: (Tile tile) async {
//                 // blog('onTileEnd: status ${tile.status} : ${tile.x}, ${tile.y}, ${tile.z}');
//                 // final ui.Image image = tile.image;
//               },
//               onTileStart: (Tile tile) async {
//                 // blog('onTileStart: status ${tile.status} : ${tile.x}, ${tile.y}, ${tile.z}');
//                 // final ui.Image image = tile.image;
//               },
//               showPole: true,
//             ),
//           ),
//
//         ),
//
//       ],
//     );
//
//   }
// }
//
// class Planet extends StatefulWidget {
//
//   const Planet({
//     @required this.interactive,
//     Key key,
//   }) : super(key: key);
//
//   final bool interactive;
//
//   @override
//   State<Planet> createState() => _PlanetState();
//
// }
//
// class _PlanetState extends State<Planet> with SingleTickerProviderStateMixin {
//
//   Scene _scene;
//   Object _earth;
//   AnimationController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = AnimationController(
//         duration: const Duration(milliseconds: 30000), vsync: this)
//       ..addListener(() {
//         if (!widget.interactive) {
//           if (_earth != null) {
//             _earth.rotation.x = _controller.value * -360;
//             _earth.updateTransform();
//             _scene.update();
//           }
//         }
//       })
//       ..repeat();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//
//     super.dispose();
//   }
//
//   void _onSceneCreated(Scene scene) {
//     _scene = scene;
//     if (widget.interactive) {
//       _scene.camera.position.z = 20;
//     } else {
//       _scene.camera.position.z = 13;
//     }
//
//     // model from https://free3d.com/3d-model/planet-earth-99065.html
//     _earth = Object(
//         name: 'earth',
//         scale: Vector3(10.0, 10.0, 10.0),
//         backfaceCulling: false,
//         fileName: 'assets/earth/earth.obj');
//
//     _scene.world.add(_earth);
//
//     // texture from https://www.solarsystemscope.com/textures/
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return SizedBox(
//       height: MediaQuery.of(context).size.height,
//       width: MediaQuery.of(context).size.width,
//       child: TweenAnimationBuilder<double>(
//           duration: Duration.zero,
//           curve: Curves.easeIn,
//           tween: Tween(begin: 0, end: 1),
//           builder: (context, animation, child) {
//             return Opacity(
//               opacity: animation,
//               child: Cube(
//                 onObjectCreated: (object) {},
//                 onSceneCreated: _onSceneCreated,
//                 interactive: widget.interactive,
//               ),
//             );
//           }),
//     );
//
//   }
//
// }
