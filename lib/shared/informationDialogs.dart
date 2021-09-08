import 'dart:async';

import 'package:cockpit_devolo/generated/l10n.dart';
import 'package:cockpit_devolo/models/deviceModel.dart';
import 'package:cockpit_devolo/models/fontSizeModel.dart';
import 'package:cockpit_devolo/services/handleSocket.dart';
import 'package:cockpit_devolo/views/appBuilder.dart';
import 'package:flutter/material.dart';

import 'alertDialogs.dart';
import 'app_colors.dart';
import 'app_fontSize.dart';
import 'buttons.dart';
import 'devolo_icons_icons.dart';
import 'helpers.dart';

// add closeButton manually
void deviceInformationDialog(context, Device hitDevice, FocusNode myFocusNode, DataHand socket, FontSize fontSize) {

  String newName = hitDevice.name;
  bool changeNameLoading = false;
  bool lightbulbOn = false;
  bool dialogClosed = false;
  bool identifyDeviceActionRunning = false;

  showDialog<void>(
    context: context,
    barrierDismissible: true, // user doesn't need to tap button!
    builder: (BuildContext context) {
      return  StatefulBuilder(
        builder: (context, setState)
      {
        return AlertDialog(
          contentTextStyle: TextStyle(color: fontColorOnBackground,
              fontSize: dialogContentTextFontSize * fontSize.factor),
          title: Column(
            children: [
              getCloseButton(context),
              SelectableText(
                S
                    .of(context)
                    .deviceInfo,
                style: TextStyle(color: fontColorOnBackground),
                textScaleFactor: fontSize.factor,
              ),
            ],
          ),
          titlePadding: EdgeInsets.all(dialogTitlePadding),
          titleTextStyle: TextStyle(
            color: fontColorOnBackground,
            fontSize: dialogTitleTextFontSize,
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: <Widget>[
                SizedBox(
                  height: 15,
                  width: 800.0 * fontSize.factor,
                ),
                Table(
                  children: [
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: SelectableText(
                              "${S
                                  .of(context)
                                  .name}:   ",
                            )),
                      ),
                      Container(
                        width: 60, // doesn´t affect the width in the text field
                        child: TextFormField(
                          initialValue: newName,
                          focusNode: myFocusNode,
                          style: TextStyle(color: fontColorOnBackground,
                              fontSize: dialogContentTextFontSize *
                                  fontSize.factor),
                          cursorColor: fontColorOnBackground,
                          decoration: InputDecoration(
                            isDense: true,
                            hoverColor: fontColorOnBackground.withOpacity(0.2),
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 10.0),
                            filled: true,
                            fillColor: fontColorOnBackground.withOpacity(0.2),
                            //myFocusNode.hasFocus ? secondColor.withOpacity(0.2):Colors.transparent,//secondColor.withOpacity(0.2),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                color: fontColorOnBackground,
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                color: fontColorOnBackground, //Colors.transparent,
                                //width: 2.0,
                              ),
                            ),
                            suffixIcon: changeNameLoading
                                ? SizedBox(
                                width: 0.5,
                                height: 0.5,
                                child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: CircularProgressIndicator(
                                      valueColor: new AlwaysStoppedAnimation<
                                          Color>(
                                          fontColorOnBackground),
                                      strokeWidth: 3.0,
                                    )))
                                : IconButton(
                              icon: Icon(
                                DevoloIcons.ic_edit_24px,
                                color: fontColorOnBackground,
                              ),
                              onPressed: () async {
                                if (newName != hitDevice.name) {
                                  bool confResponse = await confirmDialog(
                                      context, S
                                      .of(context)
                                      .deviceNameDialogTitle, S
                                      .of(context)
                                      .deviceNameDialogBody, fontSize);
                                  if (confResponse) {
                                    changeNameLoading = true;
                                    AppBuilder.of(context)!.rebuild();
                                    socket.sendXML(
                                        'SetAdapterName', mac: hitDevice.mac,
                                        newValue: newName,
                                        valueType: 'name');
                                    var response = await socket.receiveXML(
                                        "SetAdapterNameStatus");
                                    if (response!['result'] == "ok") {
                                      hitDevice.name = newName;
                                      await Future.delayed(
                                          const Duration(seconds: 1), () {});
                                      socket.sendXML('RefreshNetwork');
                                    } else if (response['result'] ==
                                        "device_not_found") {
                                      errorDialog(context, S
                                          .of(context)
                                          .deviceNameErrorTitle, S
                                          .of(context)
                                          .deviceNotFoundDeviceName + "\n\n" + S
                                          .of(context)
                                          .deviceNotFoundHint, fontSize);
                                    } else if (response['result'] != "ok") {
                                      errorDialog(context, S
                                          .of(context)
                                          .deviceNameErrorTitle, S
                                          .of(context)
                                          .deviceNameErrorBody, fontSize);
                                    }

                                    changeNameLoading = false;
                                  }
                                }
                              },
                            ),
                          ),
                          onChanged: (value) => (newName = value),
                          onEditingComplete: () async {
                            if (newName != hitDevice.name) {
                              bool confResponse = await confirmDialog(context, S
                                  .of(context)
                                  .deviceNameDialogTitle, S
                                  .of(context)
                                  .deviceNameDialogBody, fontSize);
                              if (confResponse) {
                                changeNameLoading = true;
                                socket.sendXML(
                                    'SetAdapterName', mac: hitDevice.mac,
                                    newValue: newName,
                                    valueType: 'name');
                                var response = await socket.receiveXML(
                                    "SetAdapterNameStatus");
                                if (response!['result'] == "ok") {
                                  hitDevice.name = newName;
                                  await Future.delayed(
                                      const Duration(seconds: 1), () {});
                                  socket.sendXML('RefreshNetwork');

                                  //setState(() {
                                  //   socket.sendXML('RefreshNetwork');
                                  //});
                                } else if (response['result'] == "timeout") {
                                  errorDialog(context, S
                                      .of(context)
                                      .deviceNameErrorTitle, S
                                      .of(context)
                                      .deviceNameErrorBody, fontSize);
                                } else
                                if (response['result'] == "device_not_found") {
                                  errorDialog(context, S
                                      .of(context)
                                      .deviceNameErrorTitle, S
                                      .of(context)
                                      .deviceNotFoundDeviceName + "\n\n" + S
                                      .of(context)
                                      .deviceNotFoundHint, fontSize);
                                }

                                changeNameLoading = false;
                              }
                            }
                          },
                          onTap: () {
                            myFocusNode.hasFocus;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return S
                                  .of(context)
                                  .pleaseEnterDeviceName;
                            }
                            return null;
                          },
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: SelectableText(
                              "${S
                                  .of(context)
                                  .type}:   ",
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: SelectableText(hitDevice.type),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: SelectableText(
                              "${S
                                  .of(context)
                                  .serialNumber}:   ",
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: SelectableText(hitDevice.serialno),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: SelectableText(
                            "${S
                                .of(context)
                                .mtNumber}:   ",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: SelectableText(hitDevice.MT.substring(2)),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: SelectableText(
                            "${S
                                .of(context)
                                .version}:   ",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: SelectableText(
                            hitDevice.version + "(" + hitDevice.versionDate +
                                ")"),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: SelectableText(
                            "${S
                                .of(context)
                                .ipAddress}:   ",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: SelectableText(hitDevice.ip),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: SelectableText(
                            "${S
                                .of(context)
                                .macAddress}:   ",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: SelectableText(hitDevice.mac),
                      ),
                    ]),
                  ],
                ),
