import 'package:flutter/material.dart';
import 'package:vistas_amatista/custom_widgets/text_custom.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget{
  const CustomAppBar({
    super.key,
    this.title = '',
    this.icon,
    this.leading,
    this.titleWidget
  });

  final String title;
  final Widget? leading;
  final Widget? titleWidget;
  final IconData? icon;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(double.maxFinite, 60);
}

class _CustomAppBarState extends State<CustomAppBar> with SingleTickerProviderStateMixin{

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onPressed() {
    if (_animationController.isDismissed) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: AnimatedIcon(
                  icon: AnimatedIcons.menu_arrow,
                  size: 28,
                  progress: _animationController,
                ),
                onPressed: _onPressed, 
              ),
              TextCustomWidget(
                widget.title, 
                style: TextCustomWidget.sectionTitleStyle, 
                icon: widget.icon,
                // TODO: Econtrar una forma de hacer el tamaño del título responsivo.
                size: widget.title.length > 16? (widget.title.length > 18? 16 :20): null, 
                iconSize: 24,
              ),
              const SizedBox(width: 42,) 
            ],
          ),
        ],
      ),
    );
  }
}

