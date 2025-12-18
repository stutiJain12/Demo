import 'package:demo/models/user_model.dart';
import 'package:demo/components/index.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'User List'),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<User>('user_list').listenable(),
        builder: (context, Box<User> box, _) {
          final users = box.values.toList();

          return CommonListView<User>(
            items: users,
            emptyMessage: 'No users added yet',
            emptyIcon: Icons.people_outline,
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
                trailing: CustomIconButton(
                  icon: Icons.delete_outline,
                  color: Colors.redAccent,
                  onPressed: () {
                    _showDeleteConfirmation(context, user, index);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, User user, int index) {
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
}
