import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:ttalk/const.dart';
import 'package:ttalk/servives/alert_services.dart';
import 'package:ttalk/servives/auth_service.dart';
import 'package:ttalk/servives/navigation_service.dart';
import 'package:ttalk/widgets/custom_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  final GetIt getIt = GetIt.instance;

  final GlobalKey<FormState> _loginFormKey = GlobalKey();


  late AuthService _authService;
  late NavigationService _navigationService ;
  late AlertServices _alertServices ;








  @override
  void initState() {
    super.initState();
    _authService = getIt.get<AuthService>();
    _navigationService = getIt.get<NavigationService>();
    _alertServices = getIt.get<AlertServices>();
  }


  String? email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20.0,
            ),
            child: Column(
              children: [
                _headerText(),
                _loginForm(),
              ],
            )));
  }

  Widget _headerText() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: const Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome back to T-Talk",
            style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w800,
                color: Color.fromARGB(255, 255, 255, 255)),
          ),
          Text(
            "Hello again",
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 208, 155, 155)),
          ),
        ],
      ),
    );
  }

  Widget _loginForm() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.1,
      ),
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomFormField(
              height: MediaQuery.of(context).size.height * 0.1,
              hintText: "Email",
              validationRegEx: EMAIL_VALIDATION_REGEX,
              onSaved: (value) => email = value,
            ),
            CustomFormField(
              height: MediaQuery.sizeOf(context).height * 0.1,
              hintText: "Password",
              obscureText: true,
              validationRegEx: PASSWORD_VALIDATION_REGEX,
              onSaved: (value) => password = value,
            ),
            _loginButton(),
            _createAnAccountLink(),
          ],
        ),
      ),
    );
  }

  Widget _loginButton() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: MaterialButton(
        onPressed: () async {
          if (_loginFormKey.currentState?.validate() ?? false) {
            _loginFormKey.currentState?.save();
            bool result = await _authService.login(email!, password!);
             

            // print(email);
            // print(password);

            print(result);

            if (result) {
              _navigationService.pushReplacementNamed("/home");
              _alertServices.showToast(text: "Logged In ") ;
            } else {
              _alertServices.showToast(text: "Login failed", 
              icon: Icons.error);
            }
          }
        },



        color: Theme.of(context).colorScheme.primary,
        child: Text(
          "Login",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w800,
            // color: Color.fromARGB(255, 64, 20, 239),
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }

  Widget _createAnAccountLink() {
    return Expanded(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
      const  Text("Don't have an account?"),
        GestureDetector(
          onTap: () {
            _navigationService.pushName("/register");
          },
          child: Text(
            "Sign up",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    ));
  }
}
