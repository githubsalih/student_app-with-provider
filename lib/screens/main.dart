

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:studentapp/infrastructure/db_functions.dart';
import 'package:studentapp/screens/all_students_screen.dart';
import '../models/student_model.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();


  final cameras = await availableCameras();

final firstCamera = cameras.first;

 await Hive.initFlutter();
 if(!Hive.isAdapterRegistered(StudentModelAdapter().typeId)){
    Hive.registerAdapter(StudentModelAdapter());
 }
  runApp(
      MyApp(selectedcamera: firstCamera) ,
   );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.selectedcamera}) : super(key: key);

 final  CameraDescription selectedcamera;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) =>  StudentModelFunction()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:  AllStudentsScreen(cam:selectedcamera ),
      ),
    );
  }
}

