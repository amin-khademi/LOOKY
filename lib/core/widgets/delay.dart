part of 'widgets.dart';

void delay(final int milliseconds, final VoidCallback action) async =>
    Future<dynamic>.delayed(
      Duration(milliseconds: milliseconds),
      () async => action(),
    );
