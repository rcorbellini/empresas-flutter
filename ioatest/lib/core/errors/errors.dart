import 'package:flutter/foundation.dart';

///Default error of system
@immutable
abstract class Error {}

///Default error when try use internet and no internet founded.
@immutable
class NoInternetError extends Error {}

///Default error for any request. (non 200 code)
@immutable
class RemoteError extends Error {}

///Error for 401 status code
@immutable
class UnauthorizedError extends RemoteError {}