//Text('Rates: ' +hitDeviceRx),
                Padding(padding: EdgeInsets.fromLTRB(0, 40, 0, 0)),
                Wrap(
                  spacing: 20,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            DevoloIcons.devolo_UI_internet,
                          ),
//tooltip: S.of(context).launchWebinterface,
                          disabledColor: fontColorOnBackground.withOpacity(
                              0.33),
                          color: fontColorOnBackground,
                          hoverColor: fontColorOnBackground.withAlpha(50),
                          iconSize: 24.0 * fontSize.factor,
                          onPressed: !hitDevice.webinterfaceAvailable
                              ? null
                              : () =>
                              launchURL(hitDevice.webinterfaceURL),
                          mouseCursor: !hitDevice.webinterfaceAvailable
                              ? SystemMouseCursors
                              .basic
                              : SystemMouseCursors.click,
                        ),
                        Text(
                          S
                              .of(context)
                              .launchWebInterface,
                          style: TextStyle(fontSize: 14,
                              color: !hitDevice.webinterfaceAvailable
                                  ? fontColorOnBackground.withOpacity(0.33)
                                  : fontColorOnBackground),
                          textScaleFactor: fontSize.factor,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Tooltip(
                          preferBelow: false,
                          message: S
                              .of(context)
                              .identifyDeviceTooltip,
                          textStyle: TextStyle(color: backgroundColor),
                          decoration: BoxDecoration(
                            color: fontColorOnBackground.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          margin: EdgeInsets.only(),
                          padding: EdgeInsets.symmetric(
                              vertical: 5, horizontal: 20),
                          child:
                          IconButton(
                            icon: Icon(
                              lightbulbOn
                                  ? DevoloIcons.devolo_UI_led
                                  : DevoloIcons
                                  .ic_lightbulb_outline_24px, //TODO create "lightbulbOn" svg icon
                            ),
                            //tooltip: S.of(context).identifyDevice,
                            disabledColor: fontColorOnBackground.withOpacity(
                                0.33),
                            color: fontColorOnBackground,
                            hoverColor: fontColorOnBackground.withAlpha(50),
                            iconSize: 24.0 * fontSize.factor,
                            onPressed: !hitDevice.identifyDeviceAvailable ||
                                identifyDeviceActionRunning
                                ? null
                                : () async {
                              identifyDeviceActionRunning = true;

                              socket.sendXML(
                                  'IdentifyDevice', mac: hitDevice.mac);

                              bool toggleLightbulb = true;
                              Timer(
                                  Duration(seconds: 120),
                                      () {
                                    identifyDeviceActionRunning = false;
                                    toggleLightbulb = false;
                                  }
                              );

                              Timer.periodic(
                                  Duration(seconds: 1),
                                      (Timer t) {
                                    if(dialogClosed) {
                                      t.cancel();
                                    }
                                    else if (!toggleLightbulb) {
                                      setState(() {
                                        lightbulbOn = false;
                                        t.cancel();
                                      });
                                    }
                                    else {
                                      setState(() {
                                        lightbulbOn = !lightbulbOn;
                                      });
                                    }
                                  }
                              );

                              var response = await socket.receiveXML(
                                  "IdentifyDeviceStatus");
                              if (response!['result'] == "device_not_found") {
                                identifyDeviceActionRunning = false;
                                toggleLightbulb = false;
                                errorDialog(context, S
                                    .of(context)
                                    .identifyDeviceErrorTitle, S
                                    .of(context)
                                    .deviceNotFoundIdentifyDevice + "\n\n" + S
                                    .of(context)
                                    .deviceNotFoundHint, fontSize);
                              }
                              else if (response['result'] != "ok") {
                                identifyDeviceActionRunning = false;
                                toggleLightbulb = false;
                                errorDialog(context, S
                                    .of(context)
                                    .identifyDeviceErrorTitle, S
                                    .of(context)
                                    .identifyDeviceErrorBody, fontSize);
                              }
                            },

                            mouseCursor: !hitDevice.identifyDeviceAvailable ||
                                identifyDeviceActionRunning ? SystemMouseCursors
                                .basic : SystemMouseCursors.click,
                          ),
                        ),
                        Text(
                          S
                              .of(context)
                              .identifyDevice,
                          style: TextStyle(fontSize: 14,
                              color: !hitDevice.identifyDeviceAvailable ||
                                  identifyDeviceActionRunning
                                  ? fontColorOnBackground.withOpacity(0.33)
                                  : fontColorOnBackground),
                          textScaleFactor: fontSize.factor,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                            icon: Icon(
                              DevoloIcons.ic_find_in_page_24px,
                              color: fontColorOnBackground,
                            ),
//tooltip: S.of(context).showManual,
                            hoverColor: fontColorOnBackground.withAlpha(50),
                            iconSize: 24.0 * fontSize.factor,
                            onPressed: () async {
                              socket.sendXML(
                                  'GetManual', newValue: hitDevice.MT,
                                  valueType: 'product',
                                  newValue2: 'de',
                                  valueType2: 'language');
                              var response = await socket.receiveXML(
                                  "GetManualResponse");
                              if (response!['filename'] != "") {
                                openFile(response['filename']);
                              } else {
                                errorDialog(context, S
                                    .of(context)
                                    .manualErrorTitle, S
                                    .of(context)
                                    .manualErrorBody, fontSize);
                              }
                            }),
                        Text(
                          S
                              .of(context)
                              .showManual,
                          style: TextStyle(
                              fontSize: 14, color: fontColorOnBackground),
                          textScaleFactor: fontSize.factor,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            DevoloIcons.ic_router_24px,
                          ),
//tooltip: S.of(context).showManual,
                          color: fontColorOnBackground,
                          hoverColor: fontColorOnBackground.withAlpha(50),
                          disabledColor: fontColorOnBackground.withOpacity(
                              0.33),
                          iconSize: 24.0 * fontSize.factor,
                          onPressed: (hitDevice.supportedVDSL.isNotEmpty)
                              ? () {
                            showVDSLDialog(
                                context,
                                socket,
                                hitDevice.modeVDSL,
                                hitDevice.supportedVDSL,
                                hitDevice.selectedVDSL,
                                hitDevice.mac,
                                fontSize);
                          }
                              : null,
                          mouseCursor: !hitDevice.supportedVDSL.isNotEmpty
                              ? SystemMouseCursors
                              .basic
                              : SystemMouseCursors.click,
                        ),
                        Text(
                          S
                              .of(context)
                              .setVdslCompatibility,
                          style: TextStyle(fontSize: 14, color: !hitDevice
                              .supportedVDSL.isNotEmpty ? fontColorOnBackground
                              .withOpacity(0.33) : fontColorOnBackground),
                          textScaleFactor: fontSize.factor,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            DevoloIcons.ic_file_upload_24px,
                            color: fontColorOnBackground,
                            semanticLabel: "update",
                          ),
//tooltip: S.of(context).factoryReset,
                          hoverColor: fontColorOnBackground.withAlpha(50),
                          iconSize: 24.0 * fontSize.factor,
                          onPressed: () async {
                            bool confResponse = false;
                            hitDevice.attachedToRouter
                                ? confResponse = await confirmDialog(context, S
                                .of(context)
                                .resetDeviceConfirmTitle, S
                                .of(context)
                                .resetDeviceConfirmBody + "\n" + S
                                .of(context)
                                .confirmActionConnectedToRouterWarning,
                                fontSize)
                                : confResponse = await confirmDialog(context, S
                                .of(context)
                                .resetDeviceConfirmTitle, S
                                .of(context)
                                .resetDeviceConfirmBody, fontSize);

                            if (confResponse) {
                              socket.sendXML("ResetAdapterToFactoryDefaults",
                                  mac: hitDevice.mac);

                              var response = await socket.receiveXML(
                                  "ResetAdapterToFactoryDefaultsStatus");
                              if (response!['result'] == "device_not_found") {
                                errorDialog(context, S
                                    .of(context)
                                    .resetDeviceErrorTitle, S
                                    .of(context)
                                    .deviceNotFoundResetDevice + "\n\n" + S
                                    .of(context)
                                    .deviceNotFoundHint, fontSize);
                              } else if (response['result'] != "ok") {
                                errorDialog(context, S
                                    .of(context)
                                    .resetDeviceErrorTitle, S
                                    .of(context)
                                    .resetDeviceErrorBody, fontSize);
                              }
                            }
                          },
                        ),
                        Text(
                          S
                              .of(context)
                              .factoryReset,
                          style: TextStyle(
                              fontSize: 14, color: fontColorOnBackground),
                          textScaleFactor: fontSize.factor,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),

                    Column(
                      children: [
                        IconButton(
                            icon: Icon(
                              DevoloIcons.devolo_UI_delete,
                              color: fontColorOnBackground,
                            ),
//tooltip: S.of(context).deleteDevice,
                            hoverColor: fontColorOnBackground.withAlpha(50),
                            iconSize: 24.0 * fontSize.factor,
                            onPressed: () async {
                              bool confResponse = false;
                              hitDevice.attachedToRouter
                                  ?
                              confResponse = await confirmDialog(context, S
                                  .of(context)
                                  .removeDeviceConfirmTitle, S
                                  .of(context)
                                  .removeDeviceConfirmBody + "\n" + S
                                  .of(context)
                                  .confirmActionConnectedToRouterWarning,
                                  fontSize)
                                  : confResponse = await confirmDialog(
                                  context, S
                                  .of(context)
                                  .removeDeviceConfirmTitle, S
                                  .of(context)
                                  .removeDeviceConfirmBody, fontSize);

                              if (confResponse) {
                                socket.sendXML(
                                    "RemoveAdapter", mac: hitDevice.mac);

                                var response = await socket.receiveXML(
                                    "RemoveAdapterStatus");
                                if (response!['result'] == "device_not_found") {
                                  errorDialog(context, S
                                      .of(context)
                                      .removeDeviceErrorTitle, S
                                      .of(context)
                                      .deviceNotFoundRemoveDevice + "\n\n" + S
                                      .of(context)
                                      .deviceNotFoundHint, fontSize);
                                } else if (response['result'] != "ok") {
                                  errorDialog(context, S
                                      .of(context)
                                      .removeDeviceErrorTitle, S
                                      .of(context)
                                      .removeDeviceErrorBody, fontSize);
                                }
                              }
                            }
                        ),
                        Text(
                          S
                              .of(context)
                              .deleteDevice,
                          style: TextStyle(
                              fontSize: 14, color: fontColorOnBackground),
                          textScaleFactor: fontSize.factor,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ), //ToDo Delete Device see wiki
                    if (hitDevice.disableTraffic[0] == 1 ||
                        hitDevice.disableLeds[0] == 1 ||
                        hitDevice.disableStandby[0] == 1 ||
                        (hitDevice.ipConfigAddress.isNotEmpty ||
                            hitDevice.ipConfigMac.isNotEmpty ||
                            hitDevice.ipConfigNetmask.isNotEmpty))
                      Column(
                        children: [
                          IconButton(
                              icon: Icon(
                                DevoloIcons.devolo_UI_more_horiz,
                                color: fontColorOnBackground,
                              ),
                              hoverColor: fontColorOnBackground.withAlpha(50),
                              iconSize: 24.0 * fontSize.factor,
                              onPressed: () {
                                moreSettings(
                                    context,
                                    socket,
                                    hitDevice.disableTraffic,
                                    hitDevice.disableLeds,
                                    hitDevice.disableStandby,
                                    hitDevice.mac,
                                    hitDevice.ipConfigMac,
                                    hitDevice.ipConfigAddress,
                                    hitDevice.ipConfigNetmask,
                                    fontSize);
                              }),
                          Text(
                            S
                                .of(context)
                                .additionalSettings,
                            style: TextStyle(
                                fontSize: 14, color: fontColorOnBackground),
                            textScaleFactor: fontSize.factor,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
    },
  ).then((value) => dialogClosed = true);
}


void showVDSLDialog(context, socket, String hitDeviceVDSLmode, List<String> hitDeviceVDSLList, String vdslProfile, hitDeviceMac, FontSize fontSize) async {

  bool vdslModeAutomatic = false;
  if(hitDeviceVDSLmode == "2")
    vdslModeAutomatic = true;

  bool? returnVal = await showDialog(
      context: context,
      barrierDismissible: true, // user doesn't need to tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 300),
          title: Text(S.of(context).vdslCompatibility),
          titleTextStyle: TextStyle(color: fontColorOnBackground, decorationColor: fontColorOnBackground, fontSize: dialogTitleTextFontSize * fontSize.factor),
          contentTextStyle: TextStyle(color: fontColorOnBackground, decorationColor: fontColorOnBackground, fontSize: dialogContentTextFontSize * fontSize.factor),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if(hitDeviceVDSLmode != "0")
                        Column(children: [
                          SelectableText(S.of(context).vdslExplanation),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                Theme(
                                  data: ThemeData(
                                    //here change to your color
                                    unselectedWidgetColor: fontColorOnBackground,
                                  ),
                                  child: Checkbox(
                                      value: vdslModeAutomatic,
                                      activeColor: fontColorOnBackground,
                                      onChanged: (bool? newValue) async {
                                        vdslModeAutomatic = newValue!;
                                        setState(() {
                                          if (vdslModeAutomatic == true) {
                                            hitDeviceVDSLmode = "2";
                                          } else {
                                            hitDeviceVDSLmode = "1";
                                          }
                                        });
                                      }),
                                ),
                                SelectableText(S.of(context).automaticCompatibilityMode),
                              ],
                            ),
                          ),
                          SelectableText(S.of(context).vdslExplanation2),
                        ],),
                      for (String vdsl_profile in hitDeviceVDSLList)
                        ListTile(
                          title: Text(
                            vdsl_profile,
                            style:  TextStyle(color: fontColorOnBackground, decorationColor: fontColorOnBackground, fontSize: dialogContentTextFontSize * fontSize.factor),
                          ),
                          leading: Theme(
                            data: ThemeData(
                              //here change to your color
                              unselectedWidgetColor: fontColorOnBackground,
                            ),
                            child: Radio(
                              value: vdsl_profile,
                              groupValue: vdslProfile,
                              activeColor: fontColorOnBackground,
                              onChanged: (String? value) {
                                setState(() {
                                  vdslProfile = value!;
                                });
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              }),
          actions: <Widget>[
            getConfirmButton(context, fontSize),
            getCancelButton(context, fontSize),

          ],

        );
      });

  if (returnVal == null) returnVal = false;

  if (returnVal == true) {

    socket.sendXML('SetVDSLCompatibility', newValue: vdslProfile, valueType: 'profile', newValue2: hitDeviceVDSLmode, valueType2: 'mode', mac: hitDeviceMac);

      circularProgressIndicatorInMiddle(context);

    var response = await socket.receiveXML("SetVDSLCompatibilityStatus");
    if (response['result'] == "failed" || response['result'] == "timeout") {
      Navigator.maybeOf(context)!.pop(true);
      errorDialog(context, "Error", S.of(context).vdslFailed, fontSize);
    } else if (response['result'] == "ok") {
      Navigator.maybeOf(context)!.pop(true);
      errorDialog(context, "Done", S.of(context).vdslSuccessful, fontSize);
    }
    else {
      logger.w("[showVDSLDialog] - Unexpected response: " + response['result']);
      Navigator.maybeOf(context)!.pop();
    }
  }
  else {
    Navigator.maybeOf(context)!.pop(false);
  }
}

