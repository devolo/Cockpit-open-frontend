import 'package:cockpit_devolo/models/networkListModel.dart';
import 'package:cockpit_devolo/models/dataRateModel.dart';
import 'package:cockpit_devolo/models/deviceModel.dart';
import 'package:flutter/foundation.dart';

bool compareDevice(Device first, Device other){

  if(first.remoteDevices.length == other.remoteDevices.length){
    for(int i = 0; i < first.remoteDevices.length; i++){
      if(!compareDevice(first.remoteDevices[i],other.remoteDevices[i]))
        return false;
    }
  }
  else
    return false;

  if(

  first.typeEnum == other.typeEnum &&
      first.type == other.type &&
      first.name == other.name &&
      first.mac == other.mac &&
      first.ip == other.ip &&
      first.version == other.version &&
      first.version_date == other.version_date &&
      first.MT == other.MT &&
      first.serialno == other.serialno &&
      //List<Device> remoteDevices = <Device>[];
      first.icon == other.icon &&
      compareSpeedRates(first.speeds,other.speeds) &&
      //Map<String, DataratePair>? speeds; //Map<mac address of remote device, datarates to and from this remote device>
      first.attachedToRouter == other.attachedToRouter &&
      first.isLocalDevice == other.isLocalDevice &&
      first.updateState == other.updateState &&
      first.updateStateInt == other.updateStateInt &&
      first.webinterfaceAvailable == other.webinterfaceAvailable &&
      first.identifyDeviceAvailable == other.identifyDeviceAvailable &&
      first.selected_vdsl == other.selected_vdsl &&
      listEquals(first.supported_vdsl,other.supported_vdsl) &&
      first.mode_vdsl == other.mode_vdsl

  ){
    return true;
  }
  else
    return false;

}

bool compareNetworkList(NetworkList first, NetworkList other){

  if(first.getNetworkList().length == other.getNetworkList().length){
    for(int i = 0; i < first.getNetworkList().length; i++){
      if(first.getNetworkList()[i].length == other.getNetworkList()[i].length){
        for(int j = 0; j < first.getNetworkList()[i].length; j++){
          if(!compareDevice(first.getNetworkList()[i][j], other.getNetworkList()[i][j])){
            return false;
          }
        }
      }
      else{
        return false;
      }
    }
  }
  else{
    return false;
  }

  if(first.getAllDevices().length == other.getAllDevices().length) {
    for (int i = 0; i < first.getAllDevices().length; i++) {
      if(!compareDevice(first.getAllDevices()[i], other.getAllDevices()[i])){
        return false;
      }
    }
  }
  else
    return false;

  if(
  first.selectedNetworkIndex == other.selectedNetworkIndex &&
      listEquals(first.getUpdateList(), other.getUpdateList()) &&
      first.cockpitUpdate == other.cockpitUpdate
  ){
    return true;
  }
  else{
    return false;
  }
}

bool compareSpeedRates(Map<String, DataratePair>? rates1, Map<String, DataratePair>? rates2){

  if(rates1 == null && rates2 == null){
    return true;
  }

  else if(rates1 != null && rates2 == null){
    return false;
  }

  else if(rates1 == null && rates2 != null){
    return false;
  }

  if(rates1!.length == rates2!.length){
    var rates1Keys = rates1.keys;

    bool checkKeys = true;
    rates1Keys.forEach((element) {

      if(rates2.containsKey(element)){
        if(!compareDataratePair(rates1[element]!, rates2[element]!))
          checkKeys = false;
      }

      if(!rates2.containsKey(element))
        checkKeys = false;

    });

    return checkKeys;

  }
  else
    return false;
}

bool compareDataratePair(DataratePair first, DataratePair other){
  if(
  first.rx == other.rx &&
      first.tx == other.tx
  ){
    return true;
  }
  else
    return false;
}
