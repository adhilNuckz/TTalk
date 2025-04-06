import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ttalk/servives/alert_services.dart';
import 'package:ttalk/servives/auth_service.dart';
import 'package:ttalk/servives/navigation_service.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final GetIt _getIt = GetIt.instance;

  late AuthService _authService;
  late NavigationService _navigationService;
  late AlertServices _alertServices;

  @override
  void initState() {
    super.initState();

    _authService = _getIt.get<AuthService>();
    _navigationService = _getIt.get<NavigationService>();
    _alertServices = _getIt.get<AlertServices>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 203, 177, 48),
      appBar: AppBar(
        title: const Text("Area 52"),
        backgroundColor: const Color.fromARGB(255, 203, 177, 48),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            color: Colors.red,
            onPressed: () async {
              bool result = await _authService.logout();

              if (result) {
                _alertServices.showToast(
                  text: "Logout successful",
                  icon: Icons.check_circle,
                );
              } else {
                _alertServices.showToast(
                  text: "Logout failed",
                  icon: Icons.check_circle,
                );
              }

              if (result) {
                _navigationService.pushReplacementNamed("/login");
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Logout failed"),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: _chatList(),
      ),
    );
  }

  Widget _chatList() {
    return Container();
  }
}
