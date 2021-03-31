import 'package:permission_handler/permission_handler.dart';

import '../contacts/contacts_page.dart';

Future checkPermisson() async {
  contactsPermission = await Permission.contacts.request().isGranted;
  storagePermission = await Permission.storage.request().isGranted;
  if (contactsPermission != true) {
    await Permission.contacts.request();
  }
  if (storagePermission != true) {
    await Permission.storage.request();
  }
}
