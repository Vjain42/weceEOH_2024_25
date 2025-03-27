import 'package:flutter/material.dart';
import 'package:solar_axis_app/theme.dart';
import 'package:solar_axis_app/robot_control_button.dart';
import 'info_page.dart';
import 'sensor_page.dart';
import 'home_page.dart';
import 'camera.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.purple,
      appBar: AppBar(
        title: const Text("Camera View", style: TextStyle(color: AppColors.cream)),
        centerTitle: true,
        backgroundColor: AppColors.deepPurple,
        leading: IconButton(
          icon: const Text("Back", style: TextStyle(color: AppColors.cream)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const ArducamStreamPage(), // This will show the video stream inside the CameraPage
          const SizedBox(height: 20), // Space between video and buttons
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
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RobotControlButton(
                label: "Wave",
                // onPressStart: () {
                //   print("Wave: START");
                //   // Add your BLEHandler wave command
                // },
                // onPressEnd: () {
                //   print("Wave: STOP");
                //   // Add your BLEHandler stop command
                // },
              ),
              const SizedBox(width: 10),
              RobotControlButton(
                label: "Climb",
                // onPressStart: () {
                //   print("Climb: START");
                //   // Add your BLEHandler climb command
                // },
                // onPressEnd: () {
                //   print("Climb: STOP");
                //   // Add your BLEHandler stop command
                // },
              ),
              const SizedBox(width: 10),
              RobotControlButton(
                label: "Dance",
                // onPressStart: () {
                //   print("Dance: START");
                //   // Add your BLEHandler dance command
                // },
                // onPressEnd: () {
                //   print("Dance: STOP");
                //   // Add your BLEHandler stop command
                // },
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: buildBottomNavBar(context),
    );
  }
}

Widget buildBottomNavBar(BuildContext context) {
  return BottomAppBar(
    color: AppColors.cream,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const InfoPage())),
          child: const Text("Info", style: TextStyle(color: AppColors.deepPurple)),
        ),
        TextButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage())),
          child: const Text("Home", style: TextStyle(color: AppColors.deepPurple)),
        ),
        TextButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SensorPage())),
          child: const Text("Sensors", style: TextStyle(color: AppColors.deepPurple)),
        ),
      ],
    ),
  );
}
