// import 'package:flutter/material.dart';

// class User {
//   final String name;
//   final String description;
//   final String imageUrl;

//   User(this.name, this.description, this.imageUrl);
// }

// class UsersListScreen extends StatelessWidget {
//   final Future<List<User>> users;
//   const UsersListScreen({super.key, required this.users});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: const Color(0xFF1D3557),
//           title: const Text("Стипендия «Молодой предприниматель» ФКН"),
//         ),
//         body: FutureBuilder(
//             future: users,
//             builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//               if (snapshot.hasData) {
//                 return ListView.builder(
//                   itemCount: snapshot.data.count,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: EdgeInsets.only(bottom: index < snapshot.data.count ? 5.0 : 0.0),
//                       child: 
//                     );
//                   },
//                 );
//               }
//             }));
//   }
// }
