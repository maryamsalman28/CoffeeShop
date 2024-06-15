import 'package:flutter/material.dart';
import 'package:fluttertest/components/button.dart';
import 'package:fluttertest/themes/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';

class InformationPage extends StatefulWidget {
  const InformationPage({Key? key}) : super(key: key);

  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  String _locationMessage = "";
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _subscription;

  @override
  void initState() {
    super.initState();
_subscription = _connectivity.onConnectivityChanged.map((results) => results.first).listen(_updateConnectionStatus);    _checkConnection();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _locationMessage = 'Location services are disabled.';
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _locationMessage = 'Location permissions are denied';
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _locationMessage = 'Location permissions are permanently denied, we cannot request permissions.';
      });
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _locationMessage = "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
    });
  }

  Future<void> _checkConnection() async {
  ConnectivityResult result;
  try {
    // Assuming checkConnectivity returns a List<ConnectivityResult>, take the first item
    result = (await _connectivity.checkConnectivity())[0];
  } on Exception catch (e) {
    result = ConnectivityResult.none;
  }
  return _updateConnectionStatus(result);
}

  void _updateConnectionStatus(ConnectivityResult result) {
    setState(() {
      switch (result) {
        case ConnectivityResult.wifi:
          _connectionStatus = 'Connected to Wi-Fi';
          break;
        case ConnectivityResult.mobile:
          _connectionStatus = 'Connected to Mobile Network';
          break;
        case ConnectivityResult.ethernet:
          _connectionStatus = 'Connected to Ethernet';
          break;
        case ConnectivityResult.bluetooth:
          _connectionStatus = 'Connected to Bluetooth';
          break;
        case ConnectivityResult.none:
          _connectionStatus = 'No Network Connection';
          break;
        default:
          _connectionStatus = 'Unknown Network Status';
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Theme.of(context).colorScheme.background,
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyButton(
                    color: Theme.of(context).colorScheme.primary,
                    onTap: () {
                      Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                    },
                  ),
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(129, 238, 238, 238),
                      border: Border.all(
                        color: Colors.brown,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'About Coffee Cove!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Playball',
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'At Coffee Cove, we are passionate about serving high-quality coffee in a cozy and welcoming atmosphere. Our commitment to excellence extends beyond our coffee beans; we prioritize customer satisfaction and strive to create a memorable experience with every cup.',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Our Values:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Playball',
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '- Quality: We source the finest coffee beans and ingredients to ensure the best possible taste in every cup.',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '- Community: Coffee Cove is more than just a café; it\'s a place where friends gather, ideas flow, and connections are made.',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '- Sustainability: We are committed to environmentally-friendly practices, from sourcing ethically-produced beans to reducing waste in our operations.',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Visit us today and experience the warmth and flavor of Coffee Cove!',
                          style: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _getCurrentLocation,
                          child: Text('Get Current Location'),
                        ),
                        SizedBox(height: 8),
                        Text(_locationMessage),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _checkConnection,
                          child: Text('Check Connection'),
                        ),
                        SizedBox(height: 8),
                        Text('Connection Status: $_connectionStatus'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
