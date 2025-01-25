
  import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:pro_icon/Features/session_managment/session_setup/widgets/Session_setup_content.dart';


  class SessionSetupScreen extends StatelessWidget {
    static const routeName = '/session_setup';
    const SessionSetupScreen({super.key});




    @override
    Widget build(BuildContext context) {
      return const  SessionSetupContent();
    }
  }
