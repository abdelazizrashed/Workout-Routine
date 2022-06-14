import 'dart:io';
import "dart:convert" as convert;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:workout_routine/features/workout_routine/bloc/blocs.dart';
import 'package:workout_routine/features/workout_routine/models/models.dart';
import 'dart:math' as math;

import '../widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showFAB = true;
  String appBarTitle = "Workout Routines";
  IconData addIcon = Icons.add;
  int _page = 0;
  late PageController pageController = PageController(initialPage: _page);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
        ),
        elevation: 0,
        title: Text(appBarTitle),
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (newPage) {
          setState(() {
            _page = newPage;
          });
          switch (newPage) {
            case 0:
              setState(() {
                appBarTitle = "Workout Routines";
                showFAB = true;
              });
              break;
            case 1:
              setState(() {
                appBarTitle =
                    "${DateFormat.EEEE().format(DateTime.now())}'s workout";
                showFAB = false;
              });
              break;
            case 2:
              setState(() {
                appBarTitle = "Report";
                showFAB = false;
              });
              break;
          }
        },
        children: const [
          RoutinesPage(),
          TodaysWorkoutPage(),
          ReportPage(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor.withAlpha(0),
          selectedItemColor: Theme.of(context).colorScheme.onSurface,
          currentIndex: _page,
          items: const [
            BottomNavigationBarItem(
              label: "ROUTINES",
              icon: Icon(Icons.list_alt_rounded),
            ),
            BottomNavigationBarItem(
              label: "WORKOUT",
              icon: Icon(
                IconData(0xe28d, fontFamily: 'MaterialIcons'),
              ),
            ),
            BottomNavigationBarItem(
              label: "REPORTS",
              icon: Icon(Icons.checklist_rounded),
            ),
          ],
          onTap: (tabIndex) {
            pageController.animateToPage(tabIndex,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut);
          },
        ),
      ),
      floatingActionButton: Visibility(
        visible: showFAB,
        child: ExpandableFab(
          distance: 112.0,
          children: [
            FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/add-routine");
              },
              child: const Icon(Icons.add),
            ),
            FloatingActionButton(
              onPressed: () async {
                Directory directory = await getApplicationDocumentsDirectory();
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  allowedExtensions: ["json"],
                  dialogTitle: "Select a JSON file",
                  initialDirectory: directory.path,
                );
                if (result != null) {
                  File file = File(result.files.single.path!);
                  if (file.existsSync()) {
                    try {
                      final fileContent = await file.readAsString();
                      final json = convert.json.decode(fileContent);
                      final routine = RoutineModel.fromJson(json);
                      if (!mounted) return;
                      BlocProvider.of<RoutineBloc>(context).add(
                        SaveRoutineInLocalDBEvent(routine),
                      );
                    } catch (e) {
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Error reading file")));
                      debugPrint(e.toString());
                    }
                  }
                }
              },
              child: const Icon(Icons.import_export),
            ),
          ],
        ),
      ),
    );
  }
}

class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    Key? key,
    this.initialOpen,
    required this.distance,
    required this.children,
  }) : super(key: key);

  final bool? initialOpen;
  final double distance;
  final List<Widget> children;

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          _buildTapToCloseFab(),
          ..._buildExpandingActionButtons(),
          _buildTapToOpenFab(),
        ],
      ),
    );
  }

  Widget _buildTapToCloseFab() {
    return SizedBox(
      width: 56.0,
      height: 56.0,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4.0,
          child: FloatingActionButton(
              onPressed: _toggle, child: const Icon(Icons.close)),
        ),
      ),
    );
  }

  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            onPressed: _toggle,
            child: const Icon(Icons.create),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    final step = 90.0 / (count - 1);
    for (var i = 0, angleInDegrees = 0.0;
        i < count;
        i++, angleInDegrees += step) {
      children.add(
        _ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    this.onPressed,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Widget icon;
  final Color backgroundColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: backgroundColor,
      elevation: 4.0,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        color: iconColor,
      ),
    );
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  });

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (math.pi / 180.0),
          progress.value * maxDistance,
        );
        return Positioned(
          right: 4.0 + offset.dx,
          bottom: 4.0 + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / 2,
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}
