import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:lottie/lottie.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  List<Contact> _contacts = [];
  bool _contactsLoaded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    try {
      Iterable<Contact> contacts = await ContactsService.getContacts();
      setState(() {
        _contacts = contacts.toList();
        _contactsLoaded = true;
      });
    } catch (e) {
      print("Failed to get contacts: $e");
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool submit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Theme.of(context).colorScheme.background,
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    'Contact Information',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Playball',
                    ),
                  ),
                ),
                Card(
                  color: Theme.of(context).colorScheme.primary,
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: Icon(Icons.phone),
                    title: Text('+94 112 345678'),
                    subtitle: Text('Tel: Cafe Location'),
                  ),
                ),
                Card(
                  color: Theme.of(context).colorScheme.primary,
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: Icon(Icons.email),
                    title: Text('coffeecove@gmail.com'),
                    subtitle: Text('Email'),
                  ),
                ),
                Card(
                  color: Theme.of(context).colorScheme.primary,
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: Icon(Icons.email),
                    title: Text('coffeecoveho@gmail.com'),
                    subtitle: Text('Email: Head Office'),
                  ),
                ),
                SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    'Contact Form',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Playball',
                    ),
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Contact Type',
                    border: OutlineInputBorder(),
                  ),
                  items: <String>['Order Status', 'Sales Enquiry', 'General']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {},
                ),
                SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Message',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                ),
                SizedBox(height: 16),
                Center(
                  child: GestureDetector(
                    onTap: (){
                      if (submit == false) {
                        submit = true;
                        _controller.forward();
                      } else {
                        submit= false;
                        _controller.reverse();
                      }
                    },
                    child: Lottie.network(
                      'https://lottie.host/c158484b-f7ff-4cc5-ac7a-1e3b980d4249/jw3pcM70mc.json',
                      width: 150,
                      controller: _controller,
                    ),
                  ),
                ),
                SizedBox(height: 32),
                _contactsLoaded
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _contacts.map((contact) {
                          return Card(
                            color: Theme.of(context).colorScheme.primary,
                            elevation: 4,
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              leading: Icon(Icons.contact_phone),
                              title: Text(contact.displayName ?? 'No Name'),
                              subtitle: Text(
                                contact.phones!.isNotEmpty
                                    ? contact.phones!.first.value!
                                    : 'No Phone Number',
                              ),
                            ),
                          );
                        }).toList(),
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
