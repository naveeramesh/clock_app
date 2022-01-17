
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MenuType extends ChangeNotifier {
  // Menus menus;
  String? title;
  Icon? icon;
  Color? color;
  MenuType(
      // this.menus,
      {this.title,
      this.icon,
      this.color});

  update_fn(MenuType menuType) {
  
    this.title = menuType.title;
    this.icon = menuType.icon;
    
    print(title);
    print(icon);
    notifyListeners();
  }
}

List<MenuType> items = [
  MenuType(
     
      title: "Alarm",
      icon: Icon(Icons.alarm),
      color: Colors.amber),
  MenuType(
    
      title: "Timer",
      icon: Icon(Icons.timelapse),
      color: Colors.blue),
  MenuType(
     
      title: "Watch",
      icon: Icon(Icons.lock_clock),
      color: Colors.red)
];
