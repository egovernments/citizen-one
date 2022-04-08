import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';

class NetworkStatusBanner extends StatelessWidget {
  const NetworkStatusBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
          ) {
        final connected = connectivity != ConnectivityResult.none;
        return AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                color: connected ? const Color(0xFF00EE44) : const Color(0xFFEE4400),
                width: MediaQuery.of(context).size.width,
                height: 30,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 350),
                  child: Wrap(
                    children: [
                      child,
                       Text(connected ? 'Online' : 'Offline',
                           style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white))
                    ],
                  )
                ),
        );
      },
      child: const Text('NetWork Status : ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
    );
  }
}
