import 'package:bliss/screens/Loginscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:bliss/screens/Drawer/my_drawer_header.dart';

import 'package:bliss/screens/Drawer/contacts.dart';
import 'package:bliss/screens/Drawer/dashboard.dart';
import 'package:bliss/screens/Drawer/events.dart';
import 'package:bliss/screens/Drawer/my_drawer_header.dart';
import 'package:bliss/screens/Drawer/notes.dart';
import 'package:bliss/screens/Drawer/notifications.dart';
import 'package:bliss/screens/Drawer/settings.dart';
import 'package:bliss/screens/Drawer/privacy_policy.dart';
import 'package:bliss/screens/Drawer/send_feedback.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentPage = DrawerSections.dashboard;

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.dashboard) {
      container = DashboardPage();
    } else if (currentPage == DrawerSections.contacts) {
      container = ContactsPage();
    } else if (currentPage == DrawerSections.events) {
      container = EventsPage();
    } else if (currentPage == DrawerSections.notes) {
      container = NotesPage();
    } else if (currentPage == DrawerSections.settings) {
      container = SettingsPage();
    } else if (currentPage == DrawerSections.notifications) {
      container = NotificationsPage();
    } else if (currentPage == DrawerSections.privacy_policy) {
      container = PrivacyPolicyPage();
    } else if (currentPage == DrawerSections.send_feedback) {
      container = SendFeedbackPage();
    }
 // to take user information 
    final user =FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),



// to display user information
      body: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi,Umair',
                 style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'How do you feel ?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                   Icon(
                    Icons.more_horiz,
                    color: Colors.white,
                  ),
                ],
              ),

              SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //badly
                  Column(
                    children: <Widget>[
                      GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,MaterialPageRoute(builder: (context) => Loginscreen())
                        );  
                      },
                      child: Text('😩'),
                      ),

                      SizedBox(height: 8),

                      Text(
                        'Bad',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),

                  //fine
                  Column(
                    children: <Widget>[
                      GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,MaterialPageRoute(builder: (context) => Loginscreen())
                        );  
                      },
                      child: Text('🙂'),
                      ),
                      
                      SizedBox(height: 8),

                      Text(
                        'Fine',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),

                  //well
                  Column(
                    children: <Widget>[
                      GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,MaterialPageRoute(builder: (context) => Loginscreen())
                        );  
                      },
                      child: Text('😄'),
                      ),
        
                    SizedBox(height: 8),

                    Text('Well',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),

                  //excellent
                  Column(
                    children: <Widget>[
                      GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,MaterialPageRoute(builder: (context) => Loginscreen())
                        );  
                      },
                      child: Text('🤩'),
                      ),

                      SizedBox(height: 8),

                      Text(
                        'Excellent',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
          Text(
            'Signed in as',
            style: TextStyle(fontSize: 16),
          ),
          
          SizedBox(height: 8),

          Text(
            user.email!,
            style: TextStyle(fontSize: 20),
          ),

          SizedBox(height: 40),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              minWidth: double.infinity,
                onPressed: () => FirebaseAuth.instance.signOut(),
                child: Text('Sign Out'),
                color: Colors.teal,
                textColor: Colors.white,
            ),
          ),
        ],),
      ),

      // Drawer

      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyHeaderDrawer(),
                MyDrawerList(),
              ],
            ),
          ),
        ),
      ),

      

      // Bottom navigation bar 
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: ''),
        ],
      ),
    );
  }
  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Dashboard", Icons.dashboard_outlined,
              currentPage == DrawerSections.dashboard ? true : false),
          menuItem(2, "Contacts", Icons.people_alt_outlined,
              currentPage == DrawerSections.contacts ? true : false),
          menuItem(3, "Events", Icons.event,
              currentPage == DrawerSections.events ? true : false),
          menuItem(4, "Notes", Icons.notes,
              currentPage == DrawerSections.notes ? true : false),
          Divider(),
          menuItem(5, "Settings", Icons.settings_outlined,
              currentPage == DrawerSections.settings ? true : false),
          menuItem(6, "Notifications", Icons.notifications_outlined,
              currentPage == DrawerSections.notifications ? true : false),
          Divider(),
          menuItem(7, "Privacy policy", Icons.privacy_tip_outlined,
              currentPage == DrawerSections.privacy_policy ? true : false),
          menuItem(8, "Send feedback", Icons.feedback_outlined,
              currentPage == DrawerSections.send_feedback ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.dashboard;
            } else if (id == 2) {
              currentPage = DrawerSections.contacts;
            } else if (id == 3) {
              currentPage = DrawerSections.events;
            } else if (id == 4) {
              currentPage = DrawerSections.notes;
            } else if (id == 5) {
              currentPage = DrawerSections.settings;
            } else if (id == 6) {
              currentPage = DrawerSections.notifications;
            } else if (id == 7) {
              currentPage = DrawerSections.privacy_policy;
            } else if (id == 8) {
              currentPage = DrawerSections.send_feedback;
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

enum DrawerSections {
  dashboard,
  contacts,
  events,
  notes,
  settings,
  notifications,
  privacy_policy,
  send_feedback,
}


  