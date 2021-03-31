import 'package:contacts_app/contacts/final_page_route.dart';
import 'package:contacts_app/functions/functions.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class addContacts extends StatefulWidget {
  final List<String> name;
  final List<String> number;

  addContacts({@required this.name, @required this.number});

  @override
  _addContactsState createState() => _addContactsState();
}

class _addContactsState extends State<addContacts> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('List Of Contacts'),
            actions: [
              IconButton(
                  icon: Icon(Icons.add_box),
                  onPressed: () {
                    saveContacts(widget.name, widget.number, context);
                  })
            ],
          ),
          body: SingleChildScrollView(
            child: Column(children: [
              ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.name.length,
                itemBuilder: (BuildContext context, int index) {
                  return getContactCard(index);
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Card getContactCard(int index) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 5,
      child: ListTile(
        tileColor: Colors.white10,
        title: Text(widget.name[index]),
        subtitle: Text(widget.number[index]),
        trailing: IconButton(
          icon: Icon(CupertinoIcons.xmark),
          onPressed: () {
            widget.name.removeAt(index);
            setState(() {});
          },
        ),
      ),
    );
  }
}

Future saveContacts(
    List<String> name, List<String> contactNumber, BuildContext context) async {
  checkPermisson();
  try {
    if (name != null && contactNumber != null) {
      for (int i = 0; i < name.length; i++) {
        Contact contact = Contact();
        if (name[i] != null && contactNumber[i] != null) {
          CircularProgressIndicator();
          contact.givenName = name[i];
          contact.phones = [Item(label: "mobile", value: contactNumber[i])];
          await ContactsService.addContact(contact);
        }
      }
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return finalPage();
      }));
      // showModalBottomSheet(builder: (BuildContext context) {}, context: null);
    }
  } catch (e) {
    print(e);
  }
}
