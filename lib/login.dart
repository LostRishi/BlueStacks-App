import 'package:flutter/material.dart';
import 'controller/auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool btnEnabled = false;
  bool isHiddenPassword = true;

  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Map<String, String> credentials = {
    '9898989898': 'password123',
    '9876543210': 'password123'
  };

  void validate() {
    if (formKey.currentState!.validate()) {
      setState(() {
        btnEnabled = true;
      });
      print("Vaidated");
    } else {
      setState(() {
        btnEnabled = false;
      });
      print("Not Vaidated");
    }
  }

  String? validateUsername(value) {
    if (value.isEmpty) {
      btnEnabled = false;
      return "* Required";
    } else if (value.length < 3) {
      btnEnabled = false;
      // print(
      //     "Login Button while entering username in wrong format is: $userNameBtnEnabled");
      return "Username should be atleast 3 characters";
    } else if (value.length > 11) {
      btnEnabled = false;
      return "Username should not be greater than 11 characters";
    }
    btnEnabled = true;
    // setState(() => this._btnEnabled = !_btnEnabled);
    // print(
    //     "Login Button while entering username in correct format is: $userNameBtnEnabled");
    return null;
  }

  String? validatePassword(value) {
    if (value.isEmpty) {
      btnEnabled = false;
      return "* Required";
    } else if (value.length < 3) {
      btnEnabled = false;
      // print(
      //     "Login Button while entering password in wrong format is: $passwordBtnEnabled");
      return "Password should be atleast 3 characters";
    } else if (value.length > 11) {
      btnEnabled = false;
      return "Password should not be greater than 11 characters";
    }
    // setState(() => this._btnEnabled = !_btnEnabled);
    btnEnabled = true;
    // print(
    //     "Login Button while entering password in correct format is: $passwordBtnEnabled");
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("game.TV"),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Builder(
        builder: (ctx) => Padding(
          padding: EdgeInsets.all(25.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    "image.png",
                    scale: 2,
                  ),
                  SizedBox(height: 30),
                  Container(
                    child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            TextFormField(
                              controller: usernameController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              // autovalidate: true,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Username"),
                              validator: validateUsername,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 20.0,
                              ),
                              child: TextFormField(
                                controller: passwordController,
                                obscureText: isHiddenPassword,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                // autovalidate: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Password",
                                  suffixIcon: InkWell(
                                    onTap: _togglePasswordView,
                                    child: Icon(
                                      isHiddenPassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                  ),
                                ),
                                validator: validatePassword,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 20.0,
                              ),
                              child: RaisedButton(
                                color: Colors.orangeAccent,
                                onPressed: () {
                                  String username = usernameController.text;
                                  String password = passwordController.text;
                                  if (credentials.containsKey(username) &&
                                      credentials[username] == password) {
                                    // AuthController.login({username: password});
                                    AuthController.login(username);
                                    Navigator.pushNamed(context, 'userdetails');
                                  } else {
                                    Scaffold.of(ctx).showSnackBar(SnackBar(
                                      content: Text(
                                          'Please enter correct username/password'),
                                    ));
                                  }
                                },
                                child: Text("Login"),
                              ),
                            )
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }
}
