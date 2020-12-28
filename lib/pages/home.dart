import 'package:customer_flutter/db/database.dart';
import 'package:customer_flutter/main.dart';
import 'package:customer_flutter/models/UserProfile.dart';
import 'package:customer_flutter/pages/add_edit_profile.dart';
import 'package:customer_flutter/utils/HexColor.dart';
import 'package:customer_flutter/utils/MPreference.dart';
import 'package:customer_flutter/utils/MyWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<User> listOfUser = [];
  MPreference preference;
  String title = "Velavan cable vision";
  UserProfile _userProfile;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<int> _counter;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _incrementCounter() async {
    final SharedPreferences prefs = await _prefs;
    final int counter = (prefs.getInt('counter') ?? 0) + 1;

    setState(() {
      _counter = prefs.setInt("counter", counter).then((bool success) {
        return counter;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    preference = Provider.of<MPreference>(context);
    // _userProfile=preference.getUserProfile();
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<UserProfile>(
            future: preference.getUserProfile(),
            builder: (BuildContext context, AsyncSnapshot<UserProfile> snapshot) {
              String title=snapshot.data!=null ? snapshot.data.companyName : "Company name";
              return Text(title);
            }),
        actions: [
          IconButton(
            icon: Icon(Icons.supervised_user_circle_outlined),
            onPressed: () {
              Navigator.pushNamed(context, "/profile");
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.pushNamed(context, '/add_edit_customer');
        },
        tooltip: 'Add User',
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
      body: _userListView(),
    );
  }

  Widget _userListView() {
    var userDao = Provider.of<Repository>(context).getUserDao();
    var size = MediaQuery.of(context).size;
    return StreamBuilder<Object>(
        stream: userDao.watchAllTasks(),
        builder: (context, snapshot) {
          listOfUser = snapshot.data ?? listOfUser;
          return listOfUser.isNotEmpty
              ? ListView.separated(
                  itemCount: listOfUser.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(
                        height: 6,
                        thickness: 6,
                        color: HexColor('#EEEEEE'),
                      ),
                  itemBuilder: (BuildContext context, int index) {
                    return _buildListItem(index, size);
                  })
              : Center(child: Text('No Users'));
        });
  }

  InkWell _buildListItem(int index, Size size) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddEditProfile(user: listOfUser[index])));
        // Navigator.pushNamed(context, '/add_edit_customer',arguments: listOfUser[index]);
      },
      child: Row(
        children: [
          MyWidgets.verticalLine(5, height: 65, color: Colors.blue),
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 1,
            child: Text(listOfUser[index].name ?? 'No Name',
                style: TextStyle(fontSize: 20, fontFamily: "FontBd"),
                overflow: TextOverflow.ellipsis),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: (size.width / 3)),
                  child: Text(
                    listOfUser[index].area ?? "No area",
                    maxLines: 1,
                    style: TextStyle(fontFamily: "FontRg", fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                  )),
              ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: (size.width / 3)),
                  child: Text(
                    listOfUser[index].stbNo ?? "No StbNo",
                    maxLines: 1,
                    style: TextStyle(fontFamily: "FontRg", fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                  )),
            ],
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}
