import 'dart:collection';

import 'package:customer_flutter/db/database.dart';
import 'package:customer_flutter/main.dart';
import 'package:customer_flutter/utils/HexColor.dart';
import 'package:customer_flutter/utils/MPreference.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moor_flutter/moor_flutter.dart' as moor;
import 'package:provider/provider.dart';

class AddEditProfile extends StatefulWidget {
  User user;

  @override
  _AddEditProfileState createState() => _AddEditProfileState(user);

  AddEditProfile({Key key, this.user}) : super(key: key);
}

class _AddEditProfileState extends State<AddEditProfile> {
  User user;

  var _formKey = GlobalKey<FormState>();

  List<String> spinnerItems = ['Area1', 'Area2', 'Area3', 'Area4', 'Area5'];

  String dropdownValue = 'Area1';

  UsersDao _usersDao;

  MPreference preference;

  TextEditingController _controllerName,
      _controllerSNo,
      _controllerMob,
      _controllerNotes;

  _AddEditProfileState(this.user);

  void onPressed() {
    Navigator.popAndPushNamed(context, '/home');
  }

  @override
  void initState() {
    super.initState();
    _controllerName = TextEditingController();
    _controllerSNo = TextEditingController();
    _controllerMob = TextEditingController();
    _controllerNotes = TextEditingController();
    if (user != null) {
      _controllerName.text = user.name;
      _controllerSNo.text = user.stbNo;
      _controllerMob.text = user.mobile;
      _controllerNotes.text = user.notes;
      dropdownValue = user.area;
    }
  }

  @override
  void didChangeDependencies() {
    // user = ModalRoute.of(context).settings.arguments;
    _usersDao = Provider.of<Repository>(context).getUserDao();
    preference = Provider.of<MPreference>(context);
    Future.delayed(Duration.zero, () => _setSpinnerList());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.done),
            onPressed: _validate,
          )
        ],
        title: Text(user == null ? "Add Customer" : "Edit Customer"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (user != null)
              Divider(
                height: 10,
                thickness: 10,
                color: HexColor("#FAFAFA"),
              ),
            if (user != null) _buildStbNo(),
            Divider(
              height: 10,
              thickness: 10,
              color: HexColor("#FAFAFA"),
            ),
            _buildFormData(),
            Divider(
              height: 10,
              thickness: 10,
              color: HexColor("#FAFAFA"),
            ),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: _controllerNotes,
                  maxLines: 4,
                  minLines: 4,
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  style: TextStyle(
                    fontFamily: 'FontSemi',
                  ),
                  decoration: InputDecoration(
                      alignLabelWithHint: true,
                      labelText: "Notes",
                      hintText: "Make a note of this user"),
                  validator: (value) {
                    if (value.isEmpty) return "Please enter valid name ";
                    return null;
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Card _buildFormData() {
    return Card(
      elevation: 2,
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 20),
          child: Column(
            children: [
              TextFormField(
                controller: _controllerName,
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                style: TextStyle(
                  fontFamily: 'FontSemi',
                ),
                decoration:
                    InputDecoration(labelText: "Name", hintText: "Enter Name "),
                validator: (value) {
                  if (value.isEmpty) return "Please enter valid name ";
                  return null;
                },
              ),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: _controllerSNo,
                textCapitalization: TextCapitalization.characters,
                keyboardType: TextInputType.streetAddress,
                textInputAction: TextInputAction.next,
                style: TextStyle(
                  fontFamily: 'FontSemi',
                ),
                decoration: InputDecoration(
                    labelText: "Serial Number",
                    hintText: "Enter STB No eg: STB-0000725A08TGA"),
                validator: (value) {
                  if (value.isEmpty) return "Please enter valid Serial number ";
                  return null;
                },
              ),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: _controllerMob,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  fontFamily: 'FontSemi',
                ),
                decoration: InputDecoration(
                    // contentPadding: EdgeInsets.all(8),
                    labelText: "Mobile Number",
                    hintText: "Enter Mobile No eg: 9500561160"),
                validator: (value) {
                  if (value.isEmpty) return "Please enter valid Mobile number ";
                  return null;
                },
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Select the Area",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontFamily: 'FontSemi',
                      ),
                    ),
                  ),
                  dropDownWidget()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Card _buildStbNo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${user.stbNo}",
              style: TextStyle(fontFamily: "FontBd", fontSize: 20),
            ),
            InkWell(child: IconButton(icon: Icon(Icons.copy), onPressed: () {}))
          ],
        ),
      ),
    );
  }

  void _validate() async {
    if (_formKey.currentState.validate()) {
      if (user != null) {
        await _usersDao.updateTask(user.copyWith(
            name: _controllerName.text,
            area: dropdownValue,
            stbNo: _controllerSNo.text,
            mobile: _controllerMob.text,
            notes: _controllerNotes.text,
            modifiedDate: DateTime.now()));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('User updated'),
          duration: Duration(seconds: 2),
        ));
      } else {
        var task = UsersCompanion(
            name: moor.Value(_controllerName.text),
            area: moor.Value(dropdownValue),
            stbNo: moor.Value(_controllerSNo.text),
            mobile: moor.Value(_controllerMob.text),
            notes: moor.Value(_controllerNotes.text),
            modifiedDate: moor.Value(DateTime.now()));
        await _usersDao.insertTask(task);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('User Added'), duration: Duration(seconds: 2)));
      }
      Navigator.pop(context);
    }
  }

  Widget dropDownWidget() {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style:
          TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'FontSemi'),
      onChanged: (String data) {
        setState(() {
          dropdownValue = data;
        });
      },
      items: spinnerItems.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  _setSpinnerList() {
    setState(() {
      preference.getUserProfile().then((path) {
        if (path != null) {
          var list = path.listOfArea.split(",");
          if (list.isNotEmpty) {
            for (var i = 0; i < list.length; i++) {
              var element = list[i];
              if (element == ',' || element.trim().isEmpty) {
                list.removeAt(i);
              }
              print("element $element");
            }
            var set = Set.of(list);  //removing duplicates
            list.clear();
            list.addAll(set);
            if (list.isNotEmpty) {
              if (user != null && !list.contains(dropdownValue)) {
                list.add(dropdownValue);
              } else
                dropdownValue = list.first;
                spinnerItems = list;
              print("dropdownValue $dropdownValue");
              print("spinnerItems $spinnerItems");
            }
          }
        }
      });
    });
  }
}
