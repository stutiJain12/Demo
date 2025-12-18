import 'dart:convert';
import 'package:demo/components/index.dart';
import 'package:demo/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class User {
  final String id;
  final String name;
  final String username;
  final String email;
  final String phone;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? 'N/A',
      username: json['username'] ?? 'N/A',
      // MockAPI specifically uses 'EmailId' in the provided schema
      email: json['EmailId'] ?? json['email'] ?? 'N/A',
      phone: json['phone'] ?? 'N/A',
    );
  }
}

class DataFetchScreen extends StatefulWidget {
  const DataFetchScreen({super.key});

  @override
  State<DataFetchScreen> createState() => _DataFetchScreenState();
}

class _DataFetchScreenState extends State<DataFetchScreen> {
  List<User> users = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final response = await http.get(Uri.parse(AppConstants.usersEndpoint));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        setState(() {
          // Sort by latest (MockAPI appends to the end, so we reverse it)
          users = data.map((e) => User.fromJson(e)).toList().reversed.toList();
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load data (Status: ${response.statusCode})';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  Future<void> addUser(String firstName, String lastName, String email) async {
    CommonLoader.show(context, message: 'Adding User...');
    try {
      final response = await http.post(
        Uri.parse(AppConstants.addUserEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': '$firstName $lastName'.trim(),
          'EmailId': email,
          'username': firstName.toLowerCase(),
          'phone': '123-456-7890'
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final newUser = User.fromJson(json.decode(response.body));
        setState(() {
          users.insert(0, newUser);
        });
        if (mounted) {
          CustomSnackBar.show(context, message: 'User added successfully');
        }
      }
    } catch (e) {
      if (mounted) {
        CustomSnackBar.show(context, message: 'Error adding user: $e', isError: true);
      }
    } finally {
      CommonLoader.hide(context);
    }
  }

  Future<void> deleteUser(String id, int index) async {
    CommonLoader.show(context, message: 'Deleting User...');
    try {
      final response =
          await http.delete(Uri.parse(AppConstants.userDetailEndpoint(id)));

      if (response.statusCode == 200) {
        setState(() {
          users.removeAt(index);
        });
        if (mounted) {
          CustomSnackBar.show(context, message: 'User deleted successfully');
        }
      }
    } catch (e) {
      if (mounted) {
        CustomSnackBar.show(context, message: 'Error deleting user: $e', isError: true);
      }
    } finally {
      CommonLoader.hide(context);
    }
  }

  void _showAddUserDialog() {
    final firstCtrl = TextEditingController();
    final lastCtrl = TextEditingController();
    final emailCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const CustomText('Add New User',
            style: CustomTextStyle.heading, textAlign: TextAlign.center),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: CustomForm(
              children: [
                CustomTextField(
                  controller: firstCtrl,
                  label: 'First Name',
                  icon: Icons.person_outline,
                ),
                CustomTextField(
                  controller: lastCtrl,
                  label: 'Last Name',
                  icon: Icons.person_outline,
                ),
                CustomTextField(
                  controller: emailCtrl,
                  label: 'Email',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),
              ],
            ),
          ),
        ),
        actions: [
          CustomRow(
            spacing: 12,
            children: [
              Expanded(
                child: CustomButton(
                  text: 'Cancel',
                  color: Colors.grey,
                  onPressed: () => Navigator.pop(ctx),
                ),
              ),
              Expanded(
                child: CustomButton(
                  text: 'Add',
                  onPressed: () {
                    if (firstCtrl.text.isNotEmpty && emailCtrl.text.isNotEmpty) {
                      addUser(firstCtrl.text, lastCtrl.text, emailCtrl.text);
                      Navigator.pop(ctx);
                    } else {
                      CustomSnackBar.show(context,
                          message: 'Please fill required fields', isError: true);
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'API Data Management',
        actions: [
          CustomIconButton(
            icon: Icons.person_add,
            onPressed: _showAddUserDialog,
          ),
          CustomIconButton(
            icon: Icons.refresh,
            onPressed: fetchUsers,
          ),
        ],
      ),
      body: isLoading
          ? const CommonLoader(message: 'Fetching Data...')
          : errorMessage != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                  child: CustomColumn(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 20,
                    children: [
                      const Icon(Icons.error_outline, size: 64, color: Colors.red),
                      CustomText(
                        errorMessage!,
                        style: CustomTextStyle.body,
                        color: Colors.red,
                        textAlign: TextAlign.center,
                      ),
                      CustomButton(
                        text: 'Retry',
                        onPressed: fetchUsers,
                        width: 150,
                      ),
                    ],
                  ),
                  ),
                )
              : CommonListView<User>(
                  items: users,
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (context, user, index) {
                    return CustomListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: CustomText(
                          user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                          style: CustomTextStyle.bodyBold,
                          color: Colors.white,
                        ),
                      ),
                      title: user.name,
                      subtitle: CustomText(user.email, style: CustomTextStyle.subtitle),
                      trailing: CustomIconButton(
                        icon: Icons.delete,
                        color: Colors.redAccent,
                        onPressed: () => deleteUser(user.id, index),
                      ),
                      onTap: () {
                        CommonAlert.show(
                          context: context,
                          title: 'User Details',
                          child: CustomColumn(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 8,
                            children: [
                              CustomText('ID: ${user.id}',
                                  style: CustomTextStyle.bodyBold),
                              CustomText('Name: ${user.name}',
                                  style: CustomTextStyle.body),
                              CustomText('Username: ${user.username}',
                                  style: CustomTextStyle.body),
                              CustomText('Email: ${user.email}',
                                  style: CustomTextStyle.body),
                              CustomText('Phone: ${user.phone}',
                                  style: CustomTextStyle.body),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
    );
  }
}
