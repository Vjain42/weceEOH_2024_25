import 'package:flutter/material.dart';
import 'package:solar_axis_app/theme.dart';
// import 'theme.dart';
import 'globals.dart';

class PowerInfo extends StatefulWidget {
  const PowerInfo({Key? key}) : super(key: key);

  @override
  State<PowerInfo> createState() => _PowerPageState();
}
class _PowerPageState extends State<PowerInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Power Information"),
        backgroundColor: AppColors.indigo,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                     Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.yellow1,
                      border: Border.all(width: 8, color: AppColors.yellow2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    // Change button text when clicked.
                    child: const Text(
                      'Power Calculation',
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: TextStyle(color: AppColors.black, fontSize:45),
                    ),
                  ),
                ] //children
            ),
             Padding(
                  padding: const EdgeInsets.all(32),
                  child: Text(
                    'Power = current x voltage'
                        '\n\n From our device we found we have:'
                        '\n Current = $current A'
                        '\n Voltage = $voltage V'
                    '\n\n Power = ${current*voltage} W',
                    softWrap: true,
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppColors.black, fontSize:23),
                  ),
                  ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: ElevatedButton(
                      child: const Text("Back to HomePage"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: AppColors.white, backgroundColor: AppColors.purple,
                      ),
                    ),
                ),
              ),
            ),
          ],
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
