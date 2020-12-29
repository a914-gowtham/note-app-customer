import 'package:customer_flutter/db/database.dart';
import 'package:customer_flutter/utils/MyWidgets.dart';
import 'package:flutter/material.dart';

import 'add_edit_profile.dart';

class ListItem extends StatefulWidget {
  final Key key;
  final User item;
  final List<User> listOfSelected;
  final ValueChanged<bool> isSelected;

  ListItem({this.key, this.item, this.listOfSelected, this.isSelected})
      : super(key: key);

  @override
  _ListItemState createState() => _ListItemState();
}

Route _createRoute(User user) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        AddEditProfile(user: user),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}

class _ListItemState extends State<ListItem> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    if (widget.listOfSelected.isEmpty)
      isSelected=false;

    return InkWell(
      onLongPress: () {
        setState(() {
          isSelected = !isSelected;
          widget.isSelected(isSelected);
        });
      },
      onTap: () {
        if (isSelected || widget.listOfSelected.isNotEmpty) {
          setState(() {
            isSelected = !isSelected;
            widget.isSelected(isSelected);
          });
        } else
          Navigator.push(context, _createRoute(widget.item));
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[100] : Colors.white,
        ),
        child: Row(
          children: [
            MyWidgets.verticalLine(5, height: 65, color: Colors.blue),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 1,
              child: Text(widget.item.name ?? 'No Name',
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
                      widget.item.area ?? "No area",
                      maxLines: 1,
                      style: TextStyle(fontFamily: "FontRg", fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    )),
                ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: (size.width / 3)),
                    child: Text(
                      widget.item.stbNo ?? "No StbNo",
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
      ),
    );
  }
}
