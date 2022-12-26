import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_automation/flutter_automation.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

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

class BikinFile extends StatefulWidget {
  const BikinFile({Key? key}) : super(key: key);

  @override
  State<BikinFile> createState() => _BikinFileState();
}

class _BikinFileState extends State<BikinFile> {
  var _content;

  var data1 =
      "trxfile=9|donasi=9|getsku=9|discmaxbp=50|po1=9|po2=1|paywp=9|paywp_limit=25|paywp_usage=1333|paywp_convr=75|paywp_max_trx=3|discman=9|tax1=11|tax2=11|";
  var data2 =
      "HEAD1=PT. RAMAYANA LESTARI SENTOSA, TBK|HEAD2=Jl. Wahid Hasyim 220 A-B Jakarta Pusat|HEAD3=NPWP:  01.365.481.9-092.000|HEAD4=TGL PKP:  21 Mei 1991|HEAD5=BARANG KENA PAJAK, HARGA TERMASUK PPN|IPSOAP=172.16.107.11|MANUALDISC=Y|TOKO1=RRHO^/home/kresno.sadmoko/wpi/dat/|TOKO2=SRHO^/home/kresno.sadmoko/wpi/dat/|";

  // Read the file
  String? value;

  Future<String> get _getDirPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  // Future<void> _readData(path) async {
  //   final dirPath = await _getDirPath;
  //   final myFile = File(path);
  //   final data = await myFile.readAsString(encoding: utf8);
  //   setState(() {
  //     _content = data;
  //   });
  // }

  Future<void> _readDataFile() async {
    final dirPath = await _getDirPath;
    final myFile = File('/home/dev/.server/.pos/config1.cfg');
    final data = await myFile.readAsString(encoding: utf8);
  }

  // Future<void> _readDataFile2() async {
  //   final dirPath = await _getDirPath;
  //   final myFile = File('/home/dev/.server/.pos/config2.cfg');
  //   final data = await myFile.readAsString(encoding: utf8);
  //   setState(() {
  //     _content = data;
  //   });
  // }

  Future<String> _read2(String path) async {
    String text = "";
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      // final File file = File("${path}");
      final File file = File(path);
      text = await file.readAsString().then((String contents) => contents);
    } catch (e) {
      print("Couldn't read file");
    }
    return text;
  }

  late var dapatData1 = _read2('/home/dev/.server/.pos/config1.cfg');
  late var dapatData2 = _read2('/home/dev/.server/.pos/config2.cfg');

  // late var dapatData1 = data1;
  // late var dapatData2 = data2;

  // late var dapatData1 = file;
  // late var dapatData2 = file2;

  Iterable formatData(data) {
    List<String> splitted = data.split("|");
    splitted.removeWhere((item) => item.isEmpty);
    return splitted.map((item) => item.split("=")).toList();
  }

  late var importedData1 = formatData(dapatData1);
  late var importedData2 = formatData(dapatData2);
  // late var importedData3 = formatData(data2).toList(); //config2 with TOKO1 dan TOKO2

  var map1 = <String, int>{};
  var map2 = <String, String>{};
  var map3 = <String, String>{};

  var finalWrite = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (var item in importedData1) {
      map1[item[0]] = int.parse(item[1]);
    }
    for (var item in importedData2) {
      map2[item[0]] = item[1];
    }
    // for (var item in importedData3) {
    //   map3[item[0]] = item[1];
    // }
    map2.remove("TOKO2");
    map2.remove("TOKO1");

    finalWrite.addAll(map1);
    finalWrite.addAll(map2);

    print(finalWrite["donasi"]);
  }

  _exportData(String text, String name) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('/home/dev/.server/.pos/${name}');
    await file.writeAsString(text);
  }

  // late var getData1 = _read2('/home/dev/.server/.pos/config1.cfg');
  // late var getData2 = _read2('/home/dev/.server/.pos/config2.cfg');

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
              Text(_content.toString() ?? 'Press'),
              MaterialButton(
                onPressed: () async {
                  setState(() {
                    // _content = finalWrite["donasi"];
                    // _readDataFile2();
                  });
                },
                color: Colors.red,
                child: Text(
                  'Read Data',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              MaterialButton(
                onPressed: () async {
                  _exportData(finalWrite.toString(), 'pos.cfg');
                  // print(data1);
                  // _readData();
                },
                color: Colors.green,
                child: Text(
                  'Create File',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
