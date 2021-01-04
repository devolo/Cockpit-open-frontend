import 'package:cockpit_devolo/deviceModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'handleSocket.dart';
import 'DrawOverview.dart';
import 'helpers.dart';
import 'emptyScreen.dart';
import 'updateScreen.dart';
import 'settingsScreen.dart';
import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  //debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;

  runApp(
  MultiProvider(providers: [
  ChangeNotifierProvider<dataHand>(create: (context) => dataHand()),
  ],
  child: MyApp())
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Devolo Cockpit',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: devoloBlue,
        canvasColor: Colors.white,
      ),
      home: MyHomePage(title: 'devolo Cockpit'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextStyle _menuItemStyle;
  int numDevices = 0;
  Offset _lastTapDownPosition;
  DrawNetworkOverview _Painter;


  @override
  void initState() {
    //dataHand();
    loadAllDeviceIcons();
    _menuItemStyle = TextStyle(color: devoloBlue, fontFamily: 'Roboto', decorationColor: devoloBlue);
  }

  void _reloadTest() {
    setState(() {
      //doc = parseXML()
    });
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<dataHand>(context);
    _Painter = DrawNetworkOverview(context, model.getdeviceList.devices);

    print("building main");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: devoloBlue,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            InkWell(
                child: SvgPicture.asset('assets/logo.svg', height: 24, color: Colors.white)
            ),
            Spacer(),
            SizedBox(width: 56)
          ],
        ),
      ),

      drawer: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: <Widget>[
            DrawerHeader(
              child: Text('Home Network Desktop', style: TextStyle(fontSize: 23),),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
            ListTile(
              leading: Icon(Icons.workspaces_filled,color: devoloBlue), //miscellaneous_services
                title: Text('Network Overview', style: _menuItemStyle),
                onTap: () {
                  Navigator.pop(context); //close drawer
                }),
            ListTile(
                leading: Icon(Icons.download_rounded, color: devoloBlue),
                title: Text('Updates', style: _menuItemStyle),
                onTap: () {
                  //model.sendXML('UpdateCheck');
                  Navigator.pop(context); //close drawer
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => UpdateScreen(title: "Updates", model: model)),
                  );
                }),
            ListTile(
                leading: Icon(Icons.miscellaneous_services, color: devoloBlue),
                title: Text('Network Settings', style: _menuItemStyle),
                onTap: () {
                  Navigator.pop(context); //close drawer
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) =>
                        new EmptyScreen(title: "Network Settings")),
                  );
                }),
            ListTile(
                leading: Icon(Icons.wifi, color: devoloBlue),
                title: Text('WiFi Settings', style: _menuItemStyle),
                onTap: () {
                  Navigator.pop(context); //close drawer
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) =>
                        new EmptyScreen(title: "WiFi Settings")),
                  );
                }),
            ListTile(
                leading: Icon(Icons.settings_applications, color: devoloBlue),
                title: Text('App Settings', style: _menuItemStyle),
                onTap: () {
                  Navigator.pop(context); //close drawer
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new SettingsScreen(title: "Settings", painter: _Painter)),
                  );
                }),
          ])),
      body: Container(
        child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTapUp: _handleTap,
              onTapDown:_handleTapDown,
              onLongPress: () =>_handleLongPressStart(context),
              onLongPressUp: _handleLongPressEnd,
              child: Center(
                child: CustomPaint(
                  painter: _Painter,
                  child: Container(),
                ),
              ),
            ),
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: Text(
            //     ' Devices: ' + deviceList.devices.length.toString(),
            //     style: Theme
            //         .of(context)
            //         .textTheme
            //         .headline5,
            //   ),),
            // Expanded(
            //   child: ListView.builder(
            //       padding: const EdgeInsets.all(0),
            //       itemCount: deviceList.devices.length,
            //       itemBuilder: (BuildContext context, int index) {
            //         return ListTile(
            //           title: Text(deviceList.devices[index].type),
            //           subtitle: Text(deviceList.devices[index].name +
            //               ", " +
            //               deviceList.devices[index].ip +
            //               ", " +
            //               deviceList.devices[index].mac +
            //               ", " +
            //               deviceList.devices[index].serialno +
            //               ", " +
            //               deviceList.devices[index].MT),
            //         );
            //       }),
            // ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>setState(() {
          model.sendXML('RefreshNetwork');
        }),
        tooltip: 'Reload',
        backgroundColor: devoloBlue,
        hoverColor: Colors.blue,
        child: Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


  void _handleTapDown(TapDownDetails details) {
    print('entering tabDown');
    _lastTapDownPosition = details.localPosition;
  }

  void _handleTap(TapUpDetails details)  {
    print('entering dialog....');
    int index = 0;
    String hitDeviceName;
    String hitDeviceType;
    String hitDeviceSN;
    String hitDeviceMT;
    String hitDeviceVersion;
    String hitDeviceIp;
    String hitDeviceMac;

    for (Offset deviceIconOffset in deviceIconOffsetList) {
      if (index >
          _Painter.numberFoundDevices) //do not check invisible circles
        break;

      Offset absoluteOffset = Offset(deviceIconOffset.dx + (_Painter.screenWidth / 2),
          deviceIconOffset.dy + (_Painter.screenHeight / 2));

      if (_Painter.isPointInsideCircle(details.localPosition, absoluteOffset, _Painter.hn_circle_radius)) {
        print("Hit icon #" + index.toString());

        final model = Provider.of<dataHand>(context);

        hitDeviceName = model.getdeviceList.devices[index].name;
        hitDeviceType = model.getdeviceList.devices[index].type;
        hitDeviceSN = model.getdeviceList.devices[index].serialno;
        hitDeviceMT = model.getdeviceList.devices[index].MT;
        hitDeviceVersion = model.getdeviceList.devices[index].version;
        hitDeviceIp = model.getdeviceList.devices[index].ip;
        hitDeviceMac = model.getdeviceList.devices[index].mac;

        String _newName = hitDeviceName;

        showDialog<void>(
          context: context,
          barrierDismissible: true, // user doesn't need to tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Device Info '),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      initialValue: _newName,
                      decoration: InputDecoration(
                        labelText: 'Devicename',
                        //helperText: 'Devicename',
                      ),
                      onChanged: (value) => ( _newName = value),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },

                    ),
                    SizedBox(height: 15,),
                    Table(
                      defaultColumnWidth: FixedColumnWidth(200.0),
                    children: [
                      TableRow(children: [
                        Text('Type: '),
                        Text(hitDeviceType),
                      ]),
                      TableRow(children: [
                        Text('Serialnumber: '),
                        Text(hitDeviceSN),
                      ]),
                      TableRow(children: [
                        Text('MT-number: '),
                        Text(hitDeviceMT),
                      ]),
                      TableRow(children: [
                        Text('Version: '),
                        Text(hitDeviceVersion),
                      ]),
                      TableRow(children: [
                        Text('IP: ' ),
                        Text(hitDeviceIp),
                      ]),
                      TableRow(children: [
                        Text('MAC: ' ),
                        Text(hitDeviceMac),
                      ]),
                    ],),
                    //Text('Rates: ' +hitDeviceRx),
                    Padding(padding: EdgeInsets.fromLTRB(0, 40, 0, 0)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        IconButton(icon: Icon(Icons.public), tooltip: 'Launch Webinterface', onPressed: () => launchURL(hitDeviceIp),),
                        IconButton(icon: Icon(Icons.lightbulb), tooltip: 'Identify Device', onPressed: () => model.sendXML('IdentifyDevice', mac: hitDeviceMac)),
                        IconButton(icon: Icon(Icons.find_in_page), tooltip: 'Show Manual', onPressed: () {
                          model.sendXML('GetManual', newValue: hitDeviceMT, valueType: 'product', newValue2: 'de', valueType2: 'language');
                          setState(() {
                            model.recieveXML(model.xmlResponse).then((value) => openFile(value.elementAt(0)));
                          });
                        }),
                        IconButton(icon: Icon(Icons.upload_file), tooltip: 'Factory Reset', onPressed: () =>_handleCriticalActions(context, model, 'ResetAdapterToFactoryDefaults', mac: hitDeviceMac),),
                        IconButton(icon: Icon(Icons.delete), tooltip: 'Delete Device', onPressed: () => print('Delete Device'),), //ToDo Delete Device see wiki
                      ],
                    ),

                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Icon(Icons.check_circle_outline, size: 35,color: devoloBlue,),//Text('Bestätigen'),
                  onPressed: () {
                    model.sendXML('SetAdapterName', mac: hitDeviceMac, newValue: _newName, valueType: 'name');
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
      index++;
    }
  }

  //ToDo UI doesn't change
  void _handleLongPressStart(context) {
    print("long press down");
    RenderBox renderBox = context.findRenderObject();

    int index = 0;
    String hitDeviceName;
    for (Offset deviceIconOffset in deviceIconOffsetList) {
      if (index >
          _Painter.numberFoundDevices) //do not check invisible circles
        break;

      Offset absoluteOffset = Offset(deviceIconOffset.dx + (_Painter.screenWidth / 2),
          deviceIconOffset.dy + (_Painter.screenHeight / 2));

      if (_Painter.isPointInsideCircle(_lastTapDownPosition, absoluteOffset, _Painter.hn_circle_radius)) {
        print("Long press on icon #" + index.toString());

        final model = Provider.of<dataHand>(context);
        hitDeviceName = model.getdeviceList.devices[index].name;

        setState(() {
          if (_Painter.showSpeedsPermanently && index == _Painter.pivotDeviceIndex) {
            _Painter.showingSpeeds = !_Painter.showingSpeeds;
          } else {
            _Painter.showingSpeeds = true;
          }
          _Painter.pivotDeviceIndex = index;

          //do not update pivot device when the "router device" is long pressed
          print('Pivot on longPress:' +_Painter.pivotDeviceIndex.toString());
          print('sowingSpeed on longPress:' +_Painter.showingSpeeds.toString());
        });
        return;
      }
      index++;
    }
  }

  void _handleLongPressEnd() {
    print("long press up");

    setState(() {
      if (!_Painter.showSpeedsPermanently) {
        _Painter.showingSpeeds = true;
        _Painter.pivotDeviceIndex = 0;
      } else {
        if (!_Painter.showingSpeeds) _Painter.pivotDeviceIndex = 0;
      }
    });
  }

  void _handleCriticalActions(context, model, messageType, {mac}) {
    showDialog<void>(
    context: context,
    barrierDismissible: true, // user doesn't need to tap button!
    builder: (BuildContext context) {
    return AlertDialog(
      title: Text(messageType),
      content: Text('Bitte Aktion bestätigen.'),
      actions: <Widget>[
        FlatButton(
            child: Text('Abbrechen'),
            onPressed: (){
              // Cancel critical action
              Navigator.of(context).pop();
            }
        ),
        FlatButton(
          child: Text('Bestätigen'),
          onPressed: (){
            // Critical things happening here
            model.sendXML(messageType, mac: mac);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  });
  }

// void _handleTap(TapUpDetails details) {
//   print('entering _handleTab');
//   RenderBox renderBox = context.findRenderObject();
//
//   int index = 0;
//   String hitDeviceName;
//   for (Offset deviceIconOffset in deviceIconOffsetList) {
//     if (index >
//         _Painter.numberFoundDevices) //do not check invisible circles
//       break;
//
//     Offset absoluteOffset = Offset(deviceIconOffset.dx + (_Painter.screenWidth / 2),
//         deviceIconOffset.dy + (_Painter.screenHeight / 2));
//
//     if (_Painter.isPointInsideCircle(details.localPosition, absoluteOffset, _Painter.hn_circle_radius)) {
//       print("Hit icon #" + index.toString());
//
//       hitDeviceName = deviceList.devices[index].name;
//
//       if (deviceList.devices[index].ip != null &&
//           deviceList.devices[index].ip.length > 0 &&
//           deviceList.devices[index].ip.compareTo("http://") != 0 &&
//           deviceList.devices[index].ip.compareTo("https://") != 0) // ToDo understand... 3rd & 4th condition necessary? Ask what backend will send..just seen ips
//       {
//         String webUrl = "http://"+deviceList.devices[index].ip;
//         print("Opening web UI at " + webUrl);
//
//         if (Platform.isFuchsia || Platform.isLinux)
//           print("Would now have opened the Web-Interface at " +
//               webUrl +
//               ", but we are experimental on the current platform. :-/");
//         else
//           launchURL(webUrl);
//
//       } else {
//         Navigator.push(
//           context,
//           new MaterialPageRoute(
//               builder: (context) => new EmptyScreen(title: hitDeviceName)),
//         );
//       }
//     }
//     index++;
//   }
// }
}