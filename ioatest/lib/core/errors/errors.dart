import 'package:flutter/foundation.dart';

@immutable
abstract class Error {}

@immutable
class NoInternetError extends Error {}

@immutable
class RemoteError extends Error {}
