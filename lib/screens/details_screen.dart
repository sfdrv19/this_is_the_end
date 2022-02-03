import 'package:flutter/material.dart';
import '../drawer.dart';
import '../user_class.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    int userID = ModalRoute.of(context)!.settings.arguments as int;

    return TaskScreen(userID: userID);
  }
}


class TaskScreen extends StatefulWidget {
  final int userID;
  const TaskScreen({Key? key, required this.userID}) : super(key: key);


  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {

  late Future<User> _futureUser;
  late Future<TaskList> _futureTaskList;


  @override
  void initState() {
    super.initState();
    _futureUser = fetchSingleUser(widget.userID);
    _futureTaskList = fetchTaskList(widget.userID);
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Подробности'),
          actions: <Widget>[
            TextButton(onPressed: () {
                Navigator.pushNamed(context, '/second');
                },
                child: const Text('НАЗАД   '),
                style: TextButton.styleFrom(
                    primary: Theme.of(context).colorScheme.onPrimary)
            )
          ],
        ),
        drawer: navDrawer(context),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                FutureBuilder<User>(
                    future: _futureUser,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return snapshot.data!.userWidget(context);
                      } else if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      }
                      return const CircularProgressIndicator();
                    }
                ),
                const SizedBox(height: 5),
                Text("Список задач:", style: Theme.of(context).textTheme.headline6),
                FutureBuilder<TaskList>(
                    future: _futureTaskList,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Flexible(
                          child: ListView.separated(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(8),
                            itemCount: snapshot.data!.items.length,
                            itemBuilder:(BuildContext context, int index) {
                              return Container(
                                height: 50,
                                color: Theme.of(context).primaryColor.withOpacity(0.25),
                                child: ListTile(
                                  title: Row(
                                    children: [
                                      Expanded(
                                          flex: 4,
                                          child: Text(snapshot.data!.items[index].title, style: Theme.of(context).textTheme.bodyText1,)
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Checkbox(
                                          value: snapshot.data!.items[index].completed,
                                          onChanged: (bool? value) {},
                                        ),

                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) => const Divider(),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      }
                      return const CircularProgressIndicator();
                    }
                ),
              ],
            ),
          ),
        ),
      );
  }
}
