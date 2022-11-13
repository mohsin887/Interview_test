import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:interview/data/mock_data.dart';
import 'package:interview/data/user.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(_filterList);
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  var users = User.fromJsonToList(allData());
  var newUser = User(
      id: "b32ec56c-21bb-4b7b-a3a0-635b8bca1f9d",
      avatar: null,
      firstName: "James",
      lastName: "May",
      email: "ssaull1c@tripod.com",
      role: "Developer");

  _filterList() {
    users = User.fromJsonToList(allData()).where((user) {
      var firstName = user.firstName.toLowerCase();
      var lastName = user.lastName.toLowerCase();
      var role = user.role.toLowerCase();
      var email = user.email.toLowerCase();
      return firstName.contains(searchController.text) ||
          lastName.contains(searchController.text) ||
          role.contains(searchController.text) ||
          email.contains(searchController.text);
    }).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title ?? ''),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.blue,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Flexible(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final item = users[index];
                return ListTile(
                  leading: ImageWidget(url: item.avatar ?? ''),
                  title: Text(
                      users[index].firstName + ' ' + users[index].lastName),
                  subtitle: Text(users[index].role),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          users.add(newUser);
          setState(() {
            users = users;
          });
        },
        tooltip: 'Add new',
        child: Icon(Icons.add),
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  final String url;
  const ImageWidget({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return url == ''
        ? FaIcon(FontAwesomeIcons.image)
        : CircleAvatar(backgroundImage: NetworkImage(url));
  }
}
