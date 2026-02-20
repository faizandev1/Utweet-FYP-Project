import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_twitter_clone/model/user.dart';
import 'package:flutter_twitter_clone/state/feedState.dart';
import 'package:flutter_twitter_clone/state/searchState.dart';
import 'package:provider/provider.dart';

class AllUserOnMapPage extends StatefulWidget {
  const AllUserOnMapPage({Key? key, this.scaffoldKey}) : super(key: key);

  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  State<StatefulWidget> createState() => _AllUserOnMapPage();
}

class _AllUserOnMapPage extends State<AllUserOnMapPage> {
  late MapController osmController;

  List<StaticPositionGeoPoint> userMarkers = [];

  getAllUser()async{
    final state = Provider.of<FeedState>(context, listen: false);
    List<UserModel> users = await state.fetchAllUsersFromRealtimeDB();
    print("Fetched: ${users.length} users");

    List<StaticPositionGeoPoint> markers = [];

    setState(() {


    markers.add(
      StaticPositionGeoPoint(
        'currentUserID', // Unique id for each marker group
        MarkerIcon(
          icon: Icon(
            CupertinoIcons.location_solid,
            color: Colors.blue,
            size: 48,
          ),
        ),
        [
          GeoPoint(latitude: double.parse(state.lat.toString()), longitude: double.parse(state.lng.toString())),
        ],
      ),
    );

    });

    for (var user in users) {
      if (user.lat != 0 && user.lng != 0 || user.lat != '' && user.lng != '') {
        markers.add(
          StaticPositionGeoPoint(
            user.email.toString(), // Unique id for each marker group
            MarkerIcon(
              icon: Icon(
                CupertinoIcons.person_alt_circle,
                color: Colors.green,
                size: 48,
              ),
            ),
            [
              GeoPoint(latitude: double.parse(user.lat.toString()), longitude: double.parse(user.lng.toString())),
            ],
          ),
        );
      }
    }

    setState(() {
      userMarkers = markers;
    });

  }

  @override
  void initState() {
    final state = Provider.of<FeedState>(context, listen: false);
    osmController = MapController.withPosition(
      initPosition: GeoPoint(
        latitude: double.parse(state.lat.toString()),
        longitude: double.parse(state.lng.toString()),
      ),
    );
    getAllUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<FeedState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('All Users on Map'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          getAllUser();
          // Refresh logic
        },
        child: OSMFlutter(
          onMapMoved: (region) {
            print('Region $region');
          },
          controller: osmController,
          osmOption: OSMOption(
            enableRotationByGesture: true,
            // userTrackingOption: const UserTrackingOption(
            //   enableTracking: true,
            //   unFollowUser: true,
            // ),
            zoomOption: const ZoomOption(
              initZoom: 8,
              minZoomLevel: 3,
              maxZoomLevel: 19,
              stepZoom: 1.0,
            ),
            roadConfiguration: const RoadOption(
              roadColor: Colors.yellowAccent,
            ),
            staticPoints: userMarkers,
            // staticPoints: [
            //   StaticPositionGeoPoint(
            //     '',
            //     MarkerIcon(
            //       icon: Icon(CupertinoIcons.location_solid, color: Colors.red,size: 50,),
            //     ),
            //     [
            //       GeoPoint(
            //         latitude: double.parse(state.lat.toString()),
            //         longitude: double.parse(state.lng.toString()),
            //       ),
            //     ],
            //   ),
            // ],
          ),
        ),
      ),
    );
  }
}


