// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "LoadCockpitSupportInformationsBody":
            MessageLookupByLibrary.simpleMessage(
                "Support informations are getting generated"),
        "UpdateDeviceFailedBody": MessageLookupByLibrary.simpleMessage(
            "Following devices could not be updated:"),
        "UpdateDeviceFailedTitle":
            MessageLookupByLibrary.simpleMessage("Update failed"),
        "activateLEDs": MessageLookupByLibrary.simpleMessage("LEDs activated"),
        "activateLEDsFailedBody": MessageLookupByLibrary.simpleMessage(
            "An error occurred while modifying the LEDs!\nTry again later"),
        "activateLEDsFailedTitle":
            MessageLookupByLibrary.simpleMessage("Action failed"),
        "activateTransmission": MessageLookupByLibrary.simpleMessage(
            "Data communication activated"),
        "activateTransmissionFailedBody": MessageLookupByLibrary.simpleMessage(
            "An error occurred while setting the data communication!\nTry again later"),
        "activateTransmissionFailedTitle":
            MessageLookupByLibrary.simpleMessage("Action failed"),
        "add": MessageLookupByLibrary.simpleMessage("Add"),
        "addDevice": MessageLookupByLibrary.simpleMessage("Add device"),
        "addDeviceInstructionText": MessageLookupByLibrary.simpleMessage(
            "1) Plug both PLC devices into wall sockets and wait for 45 seconds.\n2) Briefly press the encryption button of the existing PLC device.\n(Alternatively start pairing via the web interface of the existing device.)\n3) Within 2 minutes, press the encryption button of the new PLC device also briefly.\n4) As soon as the LEDs light up and do not blink, the PLC devices are ready for operation."),
        "additionalDialogTitle":
            MessageLookupByLibrary.simpleMessage("Additional settings"),
        "additionalSettings":
            MessageLookupByLibrary.simpleMessage("additional\nsettings"),
        "appInfo": MessageLookupByLibrary.simpleMessage("App info"),
        "appInformation":
            MessageLookupByLibrary.simpleMessage("App information"),
        "appTheme": MessageLookupByLibrary.simpleMessage("App Theme"),
        "appearance": MessageLookupByLibrary.simpleMessage("Appearance"),
        "attachedToRouter":
            MessageLookupByLibrary.simpleMessage("Attached to router"),
        "automaticCompatibilityMode": MessageLookupByLibrary.simpleMessage(
            "Automatic compatibility mode (recommended)"),
        "back": MessageLookupByLibrary.simpleMessage("Back"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "change": MessageLookupByLibrary.simpleMessage("Change"),
        "changePlcnetworkPassword":
            MessageLookupByLibrary.simpleMessage("Change PLC network password"),
        "changeTheLanguageOfTheApp":
            MessageLookupByLibrary.simpleMessage("Change language"),
        "checkUpdates":
            MessageLookupByLibrary.simpleMessage("Check for updates"),
        "chooseTheAppTheme":
            MessageLookupByLibrary.simpleMessage("Choose the app theme"),
        "chooseTheme": MessageLookupByLibrary.simpleMessage("Change theme"),
        "cockpitSoftwareIsUpToDate": MessageLookupByLibrary.simpleMessage(
            "Cockpit software is up to date"),
        "cockpitSupportInformationsBody": MessageLookupByLibrary.simpleMessage(
            "The support informations have been created and are now available to you. Please select an action."),
        "cockpitSupportInformationsTitle": MessageLookupByLibrary.simpleMessage(
            "devolo Cockpit support informations"),
        "complete": MessageLookupByLibrary.simpleMessage("complete"),
        "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "confirmAction": MessageLookupByLibrary.simpleMessage("Confirm action"),
        "confirmActionConnectedToRouterWarning":
            MessageLookupByLibrary.simpleMessage(
                "Attention! Your router is connected to this PLC device. You will lose connection to the internet"),
        "contactInfo":
            MessageLookupByLibrary.simpleMessage("Contact information"),
        "contactSupport":
            MessageLookupByLibrary.simpleMessage("Contact support"),
        "currentVersion":
            MessageLookupByLibrary.simpleMessage("Current version"),
        "dataRatesArePermanentlyDisplayedInTheOverview":
            MessageLookupByLibrary.simpleMessage(
                "Data transfer rates are always shown in overview"),
        "deleteDevice": MessageLookupByLibrary.simpleMessage("Delete device"),
        "deviceNameDialogBody": MessageLookupByLibrary.simpleMessage(
            "Do you really want to rename this device?"),
        "deviceNameDialogTitle":
            MessageLookupByLibrary.simpleMessage("Confirm"),
        "deviceNameErrorBody": MessageLookupByLibrary.simpleMessage(
            "An error occurred while changing the name.\nTry again later"),
        "deviceNameErrorTitle":
            MessageLookupByLibrary.simpleMessage("Name change failed"),
        "deviceNotFoundDeviceName": MessageLookupByLibrary.simpleMessage(
            "An error occurred while setting the device name"),
        "deviceNotFoundHint": MessageLookupByLibrary.simpleMessage(
            " - Has the PLC device been disconnected from the power grid?\n - Is the PLC device in power-saving mode?"),
        "deviceNotFoundIdentifyDevice": MessageLookupByLibrary.simpleMessage(
            "An error occurred while removing the device"),
        "deviceNotFoundRemoveDevice": MessageLookupByLibrary.simpleMessage(
            "An error occurred while removing the device"),
        "deviceNotFoundResetDevice": MessageLookupByLibrary.simpleMessage(
            "An error occurred while resetting the device"),
        "deviceinfo":
            MessageLookupByLibrary.simpleMessage("Device information"),
        "emailIsInvalid":
            MessageLookupByLibrary.simpleMessage("E-mail is invalid"),
        "enableShowingSpeeds":
            MessageLookupByLibrary.simpleMessage("Show network speeds"),
        "factoryReset": MessageLookupByLibrary.simpleMessage("Factory reset"),
        "failed": MessageLookupByLibrary.simpleMessage("failed"),
        "fontsize": MessageLookupByLibrary.simpleMessage("Set font size"),
        "forward": MessageLookupByLibrary.simpleMessage("Next"),
        "fullyCustomizeColors":
            MessageLookupByLibrary.simpleMessage("Customize colors"),
        "general": MessageLookupByLibrary.simpleMessage("General"),
        "generateSupportInformation": MessageLookupByLibrary.simpleMessage(
            "Generate support information"),
        "help": MessageLookupByLibrary.simpleMessage("Help"),
        "highContrast": MessageLookupByLibrary.simpleMessage("High contrast"),
        "homeNetworkDesktop":
            MessageLookupByLibrary.simpleMessage("Home network desktop"),
        "identifyDevice":
            MessageLookupByLibrary.simpleMessage("Identify device"),
        "identifyDeviceErrorTitle":
            MessageLookupByLibrary.simpleMessage("Identifying failed"),
        "ignoreUpdates":
            MessageLookupByLibrary.simpleMessage("Ignore device updates"),
        "install": MessageLookupByLibrary.simpleMessage("Install"),
        "internet": MessageLookupByLibrary.simpleMessage("Internet"),
        "internetcentered": MessageLookupByLibrary.simpleMessage(
            "Use internet-centered overview"),
        "ipaddress": MessageLookupByLibrary.simpleMessage("IP address"),
        "isLocalDevice":
            MessageLookupByLibrary.simpleMessage("Is local device"),
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "launchWebinterface":
            MessageLookupByLibrary.simpleMessage("Web interface"),
        "macaddress": MessageLookupByLibrary.simpleMessage("MAC address"),
        "manualErrorBody": MessageLookupByLibrary.simpleMessage(
            "No suitable manual was found for your PLC device.\n\nYou can find the manual on the product CD or on the devolo website"),
        "manualErrorTitle":
            MessageLookupByLibrary.simpleMessage("Manual not found"),
        "mtnumber": MessageLookupByLibrary.simpleMessage("devolo MT number"),
        "name": MessageLookupByLibrary.simpleMessage("Name"),
        "network": MessageLookupByLibrary.simpleMessage("Network"),
        "networkPasswordErrorBody": MessageLookupByLibrary.simpleMessage(
            "An error occurred while setting the network password"),
        "networkPasswordErrorHint": MessageLookupByLibrary.simpleMessage(
            "- Check the connection to the PLC device and repeat the action"),
        "networkPasswordErrorTitle": MessageLookupByLibrary.simpleMessage(
            "Failed to set the network password"),
        "networkSettings":
            MessageLookupByLibrary.simpleMessage("Network settings"),
        "networkoverview":
            MessageLookupByLibrary.simpleMessage("Network overview"),
        "newVersion": MessageLookupByLibrary.simpleMessage("New version"),
        "nextNetwork": MessageLookupByLibrary.simpleMessage("Next network"),
        "no": MessageLookupByLibrary.simpleMessage("no"),
        "noDevicesFoundNscanningForDevices":
            MessageLookupByLibrary.simpleMessage(
                "No devices found. \n\nScanning for devices ..."),
        "openOptimization":
            MessageLookupByLibrary.simpleMessage("Open optimization help"),
        "openSupportInformations": MessageLookupByLibrary.simpleMessage("Open"),
        "optimizationHelp":
            MessageLookupByLibrary.simpleMessage("Optimization help"),
        "optimizeReception":
            MessageLookupByLibrary.simpleMessage("Optimize reception"),
        "otherDevicesEgPcAreDisplayedInTheOverview":
            MessageLookupByLibrary.simpleMessage(
                "Overview shows other devices, e.g., laptops and mobiles"),
        "overview": MessageLookupByLibrary.simpleMessage("Overview"),
        "pending": MessageLookupByLibrary.simpleMessage("pending"),
        "pleaseConfirmAction":
            MessageLookupByLibrary.simpleMessage("Confirm action"),
        "pleaseEnterDeviceName":
            MessageLookupByLibrary.simpleMessage("Enter device name"),
        "pleaseEnterDevicename":
            MessageLookupByLibrary.simpleMessage("Enter a device name"),
        "pleaseEnterPassword":
            MessageLookupByLibrary.simpleMessage("Enter password"),
        "pleaseEnterProcessingNumber":
            MessageLookupByLibrary.simpleMessage("Enter processing number"),
        "pleaseEnterYourMailAddress":
            MessageLookupByLibrary.simpleMessage("Enter your email address"),
        "pleaseFillInYourName":
            MessageLookupByLibrary.simpleMessage("Enter your name"),
        "powerSavingMode":
            MessageLookupByLibrary.simpleMessage("Power saving mode"),
        "powerSavingModeFailedBody": MessageLookupByLibrary.simpleMessage(
            "An error occurred while setting the Power save mode!\nTry again later"),
        "powerSavingModeFailedTitle":
            MessageLookupByLibrary.simpleMessage("Action failed"),
        "previousNetwork":
            MessageLookupByLibrary.simpleMessage("Previous network"),
        "processNumber": MessageLookupByLibrary.simpleMessage("Process number"),
        "recordTheTransmissionPowerOfTheDevicesAndTransmitIt":
            MessageLookupByLibrary.simpleMessage(
                "Record the transmission power of PLC devices and send it to devolo"),
        "refresh": MessageLookupByLibrary.simpleMessage("Refresh"),
        "removeDeviceConfirmBody": MessageLookupByLibrary.simpleMessage(
            "Do you want to remove the selected PLC device from the network?"),
        "removeDeviceConfirmTitle":
            MessageLookupByLibrary.simpleMessage("Remove the PLC device?"),
        "removeDeviceErrorBody": MessageLookupByLibrary.simpleMessage(
            "An error occurred while removing the device!\nTry again later"),
        "removeDeviceErrorTitle":
            MessageLookupByLibrary.simpleMessage("Remove failed"),
        "resetDeviceConfirmBody": MessageLookupByLibrary.simpleMessage(
            "Do you want to reset the selected PLC device to the delivery state?"),
        "resetDeviceConfirmTitle": MessageLookupByLibrary.simpleMessage(
            "Reset device to delivery state"),
        "resetDeviceErrorBody": MessageLookupByLibrary.simpleMessage(
            "An error occurred while resetting the device!\nTry again later"),
        "resetDeviceErrorTitle":
            MessageLookupByLibrary.simpleMessage("Reset failed"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "saveSupportInformations": MessageLookupByLibrary.simpleMessage("Save"),
        "searching": MessageLookupByLibrary.simpleMessage("Searching..."),
        "selectAll": MessageLookupByLibrary.simpleMessage("Select all"),
        "sendToDevolo": MessageLookupByLibrary.simpleMessage("Send"),
        "serialNumber": MessageLookupByLibrary.simpleMessage("Serial number"),
        "setUpDevice": MessageLookupByLibrary.simpleMessage("Setup new device"),
        "setVdslCompatibility":
            MessageLookupByLibrary.simpleMessage("Set VDSL \ncompatibility"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "showLicences": MessageLookupByLibrary.simpleMessage("show licenses"),
        "showLogs": MessageLookupByLibrary.simpleMessage("Show logs"),
        "showManual": MessageLookupByLibrary.simpleMessage("Show manual"),
        "showOtherDevices":
            MessageLookupByLibrary.simpleMessage("Show other devices"),
        "showPassword": MessageLookupByLibrary.simpleMessage("Show password"),
        "state": MessageLookupByLibrary.simpleMessage("State"),
        "support": MessageLookupByLibrary.simpleMessage("Support"),
        "supportInfoGenerateError": MessageLookupByLibrary.simpleMessage(
            "An error occurred while creating the support informations.\nPlease try again!"),
        "theCreatedSupportInformationCanNowBeSentToDevolo":
            MessageLookupByLibrary.simpleMessage(
                "The created support information can now be sent to devolo support.\nFill in the following fields"),
        "theOverviewWillBeCenteredAroundThePlcDeviceConnected":
            MessageLookupByLibrary.simpleMessage(
                "The overview is centered around the PLC device connected to the internet"),
        "thisDeviceIsConnectedDirectlyToTheInternetRouter":
            MessageLookupByLibrary.simpleMessage(
                "This device is connected directly to the internet router."),
        "thisPc": MessageLookupByLibrary.simpleMessage("This PC"),
        "title": MessageLookupByLibrary.simpleMessage("devolo Cockpit"),
        "type": MessageLookupByLibrary.simpleMessage("Type"),
        "upToDate": MessageLookupByLibrary.simpleMessage("Up-to-date"),
        "update": MessageLookupByLibrary.simpleMessage("Update"),
        "update2": MessageLookupByLibrary.simpleMessage("Update available"),
        "updateReadyToInstall":
            MessageLookupByLibrary.simpleMessage("Ready to install updates"),
        "updateSelected":
            MessageLookupByLibrary.simpleMessage("Update selected"),
        "updates": MessageLookupByLibrary.simpleMessage("Updates"),
        "updating": MessageLookupByLibrary.simpleMessage("Updating..."),
        "vdslCompatibility":
            MessageLookupByLibrary.simpleMessage("VDSL compatibility"),
        "vdslexplanation": MessageLookupByLibrary.simpleMessage(
            "In rare cases, noise from Powerline signal can interfere with VDSL connection. Devices in automatic compatibility mode can automatically adjust transmission to limit interference"),
        "vdslexplanation2": MessageLookupByLibrary.simpleMessage(
            "Select a transmission profile from the given options as a fallback when automatic mode is OFF or reliable detection of interference is not possible"),
        "vdslfailed": MessageLookupByLibrary.simpleMessage(
            "The new VDSL settings could not be saved on the device"),
        "vdslsuccessful": MessageLookupByLibrary.simpleMessage(
            "The new VDSL settings have been saved on the device"),
        "version": MessageLookupByLibrary.simpleMessage("Firmware version"),
        "windowsNetworkThrottling": MessageLookupByLibrary.simpleMessage(
            "Use Windows network throttling"),
        "yes": MessageLookupByLibrary.simpleMessage("yes"),
        "yourCurrentTerminalIsConnectedToThisDevolodevice":
            MessageLookupByLibrary.simpleMessage(
                "Your current terminal is connected to this devolo device."),
        "yourEmailaddress":
            MessageLookupByLibrary.simpleMessage("Your email address"),
        "yourName": MessageLookupByLibrary.simpleMessage("Your name"),
        "yourPc": MessageLookupByLibrary.simpleMessage("Your PC")
      };
}
