import 'package:flutter/material.dart';

void unfocus(BuildContext context) => FocusScope.of(context).unfocus();

// extension UnFocusExtesion on BuildContext {
//   void unfocus() => Focus.of(this).unfocus();
// }
