import 'package:equatable/equatable.dart';

/// Base class for all states used in the blocs
abstract class BaseState<T> extends Equatable {
  final T? data;
  final DateTime? timestamp;

  const BaseState({
    this.data,
    this.timestamp,
  });

  @override
  List<Object?> get props => [
    data,
    timestamp,
  ];
}

/// Authentication State
class UnauthenticatedState<T> extends BaseState<T> {
  const UnauthenticatedState({
    super.timestamp,
    super.data,
  });

  @override
  String toString() {
    return 'UnauthenticationState { timestamp: $timestamp, data: $data }';
  }
}

class AuthenticatedState<T> extends BaseState<T> {
  const AuthenticatedState({
    super.timestamp,
    super.data,
  });

  @override
  String toString() {
    return 'AuthenticatedState { timestamp: $timestamp, data: $data }';
  }
}

/// Default state
///
/// Use it for initialization of the bloc
class InitializedState<T> extends BaseState<T> {
  const InitializedState({
    super.timestamp,
    super.data,
  });

  @override
  String toString() {
    return 'InitializeState { timestamp: $timestamp, data: $data }';
  }
}

/// Main loading state
///
/// If the screen loads multiple data and needs more than one loading state,
/// consider creating another micro loading state on the corresponding blocs
class LoadingState<T> extends BaseState<T> {
  const LoadingState({
    super.timestamp,
    super.data,
  });

  @override
  String toString() {
    return 'LoadingState { timestamp: $timestamp, data: $data }';
  }
}

/// Main success state for load data to the screen
///
/// If the screen loads multiple data and needs more than one loaded state,
/// consider creating another micro loaded state on the corresponding blocs
///
/// To indicate empty data, please consider use [EmptyState] instead of doing
/// length checking on this state.
class LoadedState<T> extends BaseState<T> {
  const LoadedState({
    super.timestamp,
    super.data,
  });

  @override
  String toString() {
    return 'LoadedState { timestamp: $timestamp, data: $data,}';
  }
}

/// Success state for action bloc
///
/// Don't use this state for blocs that responsible for loading data to the screen.
class SuccessState<T> extends BaseState<T> {
  const SuccessState({
    super.timestamp,
    super.data,
  });

  @override
  String toString() {
    return 'SuccessState { timestamp: $timestamp, data: $data,}';
  }
}

/// Main empty state
///
/// Use this state for indicate empty data if the data successfully loaded.
class EmptyState<T> extends BaseState<T> {
  const EmptyState({
    super.timestamp,
    super.data,
  });

  @override
  String toString() {
    return 'EmptyState { timestamp: $timestamp, data: $data }';
  }
}

/// Main error state
///
/// Use this state to indicate failure on every blocs.
///
/// If the screen loads multiple data and needs more than one error state,
/// consider creating another micro error state on the corresponding blocs
class ErrorState<T> extends BaseState<T> {
  /// Error message is enforced to be provided for UX clarity
  final String error;

  const ErrorState({
    required this.error,
    super.timestamp,
    super.data,
  });

  @override
  String toString() {
    return 'ErrorState { timestamp: $timestamp, data: $data }';
  }
}