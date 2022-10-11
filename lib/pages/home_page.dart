import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:objectbox_example/main.dart';
import 'package:objectbox_example/models/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Stream<List<User>> streamUsers;
  @override
  void initState() {
    streamUsers = objectBox.getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ObjectBox Example'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final user = User(
                name: Faker().person.name(), email: Faker().internet.email());
            objectBox.insertUser(user);
          },
          child: const Icon(Icons.add),
        ),
        body: StreamBuilder<List<User>>(
          stream: streamUsers,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final users = snapshot.data!;
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ListTile(
                    title: Text(user.name),
                    subtitle: Text(user.email),
                    trailing: IconButton(
                        onPressed: () {
                          objectBox.deleteUser(user.id);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                    onTap: () {
                      user.name = Faker().person.name();
                      user.email = Faker().internet.email();
                      objectBox.insertUser(user);
                    },
                  );
                },
              );
            }
          },
        ));
  }
}
