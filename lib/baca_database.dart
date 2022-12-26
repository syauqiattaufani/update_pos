import 'package:flutter/material.dart';
import 'package:project_pos/database_instance.dart';
import 'model.dart';
import 'package:project_pos/model.dart';

List<Employee> employee_list = [];

class EmployeeListPage extends StatefulWidget {
  @override
  _EmployeeListPageState createState() => new _EmployeeListPageState();
}

class _EmployeeListPageState extends State<EmployeeListPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async {
    var dbHelper = DatabaseInstance();
    List<Employee> _employee_list = await dbHelper.getEmployees();
    setState(() {
      employee_list = _employee_list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Employee Names'),
      ),
      body: Center(
        child: Container(
            child: ListView.separated(
                separatorBuilder: (context, index) =>
                    Divider(height: 0.5, color: Colors.black38),
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: employee_list == null ? 0 : employee_list.length,
                itemBuilder: (context, index) {
                  return new Container(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      employee_list[index].code + ' ' + employee_list[index].pass,
                    ),
                  );
                })),
      ),
    );
  }
}
