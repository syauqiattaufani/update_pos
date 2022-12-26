import 'package:flutter/material.dart';
import 'package:project_pos/RouteScreen.dart';
import 'package:project_pos/bikin_file.dart';
import 'package:project_pos/bikin_file_2.dart';
import 'package:project_pos/desktop_transaksi2.dart';
import 'package:project_pos/login2.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_automation/flutter_automation.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => ResponsiveWrapper.builder(
        child,
        maxWidth: 1024,
        minWidth: 480,
        defaultScale: true,
        breakpoints: [
          ResponsiveBreakpoint.autoScale(600, name: PHONE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ResponsiveBreakpoint.autoScale(1024, name: DESKTOP),
        ],
      ),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BikinFileBaru(),
    );
  }
}