// add confirm button manually
void moreSettings(BuildContext context, socket, List<int> disableTraffic,List<int> disableLeds, List<int> disableStandby, String mac, String ipConfigMac, String ipConfigAddress, String ipConfigNetmask, FontSize fontSize) {

  final _formKey = GlobalKey<FormState>();
  String formIpAdress = ipConfigAddress;
  String formNetmask = ipConfigNetmask;


  // Styling
  Color switchActiveTrackColor = devoloGreen.withOpacity(0.4);
  Color switchActiveThumbColor = devoloGreen;
  Color switchInactiveThumbColor = Colors.white;
  Color switchInactiveTrackColor = Color(0x61000000);

  showDialog<void> (
      context: context,
      barrierDismissible: true, // user doesn't need to tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 0),
          titleTextStyle: TextStyle(color: fontColorOnBackground, decorationColor: fontColorOnBackground, fontSize: dialogTitleTextFontSize * fontSize.factor),
          contentTextStyle: TextStyle(color: fontColorOnBackground, decorationColor: fontColorOnBackground, fontSize: dialogContentTextFontSize * fontSize.factor),
          title: Column(
            children: [
              getCloseButton(context),
              Center(
                  child: Text(
                    S.of(context).additionalDialogTitle,
                    style: TextStyle(color: fontColorOnBackground),
                  )
              ),
            ],
          ),
          titlePadding: EdgeInsets.all(dialogTitlePadding),
          content: StatefulBuilder( builder: (BuildContext context, StateSetter setState) {
            return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if(disableLeds[0] == 1)
                    SwitchListTile(
                      title: Text(S
                          .of(context)
                          .activateLEDs, style: TextStyle(
                          color: fontColorOnBackground,
                          fontSize: dialogContentTextFontSize *
                              fontSize.factor)),
                      value: disableLeds[1] == 0 ? true : false,
                      onChanged: (bool value) async {
                        String newStatus = value ? "0" : "1";
                        socket.sendXML('DisableLEDs', newValue: newStatus,
                            valueType: 'state',
                            mac: mac);
                        circularProgressIndicatorInMiddle(context);
                        var response = await socket.receiveXML(
                            "DisableLEDsStatus");
                        if (response['result'] == "ok") {
                          disableLeds[1] = value ? 0 : 1;
                          Navigator.maybeOf(context)!.pop();
                        }
                        else {
                          Navigator.maybeOf(context)!.pop();
                          errorDialog(context, S
                              .of(context)
                              .activateLEDsFailedTitle, S
                              .of(context)
                              .activateLEDsFailedBody, fontSize);
                        }
                      },
                      secondary: Icon(DevoloIcons.ic_lightbulb_outline_24px,
                          color: fontColorOnBackground,
                          size: 24 * fontSize.factor),
                      activeTrackColor: switchActiveTrackColor,
                      activeColor: switchActiveThumbColor,
                      inactiveThumbColor: switchInactiveThumbColor,
                      inactiveTrackColor: switchInactiveTrackColor,
                    ),
                  if(disableTraffic[0] == 1)
                    SwitchListTile(
                      title: Text(S
                          .of(context)
                          .activateTransmission, style: TextStyle(
                          color: fontColorOnBackground,
                          fontSize: dialogContentTextFontSize *
                              fontSize.factor)),
                      value: disableTraffic[1] == 0 ? true : false,
                      onChanged: (bool value) async {
                        String newStatus = value ? "0" : "1";
                        socket.sendXML('DisableTraffic', newValue: newStatus,
                            valueType: 'state',
                            mac: mac);
                        circularProgressIndicatorInMiddle(context);
                        var response = await socket.receiveXML(
                            "DisableTrafficStatus");
                        if (response['result'] == "ok") {
                          disableTraffic[1] = value ? 0 : 1;
                          Navigator.maybeOf(context)!.pop();
                        }
                        else {
                          Navigator.maybeOf(context)!.pop();
                          errorDialog(context, S
                              .of(context)
                              .activateTransmissionFailedTitle, S
                              .of(context)
                              .activateTransmissionFailedBody, fontSize);
                        }
                      },
                      secondary: Icon(DevoloIcons.ic_perm_data_setting_24px,
                          color: fontColorOnBackground,
                          size: 24 * fontSize.factor),
                      activeTrackColor: switchActiveTrackColor,
                      activeColor: switchActiveThumbColor,
                      inactiveThumbColor: switchInactiveThumbColor,
                      inactiveTrackColor: switchInactiveTrackColor,
                    ),
                  if(disableStandby[0] == 1)
                    SwitchListTile(
                      title: Text(S
                          .of(context)
                          .powerSavingMode, style: TextStyle(
                          color: fontColorOnBackground,
                          fontSize: dialogContentTextFontSize *
                              fontSize.factor)),
                      value: disableStandby[1] == 0 ? true : false,
                      onChanged: (bool value) async {
                        String newStatus = value ? "0" : "1";
                        socket.sendXML('DisableStandby', newValue: newStatus,
                            valueType: 'state',
                            mac: mac);
                        circularProgressIndicatorInMiddle(context);
                        var response = await socket.receiveXML(
                            "DisableStandbyStatus");
                        if (response['result'] == "ok") {
                          disableStandby[1] = value ? 0 : 1;
                          Navigator.maybeOf(context)!.pop();
                        }
                        else {
                          Navigator.maybeOf(context)!.pop();
                          errorDialog(context, S
                              .of(context)
                              .powerSavingModeFailedTitle, S
                              .of(context)
                              .powerSavingModeFailedBody, fontSize);
                        }
                      },
                      secondary: Icon(DevoloIcons.ic_battery_charging_full_24px,
                          color: fontColorOnBackground,
                          size: 24 * fontSize.factor),
                      activeTrackColor: switchActiveTrackColor,
                      activeColor: switchActiveThumbColor,
                      inactiveThumbColor: switchInactiveThumbColor,
                      inactiveTrackColor: switchInactiveTrackColor,
                    ),
                  if ((ipConfigAddress.isNotEmpty || ipConfigMac.isNotEmpty || ipConfigNetmask.isNotEmpty) && (disableLeds[0] == 1 || disableTraffic[0] == 1 || disableStandby[0] == 1))
                  SizedBox(height: 20,),
                  if ((ipConfigAddress.isNotEmpty || ipConfigMac.isNotEmpty || ipConfigNetmask.isNotEmpty) && (disableLeds[0] == 1 || disableTraffic[0] == 1 || disableStandby[0] == 1))
                  Divider(color: fontColorOnBackground),
                  if ((ipConfigAddress.isNotEmpty || ipConfigMac.isNotEmpty || ipConfigNetmask.isNotEmpty) && (disableLeds[0] == 1 || disableTraffic[0] == 1 || disableStandby[0] == 1))
                  SizedBox(height: 20,),
                  if (ipConfigAddress.isNotEmpty || ipConfigMac.isNotEmpty || ipConfigNetmask.isNotEmpty)
                  Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            initialValue: formIpAdress,
                            style: TextStyle(color: fontColorOnBackground),
                            decoration: InputDecoration(
                              labelText: S
                                  .of(context)
                                  .ipAddress,
                              labelStyle: TextStyle(
                                  color: fontColorOnBackground,
                                  fontSize: dialogContentTextFontSize *
                                      fontSize.factor),
                              hoverColor: fontColorOnBackground.withOpacity(
                                  0.2),
                              contentPadding: new EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 10.0),
                              filled: true,
                              fillColor: fontColorOnBackground.withOpacity(0.2),
                              errorStyle: TextStyle(color: devoloRed),
                              //myFocusNode.hasFocus ? secondColor.withOpacity(0.2):Colors.transparent,//secondColor.withOpacity(0.2),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: fontColorOnBackground,
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: fontColorOnBackground, //Colors.transparent,
                                  //width: 2.0,
                                ),
                              ),
                              //labelStyle: TextStyle(color: myFocusNode.hasFocus ? Colors.amberAccent : Colors.blue),
                            ),
                            onChanged: (String value) {
                              setState(() {
                                formIpAdress = value;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return S
                                    .of(context)
                                    .fillInIpAddress;
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            initialValue: formNetmask,
                            style: TextStyle(color: fontColorOnBackground),
                            decoration: InputDecoration(
                              labelText: S
                                  .of(context)
                                  .netmask,
                              labelStyle: TextStyle(
                                  color: fontColorOnBackground,
                                  fontSize: dialogContentTextFontSize *
                                      fontSize.factor),
                              hoverColor: fontColorOnBackground.withOpacity(
                                  0.2),
                              contentPadding: new EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 10.0),
                              filled: true,
                              fillColor: fontColorOnBackground.withOpacity(0.2),
                              errorStyle: TextStyle(color: devoloRed),
                              //myFocusNode.hasFocus ? secondColor.withOpacity(0.2):Colors.transparent,//secondColor.withOpacity(0.2),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: fontColorOnBackground,
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: fontColorOnBackground, //Colors.transparent,
                                  //width: 2.0,
                                ),
                              ),
                            ),
                            onChanged: (String value) {
                              setState(() {
                                formNetmask = value;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return S
                                    .of(context)
                                    .fillInNetmask;
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            alignment: Alignment.centerRight, child:
                          TextButton(
                            child: Text(
                              S
                                  .of(context)
                                  .change,
                              style: TextStyle(
                                  fontSize: dialogContentTextFontSize,
                                  color: (formIpAdress != ipConfigAddress || formNetmask != ipConfigNetmask) ? Colors.white : buttonDisabledForeground),
                              textScaleFactor: fontSize.factor,
                            ),
                            onPressed: (formIpAdress != ipConfigAddress ||
                                formNetmask != ipConfigNetmask)
                                ? () async {
                                  if (_formKey.currentState!.validate()) {
                                    socket.sendXML('SetIpConfig',newValue2 : formIpAdress,valueType2 : 'address',newValue : formNetmask,valueType : 'netmask',mac : ipConfigMac);
                                    circularProgressIndicatorInMiddle(context);
                                    var response = await socket.receiveXML(
                                        "SetIpConfigStatus");
                                    if (response!['result'] == "ok") {
                                      Navigator.maybeOf(context)!.pop();
                                      await Future.delayed(
                                          const Duration(seconds: 1), () {});
                                      socket.sendXML('RefreshNetwork');

                                    } else
                                    if (response['result'] == "device_not_found") {
                                      Navigator.maybeOf(context)!.pop();
                                      errorDialog(context, S
                                          .of(context)
                                          .setIpConfigErrorTitle, S
                                          .of(context)
                                          .deviceNotFoundSetIpConfig + "\n\n" + S
                                          .of(context)
                                          .deviceNotFoundHint, fontSize);
                                    } else if (response['result'] != "ok") {
                                      Navigator.maybeOf(context)!.pop();
                                      errorDialog(context, S
                                          .of(context)
                                          .setIpConfigErrorTitle, S
                                          .of(context)
                                          .setIpConfigErrorBody, fontSize);
                                    }
                                  }
                                  else {

                                  }
                                }
                                : null,
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty
                                    .resolveWith<Color?>(
                                      (states) {
                                    if (states.contains(
                                        MaterialState.hovered)) {
                                      return devoloGreen.withOpacity(
                                          hoverOpacity);
                                    } else if (states.contains(
                                        MaterialState.pressed)) {
                                      return devoloGreen.withOpacity(
                                          activeOpacity);
                                    }
                                    return (formIpAdress != ipConfigAddress || formNetmask != ipConfigNetmask) ? devoloGreen : buttonDisabledBackground;
                                  },
                                ),
                                padding: MaterialStateProperty.all<
                                    EdgeInsetsGeometry>(EdgeInsets.symmetric(
                                    vertical: 13.0, horizontal: 32.0)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                    )
                                )
                            ),
                          ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      )
                  )
                ]);
          }),
        );
      });
}

void circularProgressIndicatorInMiddle(context){
  showDialog<void>(
      context: context,
      barrierDismissible: false, // user doesn't need to tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: Column(mainAxisSize: MainAxisSize.min ,
              children: [
                CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(fontColorOnBackground),)]
          ),
        );
      });
}
