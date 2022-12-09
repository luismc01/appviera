import 'dart:math';

import 'package:flutter/material.dart';

const _pizzaMovementDuration = Duration(milliseconds: 1600);

class Digitales extends StatefulWidget {
  const Digitales({super.key});

  @override
  State<Digitales> createState() => _MaquetasState();
}

class _MaquetasState extends State<Digitales> {
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
        title: const Text('Pasteles por pedido'),
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
                    child: const DecoratedBox(
                      decoration: BoxDecoration(
                        color: ColorTheme.pinkLight,
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
                                      // color: ColorTheme.pinkLight,
                                      color: Colors.red,
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
  int price;
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
        id: 'P-2',
        asset: 'assets/images/per1.png',
        name: 'Pastel día del médico',
        description:
            'Para tu doctor favorito tenemos este pastel personalizado para que se lo obsequies en su día',
        rating: 4,
        price: 30,
        components: ['450 cal', 'Detalles de médico', 'Sabor que desees']),
    Pizza(
        id: 'P-3',
        asset: 'assets/images/per2.png',
        name: 'Pastel para 30ñeros',
        description: 'Pedido especial para nuestra amiga que cumple años',
        rating: 3,
        price: 35,
        components: ['Queso', 'Zarzamora']),
    Pizza(
        id: 'P-4',
        name: 'Pastel Flor',
        asset: 'assets/images/per3.png',
        description: 'Delicioso pastel que rosa la línea de ácido y dulce',
        rating: 5,
        price: 30,
        components: ['Acidez', 'Dulce']),
    Pizza(
        id: 'P-5',
        asset: 'assets/images/per4.png',
        name: 'Pastel de chocolate',
        description:
            'Para los amantes del chocolate les traemos este delcioso pastel decorado con piezas de chocolate',
        rating: 4,
        price: 25,
        components: ['Chocolate', 'Más chocolate']),
  ];
}

class ColorTheme {
  static const Color pink = Color(0xffC09A9C);
  static const Color pinkLight = Color.fromARGB(143, 168, 116, 178);
  static const Color pinkBlack = Color(0xffA48083);
  static const Color black = Color(0xff010001);
  static const Color white = Color.fromARGB(255, 255, 255, 255);
}
