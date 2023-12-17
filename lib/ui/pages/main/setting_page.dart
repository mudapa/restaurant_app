import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/notification/notification_cubit.dart';
import '../../../shared/helper.dart';
import '../../../shared/style.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Theme',
              style: blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Dark Mode',
                  style: blackTextStyle.copyWith(
                    fontWeight: semiBold,
                  ),
                ),
                Switch.adaptive(
                  value: isDarkMode,
                  onChanged: (value) {
                    setState(() {
                      isDarkMode = value;
                    });

                    if (isDarkMode) {
                      toast(
                        'Dark Mode is On, but coming soon!',
                        orangeColor,
                      );
                    } else {
                      toast(
                        'Dark Mode is Off, but coming soon!',
                        orangeColor,
                      );
                    }
                  },
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 16),
            Text(
              'Notification',
              style: blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Restaurant Notification',
                      style: blackTextStyle.copyWith(
                        fontWeight: semiBold,
                      ),
                    ),
                    Text(
                      'Enable notification',
                      style: greyTextStyle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                BlocConsumer<NotificationCubit, NotificationState>(
                  listener: (context, state) {
                    if (state is NotificationActive) {
                      toast(
                        state.isNotificationActive
                            ? 'Notification is On'
                            : 'Notification is Off',
                        state.isNotificationActive ? greenColor : redColor,
                      );
                    }

                    if (state is NotificationFailed) {
                      toast(state.error, redColor);
                    }
                  },
                  builder: (context, state) {
                    return Switch.adaptive(
                      value: state is NotificationActive
                          ? state.isNotificationActive
                          : false,
                      onChanged: (value) {
                        context
                            .read<NotificationCubit>()
                            .toggleNotification(value);
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
