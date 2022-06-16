import 'package:aplikasi_inventory/constants/color.dart';
import 'package:aplikasi_inventory/ui/shared/ui_helper.dart';
import 'package:aplikasi_inventory/viewmodels/dashboard_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class DashboardView extends StatefulWidget {

  const DashboardView({Key? key}) : super(key: key);

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardViewModel>.reactive(
      viewModelBuilder: () => DashboardViewModel(),
        onModelReady: (model) => model.initState(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: colorWhite2,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                verticalSpaceMedium,
                Text('Inventory App', style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 30
                ),),
                verticalSpaceSmall,
                Image.asset(
                  './assets/images/orang.png',
                  height: 270,
                  width: 1000,
                ),
                Container(
                  margin:
                  const EdgeInsets.only(right: 30, left: 30),
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                      color: colorLightGreen,
                      borderRadius:
                      BorderRadius.all(Radius.circular(20))
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text('Date', style: TextStyle(fontSize: 16.0)),
                            verticalSpaceTiny,
                            Text(model.datetime,
                                style: const TextStyle( fontSize: 25.0, fontWeight: FontWeight.w700)),
                            verticalSpaceMedium,
                            const Text('Time', style: TextStyle(fontSize: 16.0,)),
                            verticalSpaceTiny,
                            Text(model.time,
                                style: const TextStyle(fontSize: 25.0, color: Colors.black, fontWeight: FontWeight.w700))
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Image.asset('./assets/icons/date.png', height: 45, width: 45,),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Image.asset('./assets/icons/time.png', height: 45, width: 45,),
                            )
                          ],
                        )
                      ]
                  ),
                ),
              ],
            ),
          ),
        )
    )));
  }
}
