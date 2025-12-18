import 'package:demo/components/index.dart';
import 'package:demo/models/user_model.dart';
import 'package:demo/screens/about_screen.dart';
import 'package:demo/screens/chart_screen.dart';
import 'package:demo/screens/user_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  final Function(ThemeMode) onThemeChange;
  final ThemeMode currentMode;

  const HomePage({
    super.key,
    required this.onThemeChange,
    required this.currentMode,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  // Hive Box
  late Box<User> _userListBox;

  @override
  void initState() {
    super.initState();
    _userListBox = Hive.box<User>('user_list');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final user = User(
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        timestamp: DateTime.now(),
      );

      await _userListBox.add(user);

      if (mounted) {
        CustomSnackBar.show(context, message: 'User added successfully!');
        _nameController.clear();
        _emailController.clear();
        _phoneController.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: CustomColumn(
          children: [
            const SizedBox(height: 10),
            // 🔹 Custom Tab Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CommonTabBar(
                tabs: const ['Task', 'List'],
                backgroundColor: Theme.of(context).cardColor,
                indicatorColor: Colors.blueAccent,
                selectedColor: Colors.white,
                unselectedColor: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            
            // 🔹 Tab Views
            Expanded(
              child: TabBarView(
                children: [
                  // TAB 1: Task (Form Input)
                  _buildTaskTab(context),

                  // TAB 2: List (Navigation to User List)
                  _buildListTab(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= TAB 1: TASK (FORM) =================
  Widget _buildTaskTab(BuildContext context) {
    return CommonScrollView(
      padding: const EdgeInsets.all(24.0),
      child: CustomColumn(
        spacing: 30,
        children: [
          // 🔹 Dynamic Form Card
          CustomCard(
            padding: const EdgeInsets.all(24.0),
            child: CustomForm(
              formKey: _formKey,
              children: [
                CustomTextField(
                  controller: _nameController,
                  label: 'Name',
                  icon: Icons.person_outline,
                  validator: (value) => value!.isEmpty ? 'Enter Name' : null,
                ),
                CustomTextField(
                  controller: _emailController,
                  label: 'Email',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) =>
                      value!.contains('@') ? null : 'Enter valid email',
                ),
                CustomTextField(
                  controller: _phoneController,
                  label: 'Phone',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  validator: (value) =>
                      value!.length >= 10 ? null : 'Enter valid phone',
                ),
                CustomButton(
                  text: 'Submit',
                  onPressed: _submitForm,
                ),
              ],
            ),
          ),

          // Action Buttons
          CustomRow(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildActionButton(
                icon: Icons.list_alt,
                label: 'About',
                color: Colors.purple,
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const AboutScreen())),
              ),
              _buildActionButton(
                icon: Icons.layers,
                label: 'Sheet',
                color: Colors.green,
                onPressed: () {
                  CommonBottomSheet.show(
                      context: context, child: const Text("Sample Sheet"));
                },
              ),
              _buildActionButton(
                icon: Icons.pie_chart,
                label: 'Chart',
                color: Colors.orange,
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const ChartScreen())),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ================= TAB 2: LIST (USER LIST) =================
  Widget _buildListTab(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _userListBox.listenable(),
      builder: (context, Box<User> box, _) {
        // If no users, show dynamic navigation card
        if (box.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: CustomCard(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const UserListScreen()),
                  );
                },
                padding: const EdgeInsets.all(32.0),
                child: CustomColumn(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 16,
                  children: [
                    Icon(
                      Icons.people_outline,
                      size: 80,
                      color: Colors.grey[400],
                    ),
                    const CustomText(
                      'User List',
                      style: CustomTextStyle.heading,
                    ),
                    const CustomText(
                      'No users added yet',
                      style: CustomTextStyle.subtitle,
                    ),
                    const CustomText(
                      'Add users from the Task tab',
                      style: CustomTextStyle.label,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        // If users exist, show the list directly
        final users = box.values.toList();
        return CommonListView<User>(
          items: users,
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, user, index) {
            return CustomListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blueAccent,
                radius: 25,
                child: CustomText(
                  user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                  style: CustomTextStyle.heading,
                  color: Colors.white,
                ),
              ),
              title: user.name,
              subtitle: CustomColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                children: [
                  CustomRow(
                    spacing: 4,
                    children: [
                      const Icon(Icons.email, size: 14, color: Colors.grey),
                      Expanded(
                        child: CustomText(
                          user.email,
                          style: CustomTextStyle.subtitle,
                        ),
                      ),
                    ],
                  ),
                  CustomRow(
                    spacing: 4,
                    children: [
                      const Icon(Icons.phone, size: 14, color: Colors.grey),
                      CustomText(
                        user.phone,
                        style: CustomTextStyle.subtitle,
                      ),
                    ],
                  ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                onPressed: () {
                  _showDeleteConfirmation(context, user);
                },
              ),
            );
          },
        );
      },
    );
  }

  void _showDeleteConfirmation(BuildContext context, User user) {
    CommonAlert.show(
      context: context,
      title: 'Delete User',
      content: 'Are you sure you want to delete ${user.name}?',
      confirmText: 'Delete',
      cancelText: 'Cancel',
      onConfirm: () {
        user.delete();
        CustomSnackBar.show(context, message: '${user.name} deleted');
      },
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return CustomColumn(
      spacing: 8,
      children: [
        CustomIconButton(
          size: 50,
          icon: icon,
          color: color,
          onPressed: onPressed,
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        CustomText(label, style: CustomTextStyle.label, fontWeight: FontWeight.w500),
      ],
    );
  }
}