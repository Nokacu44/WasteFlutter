import 'package:flutter/material.dart';
import 'package:gdr/classes/constants.dart';
import 'package:gdr/providers/status_messages_provider.dart';
import 'package:gdr/screens/game_world.dart';
import 'package:gdr/ui_components/game_button.dart';
import 'package:provider/provider.dart';
import 'package:gdr/providers/entity_provider.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              padding: const EdgeInsets.all(20 + cellSize),
              color: Colors.black87,
              child: const GameWorld(),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.black87,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Container(
                        color: Colors.white54,
                        child: StatusMessageWidget(),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                spaceSizedBox,
                                GameButton(
                                  "◄",
                                  () {
                                    context
                                        .read<Entities>()
                                        .executePlayerFunction(() => context
                                            .read<Entities>()
                                            .player
                                            .move(1, 'left'));
                                  },
                                  buttonSize,
                                ),
                                spaceSizedBox,
                              ],
                            ),
                            Column(
                              children: [
                                GameButton(
                                  "▲",
                                  () {
                                    context
                                        .read<Entities>()
                                        .executePlayerFunction(() => context
                                            .read<Entities>()
                                            .player
                                            .move(1, 'up'));
                                  },
                                  buttonSize,
                                ),
                                spaceSizedBox,
                                GameButton(
                                  "▼",
                                  () {
                                    context
                                        .read<Entities>()
                                        .executePlayerFunction(() => context
                                            .read<Entities>()
                                            .player
                                            .move(1, 'down'));
                                  },
                                  buttonSize,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                spaceSizedBox,
                                GameButton(
                                  "►",
                                  () {
                                    context
                                        .read<Entities>()
                                        .executePlayerFunction(() => context
                                            .read<Entities>()
                                            .player
                                            .move(1, 'right'));
                                  },
                                  buttonSize,
                                ),
                                spaceSizedBox,
                              ],
                            ),
                            Column(
                              children: [
                                GameButton(
                                  "Inv",
                                  () => Navigator.pushNamed(
                                      context, '/inventory'),
                                  buttonSize,
                                ),
                                spaceSizedBox,
                                spaceSizedBox,
                              ],
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Column(
                              children: [
                                GameButton(
                                  "Player",
                                  () {},
                                  buttonSize,
                                ),
                                spaceSizedBox,
                                spaceSizedBox,
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    const Text("Copyright @Nokacu44"),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StatusMessageWidget extends StatefulWidget {
  const StatusMessageWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<StatusMessageWidget> createState() => _StatusMessageWidgetState();
}

class _StatusMessageWidgetState extends State<StatusMessageWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      context.watch<StatusMessages>().displayMessage(),
      style: const TextStyle(fontSize: 16),
    );
  }
}
