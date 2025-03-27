import 'package:flutter/material.dart';
import 'package:solar_axis_app/theme.dart';
import 'camera_page.dart';
import 'info_page.dart';
import 'home_page.dart';

class SensorPage extends StatelessWidget {
  const SensorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.purple,
      appBar: AppBar(
        title: const Text("Sensor Data", style: TextStyle(color: AppColors.cream)),
        centerTitle: true,
        backgroundColor: AppColors.deepPurple,
        leading: IconButton(
          icon: const Text("Back", style: TextStyle(color: AppColors.cream)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const Center(
        child: Text(
          "~ DATA ~",
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.cream, fontSize: 20),
        ),
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
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CameraPage())),
          child: const Text("Camera", style: TextStyle(color: AppColors.deepPurple)),
        ),
        TextButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage())),
          child: const Text("Home", style: TextStyle(color: AppColors.deepPurple)),
        ),
        TextButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const InfoPage())),
          child: const Text("Info", style: TextStyle(color: AppColors.deepPurple)),
        ),
      ],
    ),
  );
}
