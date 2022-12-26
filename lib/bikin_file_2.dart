import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_automation/flutter_automation.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:project_pos/baca_database.dart';
import 'package:project_pos/database_instance.dart';


_createFolder() async {
  final folderName = "dbPos";
  final path = Directory("/home/dev/$folderName");
  if ((await path.exists())) {
    // TODO:
    print("exist");
  } else {
    // TODO:
    print("not exist");
    path.create();
  }
}

_createFolder2() async {
  final folderName2 = "log";
  final path2 = Directory("/home/dev/dbPos/$folderName2");
  if ((await path2.exists())) {
    // TODO:
    print("exist");
  } else {
    // TODO:
    print("not exist");
    path2.create();
  }
}

_createFolder3() async {
  final folderName3 = "transaksi";
  final path3 = Directory("/home/dev/dbPos/$folderName3");
  if ((await path3.exists())) {
    // TODO:
    print("exist");
  } else {
    // TODO:
    print("not exist");
    path3.create();
  }
}

_createFolder4() async {
  final folderName4 = "txt";
  final path4 = Directory("/home/dev/dbPos/$folderName4");
  if ((await path4.exists())) {
    // TODO:
    print("exist");
  } else {
    // TODO:
    print("not exist");
    path4.create();
  }
}

class BikinFileBaru extends StatefulWidget {
  @override
  State<BikinFileBaru> createState() => _BikinFileBaruState();
}

class _BikinFileBaruState extends State<BikinFileBaru> {
  String? _content;

  Future<String> get _getDirPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<void> _readDataFile() async {
    final dirPath = await _getDirPath;
    final myFile = File('/home/dev/.server/.pos/pos.cfg');
    final data = await myFile.readAsString(encoding: utf8);
  }

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

      File output_pathnya = File('/home/dev/.config/flutter/pos.cfg');
      output_pathnya.writeAsString('$result');
      print("cobaa 44${conf1_map['MANUALDISC']}");
    } catch (e) {
      print('tess gak mau $e');
    }
  }

  DatabaseInstance databaseInstance = new DatabaseInstance();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MaterialButton(
                onPressed: () async {
                  setState(() {
                    _createFolder();
                    _createFolder2();
                    _createFolder3();
                    _createFolder4();
                  });
                },
                color: Colors.blue,
                child: Text(
                  'Create Folder',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              MaterialButton(
                onPressed: () async {
                  readCounter();
                },
                color: Colors.green,
                child: Text(
                  'Create File',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              MaterialButton(
                onPressed: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (builder) {
                    return EmployeeListPage();
                  })).then((value) {
                    setState(() {});
                  });
                },
                color: Colors.green,
                child: Text(
                  'Cek Database',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              // Text(_content ?? 'Press'),
              // MaterialButton(
              //   onPressed: () async {
              //     setState(() async {

              //     });
              //   },
              //   color: Colors.red,
              //   child: Text(
              //     'Read Data',
              //     style: TextStyle(color: Colors.white),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
