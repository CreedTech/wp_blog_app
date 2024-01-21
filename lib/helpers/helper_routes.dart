

import 'package:flutter/material.dart';
import 'package:wp_blog_app/app/src/splash.dart';
import 'package:wp_blog_app/models/article.dart';
import 'package:wp_blog_app/pages/details_page.dart';

import '../components/component_route_animtaion.dart';
import '../pages/tabbar.dart';
import 'helper_routes_parh.dart';

class RouterGenerator {
  Route<dynamic>? generate(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case root:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
          settings: const RouteSettings(name: root),
        );
      case home:
        return MaterialPageRoute(
          builder: (context) => const Tabbar(),
          settings: const RouteSettings(name: home),
        );
      case searchNews:
        return MaterialPageRoute(
          builder: (context) => const Tabbar(),
          settings: const RouteSettings(name: searchNews),
        );

      case settings_page:
        return MaterialPageRoute(
          builder: (context) => const Tabbar(),
          settings: const RouteSettings(name: settings_page),
        );

      case detail:
        // if (arguments is Article) {
        return MaterialPageRoute(
          builder: (context) => const DetailsPage(),
          settings: const RouteSettings(name: detail),
        );
        // }
        // break;

      case favourite:
        return MaterialPageRoute(
          builder: (context) => const Tabbar(),
          settings: const RouteSettings(name: favourite),
        );

    }
    return null;
  }
}

class CustomPageRouteBuilder extends PageRouteBuilder<dynamic> {
  final Widget? page;
  final ComponentPageTransitionAnimation? transitionAnimation;
  final RouteSettings? routeSettings;

  CustomPageRouteBuilder(
      this.page, this.transitionAnimation, this.routeSettings)
      : super(
          settings: routeSettings,
          pageBuilder:
              (final context, final animation, final secondaryAnimation) =>
                  page!,
          transitionsBuilder: (final context, final animation,
                  final secondaryAnimation, final child) =>
              ComponentRouteAnimation.getAnimation(
            context,
            animation,
            secondaryAnimation,
            child,
            transitionAnimation!,
          ),
        );
}
