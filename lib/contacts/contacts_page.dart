import 'package:contacts_app/contacts/add_contacts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../functions/functions.dart';

List<String> Name = [];
List<String> ContactNumber = [];
var contactFile;
bool storagePermission;
bool contactsPermission;
String namesIndex = '1';
String contactIndex = '2';

class contactsPage extends StatefulWidget {
  @override
  _contactsPageState createState() => _contactsPageState();
}

class _contactsPageState extends State<contactsPage> {
  List<dynamic> contacts = [];
  TextEditingController namecontroller = TextEditingController();
  TextEditingController contactController = TextEditingController();

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
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Expanded(
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
                        controller: namecontroller,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          print(value);
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
                        controller: contactController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          print(value);
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
                child: Text('Upload xlsx File'),
                onPressed: () async {
                  print(int.parse(namesIndex) - 1);
                  print(int.parse(contactIndex) - 1);
                  Name.clear();
                  ContactNumber.clear();
                  checkPermisson();
                  await getFile();
                  convertfileToExcel();

                  if (Name.isNotEmpty && ContactNumber.isNotEmpty) {
                    namecontroller.clear();
                    contactController.clear();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              addContacts(name: Name, number: ContactNumber)),
                    );
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
                    'Read Me - Before Uploading the Xlsx file.Check Column number for names and Contact number. By default, it is set to 1 & 2. If Nothing Happened, then your columns are empty.'),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
