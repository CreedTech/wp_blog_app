import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wp_blog_app/components/component_style.dart';
import 'package:wp_blog_app/components/component_theme.dart';
import 'package:wp_blog_app/const_values.dart';
import 'package:wp_blog_app/providers/theme_provider.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _theme = true;
  Future<void>? _launched;

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication,)) {
      throw Exception('Could not launch $url');
    }
  }

  // Future<void> launchUrl(String url) async {
  //   final canLaunch = await canLaunchUrl(Uri.parse(url));
  //   await launchUrl('www.ggogle.com');
  //   // if (TargetPlatform.android) {
  //   //   if (url.startsWith("https://www.facebook.com/")) {
  //   //     final url2 = "fb://facewebmodal/f?href=$url";
  //   //     final intent2 = AndroidIntent(action: "action_view", data: url2);
  //   //     final canWork = await intent2.canResolveActivity();
  //   //     if (canWork) return intent2.launch();
  //   //   }
  //   //   final intent = AndroidIntent(action: "action_view", data: url);
  //   //   return intent.launch();
  //   // } else {
  //   //   if (canLaunch) {
  //   //     await launchUrl(url);
  //   //   } else {
  //   //     throw "Could not launch $url";
  //   //   }
  //   // }
  // }

  @override
  Widget build(BuildContext context) {
    final isThemeChange = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: isThemeChange.mTheme ? colorsBlack : colorWhite,
      body: SizedBox(
        // decoration: BoxDecoration(
        //   boxShadow: [
        //     BoxShadow(
        //       color: Theme.of(context).primaryColor.withOpacity(0.7),
        //       blurRadius: 4,
        //     ),
        //   ],
        // ),
        width: double.infinity,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 10.h,
                  bottom: 20.h,
                  left: 10.w,
                  right: 10.w,
                ),
                child: Center(
                  child: const Text("Settings")
                      .boldSized(22)
                      .colors(isThemeChange.mTheme ? colorWhite : colorsBlack),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 10.h,
                  bottom: 20.h,
                  left: 10.w,
                  right: 10.w,
                ),
                child: Center(
                  child: Container(
                    height: 100.h,
                    width: 300.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      image: DecorationImage(
                        image: isThemeChange.mTheme == false
                            ? const AssetImage('assets/images/splash_image.jpg',)
                            : const AssetImage('assets/images/splash_image.jpg'),
                      ),
                    ),
                  ),
                ),
              ),
              ListTile(
                title:  Text(
                  "Light Mode",
                  style: TextStyle(
                      // fontSize: 18.sp,
                    color: isThemeChange.mTheme ? colorWhite : colorsBlack,
                      ),
                ),
                trailing:  Switch(value: _theme,
                  onChanged: (bool value) {
                    setState(() {
                      _theme = value;
                    });
                    isThemeChange.checkTheme();
                  },
                  inactiveThumbColor: isThemeChange.mTheme ? colorWhite : colorPrimary,
                  activeColor: isThemeChange.mTheme ? colorWhite : colorPrimary,
                  activeTrackColor: isThemeChange.mTheme ? colorWhite : textGray,
                  inactiveTrackColor: isThemeChange.mTheme ? textGray : textGray,
                ),
                leading: Icon(
                  isThemeChange.mTheme
                      ? Icons.notifications_active_outlined
                      : Icons.notifications_active_outlined,
                  color: isThemeChange.mTheme ? colorWhite : colorsBlack,
                  size: 20.w,
                ),
              ),
              ListTile(
                title:  Text(
                  "About Us",
                  style: TextStyle(
                      // fontSize: 18.sp,
                    color: isThemeChange.mTheme ? colorWhite : colorsBlack,
                      ),
                ),
                // subtitle: Text(
                //   "About the developer",
                //   style: TextStyle(
                //     fontSize: 13.sp,
                //   ),
                // ),
                leading: Icon(
                  isThemeChange.mTheme
                      ? Icons.info_outline
                      : Icons.info_outline,
                  color: isThemeChange.mTheme ? colorWhite : colorsBlack,
                  size: 20.w,
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: const Text(
                          "About the Company",
                        ),
                        content: Text(
                          'COMING SOON!!!',
                          style: TextStyle(
                            fontSize: 15.sp,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              ListTile(
                title:  Text(
                  "Contact Us",
                  style: TextStyle(
                      // fontSize: 18.sp,
                    color: isThemeChange.mTheme ? colorWhite : colorsBlack,
                      ),
                ),
                leading: Icon(
                  isThemeChange.mTheme
                      ? Icons.phone_iphone_outlined
                      : Icons.phone_iphone_outlined,
                  color: isThemeChange.mTheme ? colorWhite : colorsBlack,
                  size: 20.w,
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: const Text(
                          "Contact the Company",
                        ),
                        content: Text(
                          'COMING SOON!!!',
                          style: TextStyle(
                            fontSize: 15.sp,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              ListTile(
                title:  Text("Newsletter",style: TextStyle(
                  color: isThemeChange.mTheme ? colorWhite : colorsBlack,
                ),),
                leading: Icon(
                  isThemeChange.mTheme
                      ? Icons.newspaper_outlined
                      : Icons.newspaper_outlined,
                  color: isThemeChange.mTheme ? colorWhite : colorsBlack,
                  size: 20.w,
                ),
              ),
              // ListTile(
              //   title:  Text("Privacy Policy", style: TextStyle(
              //     color: isThemeChange.mTheme ? colorWhite : colorsBlack,
              //   ),),
              //   leading: Icon(
              //     isThemeChange.mTheme
              //         ? Icons.privacy_tip_outlined
              //         : Icons.privacy_tip_outlined,
              //     color: isThemeChange.mTheme ? colorWhite : colorsBlack,
              //     size: 20.w,
              //   ),
              // ),
              ListTile(
                title:  Text("Rate Us", style: TextStyle(
                  color: isThemeChange.mTheme ? colorWhite : colorsBlack,
                ),),
                leading: Icon(
                  isThemeChange.mTheme
                      ? Icons.star_border_outlined
                      : Icons.star_border_outlined,
                  color: isThemeChange.mTheme ? colorWhite : colorsBlack,
                  size: 20.w,
                ),
                onTap: (){
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: const Text(
                          "Rate Our App",
                        ),
                        content: Text(
                          'COMING SOON!!!',
                          style: TextStyle(
                            fontSize: 15.sp,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              ListTile(
                title:  Text("Share App", style: TextStyle(
                  color: isThemeChange.mTheme ? colorWhite : colorsBlack,
                ),),
                leading: Icon(
                  isThemeChange.mTheme
                      ? Icons.share_outlined
                      : Icons.share_outlined,
                  color: isThemeChange.mTheme ? colorWhite : colorsBlack,
                  size: 20.w,
                ),
                onTap: (){
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: const Text(
                          "COMING SOON",
                        ),
                        content: Text(
                          'This feature will be available when hosted on the store',
                          style: TextStyle(
                            fontSize: 15.sp,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              // ListTile(
              //   title:  Text("Advertise with us", style: TextStyle(
              //     color: isThemeChange.mTheme ? colorWhite : colorsBlack,
              //   ),),
              //   leading: Icon(
              //     isThemeChange.mTheme
              //         ? Icons.nest_cam_wired_stand_outlined
              //         : Icons.nest_cam_wired_stand_outlined,
              //     color: isThemeChange.mTheme ? colorWhite : colorsBlack,
              //     size: 20.w,
              //   ),
              // ),
              const Spacer(),
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                     Text('Follow us', style: TextStyle(
                       color: isThemeChange.mTheme ? colorWhite : colorsBlack,
                     ),),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 40.w,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // IconButton(
                          //   onPressed: () => {
                          //     launchUrl('https://facebook.com/vanguardallure'),
                          //   },
                          //   icon: FaIcon(
                          //     isThemeChange.mTheme
                          //         ? FontAwesomeIcons.whatsapp
                          //         : FontAwesomeIcons.whatsapp,
                          //     color: isThemeChange.mTheme
                          //         ? colorPrimary
                          //         : colorPrimary,
                          //     size: 32.w,
                          //   ),
                          // ),
                          IconButton(
                            onPressed: () => {
                              _launchInBrowser(Uri.parse('https://facebook.com/vanguardallure')),
                              print('launched')
                            },
                            icon: Icon(
                              isThemeChange.mTheme
                                  ? FontAwesomeIcons.facebook
                                  : FontAwesomeIcons.facebook,
                              color: isThemeChange.mTheme
                                  ? colorPrimary
                                  : colorPrimary,
                              size: 32.w,
                            ),
                          ),
                          IconButton(
                            onPressed: () => {
                              _launchInBrowser(Uri.parse('https://instagram.com/vanguardallure')),
                            },
                            icon: Icon(
                              isThemeChange.mTheme
                                  ? FontAwesomeIcons.instagram
                                  : FontAwesomeIcons.instagram,
                              color: isThemeChange.mTheme
                                  ? colorPrimary
                                  : colorPrimary,
                              size: 32.w,
                            ),
                          ),
                          IconButton(
                            onPressed: () => {
                              launchUrl(Uri.parse('https://twitter.com/vanguardallure')),
                            },
                            icon: Icon(
                              isThemeChange.mTheme
                                  ? FontAwesomeIcons.twitter
                                  : FontAwesomeIcons.twitter,
                              color: isThemeChange.mTheme
                                  ? colorPrimary
                                  : colorPrimary,
                              size: 32.w,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
