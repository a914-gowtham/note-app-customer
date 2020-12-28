import 'package:customer_flutter/models/UserProfile.dart';
import 'package:customer_flutter/utils/MPreference.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  MPreference preference;
  UserProfile _userProfile;

  TextEditingController _controllerName;

  TextEditingController _controllerAreas;
  var _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controllerName = TextEditingController();
    _controllerAreas = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    preference = Provider.of<MPreference>(context);
    Future.delayed(
        Duration.zero,
        () => setState(() {
              preference.getUserProfile().then((path) {
                _userProfile = path;
                if (_userProfile != null) {
                  _controllerName.text = _userProfile.companyName;
                  _controllerAreas.text = _userProfile.listOfArea;
                }
              });
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.apartment_outlined),
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(flex: 1, child: _getCompanyName())
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.add_location_alt_outlined),
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      flex: 1,
                      child: TextFormField(
                          controller: _controllerAreas,
                          textCapitalization: TextCapitalization.sentences,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          style: TextStyle(
                            fontFamily: 'FontSemi',
                          ),
                          decoration: InputDecoration(
                              alignLabelWithHint: true,
                              labelText: "Areas",
                              hintText: "eg: Anna nagar, Mylapore"),
                          validator: (value) {
                            if (value.isEmpty)
                              return "Please enter valid areas";
                            return null;
                          }),
                    )
                  ],
                ),
                SizedBox(
                  height: 55,
                ),
                RaisedButton(
                  onPressed: () {
                    _onSaveClicked();
                  },
                  child: Text(
                    'Save changes',
                    style: TextStyle(
                        fontFamily: "FontSemi",
                        fontSize: 18,
                        color: Colors.white),
                  ),
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onSaveClicked() {
    if (_formKey.currentState.validate()) {
      UserProfile profile =
          UserProfile(_controllerName.text, _controllerAreas.text);
      preference.saveProfile(profile);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Profile updated'),
        duration: Duration(seconds: 1),
      ));
      Navigator.pop(context);
    }
  }

  Widget _getCompanyName() {
    return TextFormField(
      controller: _controllerName,
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      style: TextStyle(
        fontFamily: 'FontSemi',
      ),
      decoration:
          InputDecoration(alignLabelWithHint: true, labelText: "Company Name"),
      validator: (value) {
        if (value.isEmpty) return "Please enter valid company name ";
        return null;
      },
    );
  }
}
