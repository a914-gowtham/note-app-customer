import 'package:customer_flutter/db/database.dart';
import 'package:customer_flutter/pages/profile.dart';
import 'package:customer_flutter/utils/MPreference.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/add_edit_profile.dart';
import 'pages/home.dart';
import 'pages/splash.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) =>MPreference()),
      ChangeNotifierProvider(create: (_) =>Repository()),
    ],
    child: (MaterialApp(
      title: 'List App',
      // initialRoute: '/',
      routes: {
        '/': (context) => Splash(),
        '/home': (context) => Home(),
        '/profile': (context) => Profile(),
        '/add_edit_customer': (context) => AddEditProfile(),
      },
    )),
  ));

}

class Repository extends ChangeNotifier{

  var userDao=AppDatabase().usersDao;
  getUserDao()=> userDao;
}

