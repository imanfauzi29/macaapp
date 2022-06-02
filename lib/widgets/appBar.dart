import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaseAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Widget title;
  final Widget leading;
  final AppBar appBar;
  final List<Widget>? actions;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const BaseAppBar(
      {Key? key,
      required this.title,
      required this.leading,
      required this.appBar,
      this.actions,
      this.scaffoldKey})
      : super(key: key);

  @override
  State<BaseAppBar> createState() => _BaseAppBarState();

  @override
  Size get preferredSize {
    return const Size.fromHeight(50.0);
  }
}

class _BaseAppBarState extends State<BaseAppBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: widget.title,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shadowColor: Colors.transparent,
        leading: widget.leading,
        actions: widget.actions);
  }
}
