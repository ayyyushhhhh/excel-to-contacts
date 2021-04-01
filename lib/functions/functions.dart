import 'dart:io';
import 'package:excel/excel.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';
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

void convertfileToExcel() {
  try {
    var file = contactFile.path.toString();
    var bytes = File(file).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.sheets.keys) {
      checkIndex(excel, table);

      for (int i = 0; i < excel.tables[table].maxRows; i++) {
        if (excel.tables[table].rows[i][int.parse(namesIndex) - 1] != null &&
            excel.tables[table].rows[i][int.parse(contactIndex) - 1] != null) {
          Name.add(excel.tables[table].rows[i][int.parse(namesIndex) - 1]
              .toString());
          ContactNumber.add(excel
              .tables[table].rows[i][int.parse(contactIndex) - 1]
              .toString());
        }
      }
      Name.removeAt(
          0); //to remove the first cell of the name column that is the title of the column.
      ContactNumber.removeAt(
          0); //to remove the first cell of the contact column that is the title of the column.
    }
    namesIndex = '1';
    contactIndex = '2';
  } catch (e) {
    print(e);
  }
}

void checkIndex(Excel excel, String table) {
  if (int.parse(namesIndex) - 1 < 0 ||
      int.parse(namesIndex) - 1 > excel.tables[table].maxRows ||
      int.parse(namesIndex) == null) {
    namesIndex = '1';
  }
  if (int.parse(contactIndex) - 1 < 0 ||
      int.parse(contactIndex) - 1 > excel.tables[table].maxRows ||
      int.parse(contactIndex) == null) {
    namesIndex = '2';
  }
}

Future getFile() async {
  contactFile = null;

  try {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'csv'],
    );
    if (result != null) {
      contactFile = result.files.first;
    }
  } catch (e) {
    print(e);
  }
}
