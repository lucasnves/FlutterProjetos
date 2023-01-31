import 'package:flutter/material.dart';

class MyDesktopBody extends StatelessWidget {
  const MyDesktopBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[300],
      appBar: AppBar(
        centerTitle: true,
        title: const Text('D E S K T O P'),
      ),
      body: Row(
        children: [
          // primeira coluna
          Expanded(
            child: Column(
              children: [
                // youtube video
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Container(
                      height: 250,
                      color: Colors.deepPurple[500],
                    ),
                  ),
                ),

                // comment section & recommended videos
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          color: Colors.deepPurple[400],
                          height: 120,
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),

          // segunda coluna
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              width: 200,
              color: Colors.deepPurple[400],
            ),
          )
        ],
      ),
    );
  }
}
