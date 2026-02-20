import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/state/appState.dart';
import 'package:flutter_twitter_clone/ui/theme/theme.dart';
import 'package:flutter_twitter_clone/widgets/bottomMenuBar/tabItem.dart';
import 'package:provider/provider.dart';

import '../customWidgets.dart';

class BottomMenubar extends StatefulWidget {
  const BottomMenubar({
    Key? key,
  });
  @override
  _BottomMenubarState createState() => _BottomMenubarState();
}

class _BottomMenubarState extends State<BottomMenubar> {
  @override
  void initState() {
    super.initState();
  }

  Widget _iconRow() {
    var state = Provider.of<AppState>(
      context,
    );
    return Container(
      height: 50,
      decoration: BoxDecoration(
          // Color(0xff0898af).withOpacity(0.4),
          color: 0 == state.pageIndex ? Color(0xff0898af).withOpacity(0.53) : 1 == state.pageIndex ? Color(0xff0898af).withOpacity(0.53) : Colors.white,
            // gradient: LinearGradient(
            //   colors: [
            //     0 == state.pageIndex ? Color(0xff0898af) : 1 == state.pageIndex ? Color(0xff0898af) : Colors.white,
            //     0 == state.pageIndex ? Color(0xff7bd859):  1 == state.pageIndex ? Color(0xff7bd859): Colors.white,
            //   ],
            //   begin: Alignment.centerLeft,
            //   end: Alignment.centerRight,
            // ),

          // color: Theme.of(context).bottomAppBarTheme.color,
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, -.1), blurRadius: 0)
          ]),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _icon(null, 0,
              icon: 0 == state.pageIndex ?  CupertinoIcons.home : CupertinoIcons.home,
              isCustomIcon: true,
          ),
          _icon(null, 1,
              icon: 1 == state.pageIndex ? CupertinoIcons.search : CupertinoIcons.search,
              isCustomIcon: true),
          _icon(null, 2,
              icon: 2 == state.pageIndex ? CupertinoIcons.chat_bubble_2_fill : CupertinoIcons.chat_bubble_2,
              isCustomIcon: true),
          _icon(null, 3,
              icon: 3 == state.pageIndex ? CupertinoIcons.map_pin_ellipse : CupertinoIcons.map_pin_ellipse,
              isCustomIcon: true),
          _icon(null, 4,
              icon: 4 == state.pageIndex ? CupertinoIcons.bell_fill : CupertinoIcons.bell,
              isCustomIcon: true),
          _icon(null, 5,
              icon: 5 == state.pageIndex
                  ? CupertinoIcons.mail_solid
                  : CupertinoIcons.mail,
              isCustomIcon: true),
        ],
      ),
    );
  }

  Widget _icon(IconData? iconData, int index,
      {bool isCustomIcon = false, IconData? icon}) {
    if (isCustomIcon) {
      assert(icon != null);
    } else {
      assert(iconData != null);
    }
    var state = Provider.of<AppState>(
      context,
    );
    return Expanded(
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: AnimatedAlign(
          duration: const Duration(milliseconds: ANIM_DURATION),
          curve: Curves.easeIn,
          alignment: const Alignment(0, ICON_ON),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: ANIM_DURATION),
            opacity: ALPHA_ON,
            child: IconButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              padding: const EdgeInsets.all(0),
              alignment: const Alignment(0, 0),
              icon: isCustomIcon
                  ? customIcon(context,
                      icon: icon!,
                      size: 22,
                      isTwitterIcon: true,
                      isEnable: index == state.pageIndex)
                  : Icon(
                      iconData,
                      color: index == state.pageIndex
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).textTheme.bodySmall!.color,
                    ),
              onPressed: () {
                setState(() {
                  state.setPageIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _iconRow();
  }
}
