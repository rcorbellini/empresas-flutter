import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

///The default loading of app, with ioa logo and animation.
class LoadingIoa extends StatefulWidget {
  ///the constructor
  const LoadingIoa({Key? key}) : super(key: key);

  @override
  _LoadingIoaState createState() => _LoadingIoaState();
}

///Loading with a pokeball doing a roll
class _LoadingIoaState extends State<LoadingIoa>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;
  @override
  void initState() {
    _rotationController = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _startAnnimationLoading();
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(_rotationController),
      child: Container(
        height: 80,
        width: 80,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Center(
              child: SvgPicture.asset(
                'assets/images/elipse_outside.svg',
                semanticsLabel: 'Carregando',
                height: 72,
                width: 72,
              ),
            ),
            Center(
              child: SvgPicture.asset('assets/images/elipse_inside.svg',
                  excludeFromSemantics: true,
                  height: 47,
                  width: 47,
                  semanticsLabel: 'Carregando'),
            )
          ],
        ),
      ),
    );
  }

  void _startAnnimationLoading() {
    _rotationController.repeat();
  }

  void _stopAnnimationLoading() {
    _rotationController.reset();
  }

  @override
  void dispose() {
    _stopAnnimationLoading();
    _rotationController.dispose();
    super.dispose();
  }
}
