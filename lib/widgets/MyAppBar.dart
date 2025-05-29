import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget{ //cari tahu preferredsizewidget
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;
  final VoidCallback? onBackPressed;

  const MyAppBar({
    Key? key,
    required this.title, //kudu terisi ya gan
    this.actions,
    required this.showBackButton,
    this.onBackPressed
  }) : super(key: key):

  @override
  widget build(BuildContext context){
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color.white,
        ),
      ),
      centerTitle: True,
      backgroundColor: Colors.blueAccent,
      elevation: 0,
      leading: showBackButton ? IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white
        ),
        onPressed: onBackPressed ?? () => Navigator.pop(
          context
        ),
      )
      : null,
      actions: actions,
    );
  }

  @override
  Size get PreferredSize => Size.fromHeight(kToolbarHeight);
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();

}

