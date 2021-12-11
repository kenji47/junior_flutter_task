import 'dart:io';

import 'package:flutter/material.dart';
import 'package:junior_test/ui/actions/ActionsWidget.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}
//Handshake error in client (OS Error: I/flutter ( 3177): CERTIFICATE_VERIFY_FAILED: certificate has expired
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ActionsWidget(),
    );
  }
}
