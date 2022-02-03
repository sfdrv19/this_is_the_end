import 'dart:async';
import 'dart:convert';
import '../user_class.dart';
import '../utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


Future<List<User>> _fetchUsersList() async {
  final response = await http.get(Uri.parse(URL_GET_USERS_LIST));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((user) => User.fromJson(user)).toList();
  } else {
    throw Exception('Failed to load users from API');
  }
}

ListView _usersListView(data) {
  return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return _userListTile(
            context,
            data[index].id,
            data[index].name,
            data[index].email,
            Icons.work
        );
      });
}

int _listItemSelected = -1;

ListTile _userListTile(context, int id, String title,
    String subtitle, IconData icon) => ListTile(
        title: Text(
            id.toString() + ' ' + title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
        subtitle: Text(subtitle),
        leading: Icon(
        icon,
        color: Colors.blue[500],
         ),
        selectedTileColor: Theme.of(context).primaryColor.withOpacity(0.25),
        selected: id == _listItemSelected,
        onTap: () {
            _listItemSelected = id;
            Navigator.pushNamed(context, '/third', arguments: id);
            },
    );

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({Key? key}) : super(key: key);

  @override
  _UsersListScreenState createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  late Future<List<User>> futureUsersList;
  late List<User> usersListData;

  @override
  void initState() {
    super.initState();
    futureUsersList = _fetchUsersList();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FutureBuilder<List<User>>(
        future: futureUsersList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            usersListData = snapshot.data!;
            return _usersListView(usersListData);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          return const CircularProgressIndicator();
        })
    );
  }
}
