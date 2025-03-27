import 'package:flutter/material.dart';
import 'package:solar_axis_app/theme.dart';
import 'package:solar_axis_app/robot_control_button.dart';
import 'dart:async';
// import 'theme.dart';
import 'power_page.dart';
import 'weather_page.dart';
import 'remote.dart';
import 'globals.dart';
import 'bluetooth_handler.dart';
import 'bluetooth.dart';
import 'camera_page.dart';
import 'info_page.dart';
import 'sensor_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Bluetooth functions start
  @override
  void initState() {
    super.initState();
    //bleHandler = BLEHandler(setStateCallback);
    //TODO run at startup
  }

  void setStateCallback() {
    setState(() {});
  }

  void disconnectDevice() {
    setState(() {
      //bleHandler.disconnect();
    });
  }

  // void connectDevicePrompt() {
  //   // Show prompt for connecting a device
  //   showModalBottomSheet<void>(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return const BluetoothConnectScreen();
  //       });
  // }
  //Bluetooth functions end

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.purple,
      appBar: AppBar(
        title: const Text(
          "Welcome to WECE’s",
          style: TextStyle(color: AppColors.cream, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.deepPurple,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'images/logo.png',
              width: 200,
              height: 200,
            ),
          ),
          const SizedBox(height: 20),
          //BLUETOOTH CONNECTION BUTTON
          // if (bleHandler.connectedDevice == null)
          // Column(
          //   children: [
          //     Container(
          //       alignment: Alignment.center,
          //       margin: const EdgeInsets.only(left:20),
          //       child: const Text(
          //         "Please connect a device",
          //         style: TextStyle(fontSize: 28,color: AppColors.cream),
          //       ),
          //     ),
          //     Container(
          //       alignment: Alignment.center,
          //       margin: const EdgeInsets.only(left:20),
          //       child: ElevatedButton(
          //         onPressed: connectDevicePrompt,
          //         child: const Text(
          //           "Connect",
          //           style: TextStyle(fontSize: 28,color: AppColors.cream),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          // if (bleHandler.connectedDevice != null)
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RobotControlButton(
                    label: "Left",
                    // onPressStart: () {
                    //   print("Move Left: START");
                    //   // Add your BLEHandler left command
                    // },
                    // onPressEnd: () {
                    //   print("Move Left: STOP");
                    //   // Add your BLEHandler stop command
                    // },
                  ),
                  const SizedBox(width: 10),
                  RobotControlButton(
                    label: "Go!",
                    // onPressStart: () {
                    //   print("Move Forward: START");
                    //   // Add your BLEHandler forward command
                    // },
                    // onPressEnd: () {
                    //   print("Move Forward: STOP");
                    //   // Add your BLEHandler stop command
                    // },
                  ),
                  const SizedBox(width: 10),
                  RobotControlButton(
                    label: "Right",
                    // onPressStart: () {
                    //   print("Move Right: START");
                    //   // Add your BLEHandler right command
                    // },
                    // onPressEnd: () {
                    //   print("Move Right: STOP");
                    //   // Add your BLEHandler stop command
                    // },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              RobotControlButton(
                label: "Back",
                // onPressStart: () {
                //   print("Move Back: START");
                //   // Add your BLEHandler backward command
                // },
                // onPressEnd: () {
                //   print("Move Back: STOP");
                //   // Add your BLEHandler stop command
                // },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CameraPage()),
                    ),
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.cream),
                    child: const Text("Camera", style: TextStyle(color: AppColors.deepPurple)),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const InfoPage()),
                    ),
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.cream),
                    child: const Text("Info", style: TextStyle(color: AppColors.deepPurple)),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SensorPage()),
                    ),
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.cream),
                    child: const Text("Sensors", style: TextStyle(color: AppColors.deepPurple)),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
