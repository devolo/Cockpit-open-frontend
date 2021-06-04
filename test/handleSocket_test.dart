import 'package:cockpit_devolo/models/dataRateModel.dart';
import 'package:cockpit_devolo/models/networkListModel.dart';
import 'package:cockpit_devolo/models/deviceModel.dart';
import 'package:cockpit_devolo/models/dataRateModel.dart';
import 'package:test/test.dart';
import 'package:cockpit_devolo/services/handleSocket.dart';
import 'package:cockpit_devolo/mock-data/mock.dart';

void main() {
  //parseXML

  //null input or ""
  //testing different xml messages (existing one and no existing)

  // what is the general outpur?
  // null -> return

  group('parseXML',() {
    test('parseXML - null input', () {

      //compare two objects directly -> does not work | workaround would be to implement a function in the class that does compare two objects.
      // Than you would only need in the expect Method to check if the compare method returns true
      var dataRate1 = new DataratePair(1, 2);
      var dataRate2 = new DataratePair(1, 2);

      var map1 = new Map<String, DataratePair>();
      var map2 = new Map<String, DataratePair>();

      map1["macAdress"] = dataRate1;
      map2["macAdress"] = dataRate2;

      var network = new NetworkList();
      var device1 = new Device("String type", "String name", "String mac", "String ip", "String MT", "String serialno", "String version", "String versionDate", false, false, true, true, "selectedVDSL", ["ja","nein"], "modeVDSL");
      device1.speeds = map1;
      network.addDevice(device1,0);
      //var dataHandler = DataHand();


      var networkM = new NetworkList();
      var device2 = new Device("String type", "String name", "String mac", "String ip", "String MT", "String serialno", "String version", "String versionDate", false, false, true, true, "selectedVDSL", ["ja","nein"], "modeVDSL");
      device2.speeds = map2;
      networkM.addDevice(device2,0);

      //dataHandler.parseXML("");
      expect(network.compareNetworkList(networkM), true);

      //check manually if every attribute of the objects are equal with multiple expects
      // Than you would only need in the expect Method to check if the compare method returns true

    });

    test('parseXML - "" input', () {
      //var dataHandv = DataHand();
      //dataHandv.parseXML(null);
    });

    //check for config
    test('parseXML - config input', () {

    });

    // delete old network list and creates new one
    test('parseXML - networkupdate input', () {

    });

    test('parseXML - config and networkupdate input', () {

    });

    test('parseXML - unknwown input', () {

      //xmlDebugResponse List check
      //xmlResponseMap
    });
  });
}