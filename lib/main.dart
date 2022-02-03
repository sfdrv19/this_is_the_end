import 'package:flutter/material.dart';
import 'package:this_is_the_end/drawer.dart';
import 'package:this_is_the_end/screens/details_screen.dart';
import 'package:this_is_the_end/screens/users_list_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) =>  const LockScreen(),
        '/second': (context) =>  const HomeScreen(),
        '/third': (context) => const Details(),
      },
    );
  }
}

class LockScreen extends StatefulWidget {
  const LockScreen({Key? key}) : super(key: key);

  @override
  _LockScreenState createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isVisible = false; //скрытое сообщение о неверных данных

  fetchCredentials() {
    //заданные лигин/пароль
    var username = "1234567890";
    var password = "муха";
    return [username, password];
  }

  @override
  Widget build(BuildContext context) {
    //стиль рамки полей ввода
    const borderStyle = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(36)),
        borderSide: BorderSide(color: Color(0xFF0079D0), width: 1.5));

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/bg.jpg'),
          fit: BoxFit.fill,
        )),
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 55),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              const SizedBox(
                width: 110,
                height: 84,
                child: Image(
                  image: AssetImage('assets/dart-logo.png'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Введите логин в виде 10 цифр номера телефона',
                style: TextStyle(
                    fontSize: 16, color: Color.fromRGBO(0, 0, 0, 0.6)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              //неверно введенные данные---------------------
              Visibility(
                visible: _isVisible,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    "неверные логин/пароль",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              //--------------------------------------------
              TextField(
                onTap: () {
                  setState(() {
                    _isVisible = false;
                  });
                },
                controller: usernameController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFeceff1),
                  enabledBorder: borderStyle,
                  focusedBorder: borderStyle,
                  labelText: 'Телефон',
                  hintText: 'Логин: 1234567890',
                ),
                onEditingComplete: () => FocusScope.of(context).nextFocus(),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                onTap: () {
                  setState(() {
                    _isVisible = false;
                  });
                },
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFeceff1),
                  enabledBorder: borderStyle,
                  focusedBorder: borderStyle,
                  labelText: 'Пароль',
                  hintText: 'Пароль: муха',
                ),
              ),
              const SizedBox(
                height: 28,
              ),
              SizedBox(
                  width: 154,
                  height: 42,
                  child: ElevatedButton(
                    onPressed: () {
                      if (usernameController.text == fetchCredentials()[0] &&
                          passwordController.text == fetchCredentials()[1]) {
                        Navigator.pushNamed(
                          context, '/second');

                      } else {
                        setState(() {
                          _isVisible = true;
                        });
                      }
                    },
                    child: const Text('Войти'),
                    style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF0079D0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22.0),
                        )),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        drawer: navDrawer(context),
        appBar: AppBar(
          title: const Text('Список пользователей'),
        ),
        body: const Center(
            child: UsersListScreen()
        ),

    );
  }
}

class Details extends StatelessWidget {
  const Details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      const Scaffold(
        body: Center(
            child: DetailsScreen(),
        ),
      )
    ;
  }
}
