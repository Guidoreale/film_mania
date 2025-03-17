import 'package:flutter/material.dart';

class ScreenSkeleton extends StatelessWidget {
  const ScreenSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    Stream<String> getMessages() {
      const messages = <String>[
        'loading now playing movies...',
        'Movies are the best way to relax!',
        'loading popular movies...',
        'Grab some popcorn and enjoy the show!',
        'loading top rated movies...',
        'buying tickets for upcoming movies...',
        'loading upcoming movies...',
        'almost there...',
      ];
      return Stream.periodic(Duration(milliseconds: 1300), (index) {
        return messages[index];
      }).take(messages.length);
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            strokeWidth: 2,
          ),
          SizedBox(height: 10),
          StreamBuilder(
              stream: getMessages(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text('loading...');
                }
                return Text('${snapshot.data}');
              }),
        ],
      ),
    );
  }
}
