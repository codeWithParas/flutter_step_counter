import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

class StepCounterScreen extends StatefulWidget {
  const StepCounterScreen({super.key});

  @override
  State<StepCounterScreen> createState() => _StepCounterScreenState();
}

class _StepCounterScreenState extends State<StepCounterScreen> {

  late Stream<StepCount> _stepCountStream;
  int _steps = 0;
  String _status = "No Pedometer";

  @override
  void initState() {
    super.initState();

    // Will execute only once
    _requestPermisionAndInitPedometer();
  }

  // Check for permissions
  Future<void> _requestPermisionAndInitPedometer() async {

    PermissionStatus status = await Permission.activityRecognition.request();

    if(status.isGranted) {
      setState(() {
        _status = "Pedometer Active";
      });
      initPedometer();
    }
    else if(status.isDenied) {
      setState(() {
        _status = "Permission Denied. Please give permission.";
      });
    }
    else if(status.isPermanentlyDenied) {
      setState(() {
        _status = "Permission Permanently Denied. Please give permission from Setting.";
      });
    }
    else {
      // Error
      setState(() {
        _status = 'Permission Status $status';
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("Pedometer App"),
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Step Count : ", style: TextStyle(fontSize: 30)),
            Text('$_steps', style: TextStyle(fontSize: 40)),
            Text('Permission Status -> $_status', style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }

  void initPedometer() {

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
  }

  void onStepCount(StepCount stepCountEvent){
    setState(() {
      _steps = stepCountEvent.steps;
    });
  }

  void onStepCountError(error){
    setState(() {
      _steps = 0;
    });
  }
}

