import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_automation/flutter_automation.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

class viewMenu extends StatefulWidget {
  const viewMenu({super.key});

  @override
  State<viewMenu> createState() => _viewMenuState();
}

class _viewMenuState extends State<viewMenu> {
  late Size size;

  var finalWrite = <String>[];
  Future<void> readCounter() async {
    try {
      final file = File('/home/dev/.server/.pos/config1.cfg');
      final file2 = File('/home/dev/.server/.pos/config2.cfg');

      // Read the file
      final contents = await file.readAsString();
      final contents2 = await file2.readAsString();
      print('hp 888');
      print(contents);

      List<String> config1delay = contents.split('|');
      // config1delay.removeWhere((item) => item.isEmpty);
      config1delay.removeLast();
      List<String> config2delay = contents2.split('|');
      config2delay.removeLast();
      config2delay.removeLast();
      List<String> result = config1delay + config2delay;
      print(result);
      print(result);

      var conf1_map = {};
      for (var isi in result) {
        List<String> resultisi = isi.split('=');
        print('isi nya apa sih $isi \n');
        conf1_map[resultisi[0]] = resultisi[1];
      }
      print('tes conf1_map $conf1_map');
      print("${conf1_map['donasi']}");

      File output_pathnya = File('/home/dev/.server/.pos/pos.cfg');
      output_pathnya.writeAsString('$result');
      print("cobaa 44${conf1_map['MANUALDISC']}");
    } catch (e) {
      print('tess gak mau $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        child: ElevatedButton(
          onPressed: () async {
            await readCounter();
          },
          child: Text(
            'BACA BACA',
            // style: blackFontStyle.copyWith(color: Colors.white),
          ),
          style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
              backgroundColor: MaterialStateProperty.all(Colors.blue)),
        ),
      ),
    );
  }
}
