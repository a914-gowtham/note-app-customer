import 'package:customer_flutter/db/database.dart';
import 'package:customer_flutter/main.dart';
import 'package:customer_flutter/models/UserProfile.dart';
import 'package:customer_flutter/pages/add_edit_profile.dart';
import 'package:customer_flutter/pages/listitem.dart';
import 'package:customer_flutter/utils/HexColor.dart';
import 'package:customer_flutter/utils/MPreference.dart';
import 'package:customer_flutter/utils/MyWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<User> listOfUser = [];
  List<User> listOfSelected = [];
  UsersDao userDao;
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
    userDao = Provider.of<Repository>(context).getUserDao();
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: FutureBuilder<UserProfile>(
              future: preference.getUserProfile(),
              builder: (BuildContext context, AsyncSnapshot<UserProfile> snapshot) {
                String title=snapshot.data!=null ? snapshot.data.companyName : "Company name";
                title=listOfSelected.isEmpty ? title : ("${listOfSelected.length} item selected");
                return Text(title);
              }),
          actions: [
            listOfSelected.isEmpty ? IconButton(
              icon: Icon(Icons.supervised_user_circle_outlined),
              onPressed: () {
                Navigator.pushNamed(context, "/profile");
              },
            ) : IconButton(
              icon: Icon(Icons.delete_forever),
              onPressed: () {
                _deleteItems();
              },
            )
          ],
        ),

        floatingActionButton: listOfSelected.isEmpty ? FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/add_edit_customer');
          },
          tooltip: 'Add User',
          child: Icon(Icons.add),
          elevation: 2.0,
        ) : Container(),
        body: _userListView(),
      ),
    );
  }

  Widget _userListView() {
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
                    return ListItem(
                      key: Key(listOfUser[index].id.toString()),
                      item: listOfUser[index],
                        listOfSelected: listOfSelected,
                        isSelected: (bool value) {
                          setState(() {
                            if (value)
                              listOfSelected.add(listOfUser[index]);
                             else
                              listOfSelected.remove(listOfUser[index]);
                          });
                        });
                  })
              : Center(child: Text('No Users'));
        });
  }

  Route _createRoute(int index) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => AddEditProfile(user: listOfUser[index]),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }


  InkWell _buildListItem(int index, Size size) {
    return InkWell(
      onTap: () {
        Navigator.push(context, _createRoute(index));
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

  void _deleteItems() async{
    List<int> items=[];

    for(User u in listOfSelected){
      items.add(u.id);
    }
    await userDao.deleteMultipleTasks(items);
    setState(() {
      listOfSelected.clear();
    });
  }

  Future<bool> _onWillPop() {
    if (listOfSelected.isNotEmpty) {
      setState(() {
        listOfSelected.clear();
      });
    }else{
      SystemChannels.platform
          .invokeMethod('SystemNavigator.pop');
    }
    return false as Future;
  }

}
