import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../services/notification_service.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  Future<void> toggleNotification(bool value) async {
    try {
      emit(NotificationLoading());
      final isActive = await NotificationService().toggleNotification(value);
      emit(NotificationActive(isActive));
    } catch (e) {
      emit(NotificationFailed(e.toString()));
    }
  }

  Future<bool> loadNotificationStatus() async {
    emit(NotificationLoading());

    try {
      final isActive = await NotificationService().loadReminderStatus();
      emit(NotificationActive(isActive));
      return isActive;
    } catch (e) {
      emit(NotificationFailed(e.toString()));
      return false;
    }
  }
}
