import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_dialog/util/print_log.dart';

final routeObserverProvider = Provider<RouteObserver<PageRoute>>((ref) {
  QcLog.d("routeObserverProvider ==== ");
  return RouteObserver<PageRoute>();
});

class RouteAwareNotifier extends StateNotifier<String?> with RouteAware {
  final RouteObserver<PageRoute> routeObserver;

  RouteAwareNotifier(this.routeObserver) : super(null);

  void subscribe(Route<dynamic>? route) {
    QcLog.d("subscribe ==== ${route.toString()}");
    routeObserver.subscribe(this, route as PageRoute);
  }

  void unsubscribe() {
    QcLog.d("unsubscribe ==== ");
    routeObserver.unsubscribe(this);
  }

  @override
  void didPush() {
    state = "Route Pushed";
    QcLog.d("Route pushed: ${state}");
  }

  @override
  void didPopNext() {
    state = "Route Popped Next";
    QcLog.d("Returned to this page: ${state}");
  }

  @override
  void didPop() {
    state = "Route did op";
    QcLog.d("Returned to this page: ${state}");
  }

  @override
  void didPushNext() {
    state = "Route did PushNext";
    QcLog.d("Returned to this page: ${state}");
  }
}

final routeAwareProvider =
    StateNotifierProvider<RouteAwareNotifier, String?>((ref) {
  final routeObserver = ref.watch(routeObserverProvider);
  return RouteAwareNotifier(routeObserver);
});

// void main() {
//   runApp(ProviderScope(child: SampleRouteObserverRiverpod()));
// }

class SampleRouteObserverRiverpod extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    QcLog.d("SampleRouteObserverRiverpod ==== ");
    final routeObserver = ref.watch(routeObserverProvider);
    QcLog.d('routeObserver === ${routeObserver.toString()}');

    return MaterialApp(
      navigatorObservers: [routeObserver],
      home: HomeScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/second': (context) => SecondScreen(),
        '/third': (context) => ThirdScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    QcLog.d("HomeScreen ==== ");
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/second');
          },
          child: Text('Go to Second Screen'),
        ),
      ),
    );
  }
}

class SecondScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    QcLog.d("SecondScreen ==== ");
    final routeAwareNotifier = ref.watch(routeAwareProvider.notifier);
    QcLog.d('routeAwareNotifier === ${routeAwareNotifier}');
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigator.pop(context);
            Navigator.pushNamed(context, '/third');
          },
          child: Text('Go third'),
        ),
      ),
    );
  }

  @override
  void didChangeDependencies(BuildContext context, WidgetRef ref) {
    QcLog.d("didChangeDependencies ==== ");
    final routeAwareNotifier = ref.read(routeAwareProvider.notifier);
    routeAwareNotifier.subscribe(ModalRoute.of(context));
  }

  @override
  void dispose(BuildContext context, WidgetRef ref) {
    QcLog.d("dispose ==== ");
    final routeAwareNotifier = ref.read(routeAwareProvider.notifier);
    routeAwareNotifier.unsubscribe();
  }
}

class ThirdScreen extends ConsumerWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    QcLog.d("ThirdScreen ==== ");
    final routeAwareNotifier = ref.watch(routeAwareProvider.notifier);
    QcLog.d('routeAwareNotifier === ${routeAwareNotifier.toString()}');
    return Scaffold(
      appBar: AppBar(
        title: Text('Third Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go Back'),
        ),
      ),
    );
  }

  @override
  void didChangeDependencies(BuildContext context, WidgetRef ref) {
    QcLog.d("didChangeDependencies ==== ");
    final routeAwareNotifier = ref.read(routeAwareProvider.notifier);
    routeAwareNotifier.subscribe(ModalRoute.of(context));
  }

  @override
  void dispose(BuildContext context, WidgetRef ref) {
    QcLog.d("dispose ==== ");
    final routeAwareNotifier = ref.read(routeAwareProvider.notifier);
    routeAwareNotifier.unsubscribe();
  }
}

// class MyScreen extends StatefulWidget {
//   @override
//   _MyScreenState createState() => _MyScreenState();
// }
//
// class _MyScreenState extends State<MyScreen> with RouteAware {
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     routeObserver.subscribe(this, ModalRoute.of(context)!);
//   }
//   @override
//   void dispose() {
//     routeObserver.unsubscribe(this);
//     super.dispose();
//   }
//   @override
//   void didPush() {
//     print("Page pushed: ${ModalRoute.of(context)?.settings.name}");
//   }
//   @override
//   void didPopNext() {
//     print("Returned to this page: ${ModalRoute.of(context)?.settings.name}");
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Screen'),
//       ),
//       body: Center(child: Text('This is My Screen')),
//     );
//   }
// }
