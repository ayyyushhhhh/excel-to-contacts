import 'dart:io';
import 'package:contacts_app/contacts/add_contacts_page.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_svg/svg.dart';
import '../functions/functions.dart';

List<String> Name = [];
List<String> ContactNumber = [];
var contactFile;
bool storagePermission;
bool contactsPermission;

class contactsPage extends StatefulWidget {
  @override
  _contactsPageState createState() => _contactsPageState();
}

class _contactsPageState extends State<contactsPage> {
  List<dynamic> contacts = [];
  String namesIndex = '0';
  String contactIndex = '1';
  @override
  void initState() {
    super.initState();
    checkPermisson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Contacts'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/upload.svg',
              width: 200,
            ),
            SizedBox(
              width: 60,
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Enter The Column Number For Names'),
                  SizedBox(
                    width: 30,
                    child: TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        namesIndex = value;
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 60,
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Enter The Column Number For Numbers'),
                  SizedBox(
                    width: 30,
                    child: TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        contactIndex = value;
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 60,
            ),
            // ignore: deprecated_member_use
            RaisedButton(
              child: contactFile == null
                  ? Text('Upload csv/xlsx File')
                  : CircularProgressIndicator(),
              onPressed: () async {
                Name.clear();
                checkPermisson();
                await getFile();
                convertfileToExcel();
                if (Name.isNotEmpty && ContactNumber.isNotEmpty) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              addContacts(name: Name, number: ContactNumber)));
                }
              },
            ),
            SizedBox(
              width: 60,
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Text(
                  'Read Me - Before Uploading the Xlsx/csv file.Check Column number for names and Contact number. By default, it is set to 1 & 2. If Nothing Happened, then your columns are empty'),
            )
          ],
        ),
      ),
    );
  }

  void convertfileToExcel() {
    try {
      var file = contactFile.path.toString();
      var bytes = File(file).readAsBytesSync();
      var excel = Excel.decodeBytes(bytes);
      for (var table in excel.sheets.keys) {
        for (int i = 0; i < excel.tables[table].maxRows; i++) {
          if (excel.tables[table].rows[i][int.parse(namesIndex) - 1] != null &&
              excel.tables[table].rows[i][int.parse(contactIndex) - 1] !=
                  null) {
            Name.add(excel.tables[table].rows[i][int.parse(namesIndex) - 1]);
            ContactNumber.add(excel
                .tables[table].rows[i][int.parse(contactIndex) - 1]
                .toString());
          }
        }
        Name.removeAt(0);
        ContactNumber.removeAt(0);
      }
    } catch (e) {
      print(e);
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
}
