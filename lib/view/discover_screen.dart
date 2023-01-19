import 'dart:async';
import 'dart:typed_data';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jobtask/components/drawer.dart';
import 'dart:ui' as ui;
import 'dart:ui';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  String maptheme = '';
  final Completer<GoogleMapController> _controller = Completer();
  final List<Marker> _marker = [];

  final List<LatLng> _latLang = const [
    LatLng(31.4504, 73.1350), // Faisalabad
    LatLng(31.4620, 73.1486), // NTU Faisalabad
    LatLng(31.4576, 73.1581), // TUF Faisalabad
  ];

  // Initial Position
  static const CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(31.4504, 73.1350), zoom: 15);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Theme Setting
    DefaultAssetBundle.of(context)
        .loadString('assets/maptheme/silver_theme.json')
        .then((value) {
      maptheme = value;
    });
    // Load Image on Map
    loadLocation();
  }

  // Load Image on Map
  loadLocation() async {
    for (int i = 0; i < _latLang.length; i++) {
      Uint8List? image = await loadImage('assets/images/avatar.png');
      final ui.Codec markerImage = await instantiateImageCodec(
        image!.buffer.asUint8List(),
        targetHeight: 100,
        targetWidth: 130,
      );
      final ui.FrameInfo frameInfo = await markerImage.getNextFrame();
      final ByteData? byteData =
          await frameInfo.image.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List resizedImageMarker = byteData!.buffer.asUint8List();
      _marker.add(
        Marker(
            markerId: MarkerId(i.toString()),
            position: _latLang[i],
            icon: BitmapDescriptor.fromBytes(resizedImageMarker),
            onTap: () {
              _customInfoWindowController.addInfoWindow!(
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.green[400],
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                        ),
                        child: const ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(
                              'assets/images/avatar.png',
                            ),
                          ),
                          title: Text('Usama Sadiq'),
                          subtitle: Text('Posted: 2hr ago'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Daily Bread',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            const LinearProgressIndicator(
                              backgroundColor: Colors.black,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.green),
                              value: 0.5,
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '5000 raised out 10,000 PKR',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Colors.green[300],
                                  ),
                                ),
                                Row(
                                  children: const [
                                    Icon(
                                      Icons.share_outlined,
                                      size: 18,
                                    ),
                                    SizedBox(width: 5),
                                    Icon(
                                      Icons.favorite_border_outlined,
                                      size: 18,
                                    )
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Occupation: Office boy',
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Salary: 14,000 PKR',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  'Family Member: 5',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                _latLang[i],
              );
            }),
      );
      setState(() {});
    }
  }

  Future<Uint8List?> loadImage(String path) async {
    final completer = Completer<ImageInfo>();
    var image = AssetImage(path);
    image.resolve(ImageConfiguration()).addListener(
          ImageStreamListener(
            (info, _) => completer.complete(info),
          ),
        );
    final imageInfo = await completer.future;
    final byteData =
        await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);

    return byteData!.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: const Text('Discover'),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                size: screenHeight * 0.035,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              markers: Set<Marker>.of(_marker),
              onTap: (position) {
                _customInfoWindowController.hideInfoWindow!();
              },
              onCameraMove: (position) {
                _customInfoWindowController.onCameraMove!();
              },
              onMapCreated: (GoogleMapController controller) {
                controller.setMapStyle(maptheme);
                _controller.complete(controller);
                _customInfoWindowController.googleMapController = controller;
              },
            ),
            CustomInfoWindow(
              controller: _customInfoWindowController,
              height: screenHeight / 4,
              width: screenWidth * 0.8,
              offset: 35,
            )
          ],
        ),
      ),
    );
  }
}
