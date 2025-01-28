import 'package:flutter/material.dart';


// https://21st.dev/aceternity/background-boxes/default

class BackgroundBoxes extends StatefulWidget {
  const BackgroundBoxes({Key? key}) : super(key: key);

  @override
  State<BackgroundBoxes> createState() => _BackgroundBoxesState();
}

class _BackgroundBoxesState extends State<BackgroundBoxes> {
  int? hoveredIndex;
  static const int rows = 20;
  static const int cols = 16;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background color
        Container(
          color: const Color(0xFF0F172A), // slate-900
        ),
        
        // Grid of boxes
        Transform.scale(
          scale: 1.5,
          child: Transform.translate(
            offset: const Offset(100, 0), // translateX equivalent
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: cols,
                childAspectRatio: 1,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: rows * cols,
              itemBuilder: (context, index) {
                return MouseRegion(
                  onEnter: (_) {
                    print("Entering");
                  setState(() => hoveredIndex = index);

                  } ,
                  onExit: (_) => setState(() => hoveredIndex = null),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      color: hoveredIndex == index
                          ? Colors.grey // grey color when hovered
                          : Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        
        // Radial gradient mask
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              colors: [
                Colors.transparent,
                const Color(0xFF0F172A).withOpacity(1),
              ],
              stops: const [0.4, 1.0],
            ),
          ),
        ),
        
        // Content
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Tailwind is Awesome',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Framer motion is the best animation library ngl',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[300],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Usage example
class BackgroundBoxesDemo extends StatelessWidget {
  const BackgroundBoxesDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 400,
      width: 400,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        child: BackgroundBoxes(),
      ),
    );
  }
}
