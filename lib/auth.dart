import 'package:flutter/material.dart';
 import 'chat_members.dart'; // Assuming you have the MembersListPage widget defined in 'chat_members.dart'
 import 'chat.dart'; // Assuming you have the ChatPage widget defined in 'chat.dart'

 class AuthScreen extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
     // Assuming you have some method to get the user
     String user = "User"; // Replace with actual user retrieval logic

     return Scaffold(
       appBar: AppBar(
         title: Text('Welcome to Chat App'),
         backgroundColor: Colors.blueAccent,
         elevation: 0, // Remove elevation for a cleaner look
       ),
       body: Container(
         decoration: BoxDecoration(
           gradient: LinearGradient(
             begin: Alignment.topCenter,
             end: Alignment.bottomCenter,
             colors: [Colors.blueAccent, Colors.blue[900]!],
           ),
         ),
        child: Center(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Text(
                 'Chat App',
                 style: TextStyle(
                   fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                 ),
               ),
               SizedBox(height: 20.0),
               Container(
                 width: 200.0,
                 height: 50.0,
                 child: ElevatedButton(
                   onPressed: () {
                     Navigator.of(context).push(
                       MaterialPageRoute(
                         builder: (context) => MembersListPage(user: user), // Pass 'user' parameter to MembersListPage
                       ),
                     );
                   },
                   style: ButtonStyle(
                     backgroundColor: MaterialStateProperty.all(Colors.white),
                     foregroundColor: MaterialStateProperty.all(Colors.blueAccent),
                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                       RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(25.0),
                       ),
                     ),
                   ),
                   child: Text(
                    'Start Chatting',
                     style: TextStyle(
                       fontSize: 18.0,
                     ),
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