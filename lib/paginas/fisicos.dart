import 'dart:math';

import 'package:flutter/material.dart';

const _pizzaMovementDuration = Duration(milliseconds: 1600);

class Fisicos extends StatefulWidget {
  const Fisicos({super.key});

  @override
  State<Fisicos> createState() => _MaquetasState();
}

class _MaquetasState extends State<Fisicos> {
  final pageController = PageController();
  double page = 0;
  Pizza pizza = Pizza.pizzaList.first;

  void _onListener() {
    setState(() {
      page = pageController.page ?? 0;
    });
  }

  @override
  void initState() {
    pageController.addListener(_onListener);
    super.initState();
  }

  @override
  void dispose() {
    pageController.removeListener(_onListener);
    pageController.dispose();
    super.dispose();
  }

  void _animateTo(
    int page, {
    Duration duration = const Duration(milliseconds: 700),
  }) {
    if (page < 0 || page > Pizza.pizzaList.length - 1) return;
    pageController.animateToPage(
      page.round(),
      duration: duration,
      curve: Curves.elasticOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pasteles de temporada'),
        backgroundColor: ColorTheme.pinkLight,
        leading: IconButton(
          onPressed: (() {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          }),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: LayoutBuilder(builder: (context, constraints) {
              final widthSize = MediaQuery.of(context).size.width;

              bool isDesktop(BuildContext context) => widthSize >= 600;
              final height = constraints.maxHeight;
              final width = constraints.maxWidth;
              final size = width * 0.6;
              final backgroundPosition = -height / 2;
              return Stack(
                children: [
                  // Create the background
                  Positioned(
                    top: backgroundPosition,
                    left: backgroundPosition,
                    right: backgroundPosition,
                    bottom: size / 2,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: isDesktop(context)
                            ? ColorTheme.redLight
                            : ColorTheme.pinkLight,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  //Create the pizza
                  Listener(
                    onPointerUp: (_) {
                      _animateTo(page.round());
                    },
                    child: PageView.builder(
                        controller: pageController,
                        itemCount: Pizza.pizzaList.length,
                        onPageChanged: (index) {
                          pizza = Pizza.pizzaList[index];
                        },
                        itemBuilder: (context, index) {
                          final pizza = Pizza.pizzaList[index];
                          final percent = page - index;
                          final opacity = 1.0 - percent.abs();
                          final verticalSpace = size / 1.2;
                          final radius = height - verticalSpace;
                          final x = radius * sin(percent);
                          final y =
                              radius * cos(percent) - height + verticalSpace;

                          return Opacity(
                            opacity:
                                opacity < 0.35 ? 0.0 : opacity.clamp(0.0, 1.0),
                            child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.001)
                                ..translate(x, y)
                                ..rotateZ(percent),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: CircularPizza(
                                  pizza: pizza,
                                  size: size,
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              );
            }),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _PizzaTitle(
                    pizza: pizza,
                    onTapLeft: () {
                      _animateTo(
                        page.round() - 1,
                        duration: _pizzaMovementDuration,
                      );
                    },
                    onTapRight: () {
                      _animateTo(
                        page.round() + 1,
                        duration: _pizzaMovementDuration,
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            SizedBox(width: 10),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(pizza.description),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              '\$${pizza.price.toStringAsPrecision(2)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 26,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Wrap(
                                children: List.generate(
                                  pizza.components.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0,
                                      vertical: 3.0,
                                    ),
                                    child: Container(
                                      color: ColorTheme.pinkLight,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          pizza.components[index],
                                          style: const TextStyle(fontSize: 11),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CircularPizza extends StatelessWidget {
  const CircularPizza({
    Key? key,
    required this.pizza,
    required this.size,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  final Pizza pizza;
  final double size;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 15,
            spreadRadius: 1,
            offset: Offset(3, 3),
          )
        ],
      ),
      child: Padding(
        padding: padding,
        child: ClipOval(
          child: Image.asset(
            pizza.asset,
            height: size,
          ),
        ),
      ),
    );
  }
}

class _PizzaTitle extends StatelessWidget {
  const _PizzaTitle({
    required this.pizza,
    this.onTapLeft,
    this.onTapRight,
  });

  final Pizza pizza;
  final VoidCallback? onTapLeft;
  final VoidCallback? onTapRight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          InkWell(
            onTap: () => onTapLeft?.call(),
            child: const CircleAvatar(
              backgroundColor: ColorTheme.pinkLight,
              child: Icon(
                Icons.arrow_back,
                color: ColorTheme.pinkBlack,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                pizza.name,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () => onTapRight?.call(),
            child: const CircleAvatar(
              backgroundColor: ColorTheme.pinkLight,
              child: Icon(
                Icons.arrow_forward,
                color: ColorTheme.pinkBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Pizza {
  String id;
  String asset;
  String name;
  String description;
  int rating;
  double price;
  List<String> components;

  Pizza({
    required this.id,
    required this.asset,
    required this.name,
    required this.description,
    required this.rating,
    required this.price,
    required this.components,
  });

  static List<Pizza> pizzaList = [
    Pizza(
        id: 'P-3',
        asset: 'assets/images/img3.png',
        name: 'NUBE',
        description:
            'Disfruta de este postre que te hará sentir en el cielo por un momento',
        rating: 3,
        price: 2.5,
        components: ['Amaranto', 'Yogurt', 'Lámina de oro']),
    Pizza(
        id: 'P-4',
        name: 'MOKA',
        asset: 'assets/images/img4.png',
        description:
            'Te presentamos nuestro postre oscuro que te dejará con ganas de más',
        rating: 5,
        price: 2,
        components: ['Café', 'Moka', 'Chocolate']),
    Pizza(
        id: 'P-6',
        asset: 'assets/images/img6.png',
        name: 'PUMPKIN',
        description: 'Relleno de bizcocho de especias aromáticas',
        rating: 3,
        price: 3,
        components: ['Calabaza', 'Cacao', 'Chocolate Amargo']),
    Pizza(
        id: 'P-7',
        asset: 'assets/images/img7.png',
        name: 'FLOR',
        description: 'Deja que nuestra flor deleite tu paladar con su sabor',
        rating: 2,
        price: 24.9,
        components: ['Dulce', 'Cremoso', "Base de amaranto"]),
  ];
}

class ColorTheme {
  static const Color pink = Color(0xffC09A9C);
  static const Color pinkLight = Color.fromARGB(143, 168, 116, 178);
  static const Color pinkBlack = Color(0xffA48083);
  static const Color black = Color(0xff010001);
  static const Color redLight = Color.fromARGB(211, 233, 130, 130);
  static const Color white = Color.fromARGB(255, 255, 255, 255);
}
