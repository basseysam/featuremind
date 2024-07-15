import 'package:flutter/material.dart';

import '../errors/failures.dart';
import '../extras.dart';
import '../utils/app_snackbar.dart';

enum NotifierStatus { loading, idle, done, error }

class NotifierState<T> {
  final T? data;
  final int? statusCode;
  final NotifierStatus status;
  final String? message;
  final Failure? failure;
  final bool noAuth;

  const NotifierState({
    this.data,
    this.status = NotifierStatus.idle,
    this.message,
    this.failure,
    this.statusCode,
    this.noAuth = false,
  });

  Widget when({
    required Widget Function(T? data) done,
    Widget Function(String? message)? error,
    Widget Function(T? data)? loading,
    Widget Function()? idle,
  }) {
    switch (status) {
      case NotifierStatus.loading:
        {
          if (loading == null) {
            return done(data);
          }
          return loading(data);
        }
      case NotifierStatus.idle:
        {
          if (idle == null) {
            return done(data);
          }
          return idle();
        }
      case NotifierStatus.done:
        {
          return done(data);
        }
      case NotifierStatus.error:
        {
          if (error == null) {
            return done(data);
          }
          return error(message);
        }
    }
  }

  @override
  String toString() {
    return 'NotifierState{data: $data, statusCode: $statusCode, status: $status, message: $message, failure: $failure, noAuth: $noAuth}';
  }
}

NotifierState<T> notifyRight<T>(
    {required T? data, String? message, int? statusCode}) {
  return NotifierState<T>(
    status: NotifierStatus.done,
    message: message,
    statusCode: statusCode,
    data: data,
  );
}

NotifierState<T> notifyError<T>(
    {required String error, bool noAuth = false, Failure? failure}) {
  return NotifierState<T>(
    status: NotifierStatus.error,
    message: error,
    noAuth: noAuth,
    failure: failure,
  );
}

NotifierState<T> notifyLoading<T>([T? data]) {
  return NotifierState(status: NotifierStatus.loading, data: data);
}

NotifierState<T> notifyIdle<T>([T? data]) {
  return NotifierState(status: NotifierStatus.idle, data: data);
}

class ProcessProviderState<T> {
  static void run<T>(
    NotifierState<T> state, {
    Function(T?)? onSuccessCallback,
    Function(String?)? onErrorCallBack,
    required BuildContext context,
    bool showSuccessMessage = false,
    bool showErrorPopUp = false,
    bool checkNoAuth = true,
  }) {
    processNotifierState<T>(state,
        onSuccessCallback: onSuccessCallback,
        onError: onErrorCallBack,
        context: context,
        showSuccessMessage: showSuccessMessage,
        showErrorPopUp: showErrorPopUp,
        checkNoAuth: checkNoAuth);
  }

  static void processNotifierState<T>(
    NotifierState<T> state, {
    Function(T?)? onSuccessCallback,
    Function(String?)? onError,
    bool showSuccessMessage = false,
    bool showErrorPopUp = false,
    required BuildContext context,
    bool checkNoAuth = true,
  }) {
    if (state.status == NotifierStatus.done) {
      if (onSuccessCallback != null) onSuccessCallback(state.data);
      if (showSuccessMessage) showToast(state.message!, context);
    } else if (state.status == NotifierStatus.error) {
      onStateError(state,
          onError: onError,
          context: context,
          showErrorPopUp: showErrorPopUp,
          checkNoAuth: checkNoAuth);
    }
  }

  static onStateError<T>(
    NotifierState<T> stateClass, {
    Function(String?)? onError,
    required BuildContext context,
    bool showErrorPopUp = false,
    bool checkNoAuth = true,
  }) {
    if (onError != null) onError(stateClass.message);
    if (stateClass.noAuth && checkNoAuth) {
      return showErrorToast(stateClass.message!, context);
    }
  }
}
