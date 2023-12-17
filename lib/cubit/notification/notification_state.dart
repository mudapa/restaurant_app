part of 'notification_cubit.dart';

sealed class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

final class NotificationInitial extends NotificationState {}

final class NotificationLoading extends NotificationState {}

final class NotificationActive extends NotificationState {
  final bool isNotificationActive;

  const NotificationActive(this.isNotificationActive);

  @override
  List<Object> get props => [isNotificationActive];
}

final class NotificationFailed extends NotificationState {
  final String error;

  const NotificationFailed(this.error);

  @override
  List<Object> get props => [error];
}
