import 'dart:async';

import 'package:aplikasi_inventory/viewmodels/base_model.dart';
import 'package:intl/intl.dart';

class DashboardViewModel extends BaseModel {

  String datetime = '';
  String time = '';

  void initState() async {
    // print(await _storageService.getString(localDataGuid));
    setBusy(true);
    date();
    Timer.periodic(Duration(seconds: 1), (Timer t) => times());
    setBusy(false);
  }

  void date(){
    var now = new DateTime.now();
    var formatter = new DateFormat('dd MMMM yyyy');
    String formattedDate = formatter.format(now);
    datetime = formattedDate;
    print(DateFormat().format(now));
    print("format data"+formattedDate);
    print("date "+ now.day.toString());
  }

  void times(){
    final String formattedDateTime =
    DateFormat('kk:mm:ss').format(DateTime.now()).toString();
    setBusy(true);
    time = formattedDateTime;
    setBusy(false);
  }

  String formatDate(int date) {
    var tempData = new DateTime.fromMillisecondsSinceEpoch(date *1000, isUtc: false);
    DateFormat dateFormat = DateFormat("dd-MM-yyyy HH:mm");
    var returnData = dateFormat.format(tempData);
    return returnData;
  }

}