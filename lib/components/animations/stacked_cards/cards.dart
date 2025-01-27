import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class AnimatedCard {
  final String title;
  final String content;
  final String author;
  final String subtitle;

  AnimatedCard({
    required this.title,
    required this.content,
    required this.author,
    required this.subtitle,
  });
}

class AnimatedStackCards extends StatefulWidget {
  final List<AnimatedCard> cards;
  final double spacing;

  const AnimatedStackCards({
    Key? key,
    required this.cards,
    this.spacing = 20.0,
  }) : super(key: key);

  @override
  State<AnimatedStackCards> createState() => _AnimatedStackCardsState();
}

class _AnimatedStackCardsState extends State<AnimatedStackCards> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Stack(
        children: List.generate(widget.cards.length, (index) {
          final card = widget.cards[index];
          final isTop = index == currentIndex;

          return TweenAnimationBuilder<double>(
            tween: Tween<double>(
              begin: index < currentIndex
                  ? -50
                  : widget.spacing * (index - currentIndex),
              end: index < currentIndex
                  ? -50
                  : widget.spacing * (index - currentIndex),
            ),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return Positioned(
                top: value,
                left: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    if (isTop && currentIndex < widget.cards.length - 1) {
                      setState(() {
                        currentIndex++;
                      });
                    }
                  },
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: isTop ? 1.0 : 0.8,
                    child: _buildCard(card),
                  ),
                ),
              );
            },
          );
        }).reversed.toList(),
      ),
    );
  }

  Widget _buildCard(AnimatedCard card) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                card.content,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                card.author,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                card.subtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// Example usage
class CardStackDemo extends StatelessWidget {
  CardStackDemo({Key? key}) : super(key: key);

  final List<AnimatedCard> cards = [
    AnimatedCard(
      title: 'Card 1',
      content: 'This is the first card content with some example text.',
      author: 'Author One',
      subtitle: 'Subtitle One',
    ),
    AnimatedCard(
      title: 'Card 2',
      content: 'This is the second card with different content.',
      author: 'Author Two',
      subtitle: 'Subtitle Two',
    ),
    AnimatedCard(
      title: 'Card 3',
      content: 'And here is the third card with unique text.',
      author: 'Author Three',
      subtitle: 'Subtitle Three',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Container(
          height: 500,
          width: 300,
          child: Center(
            child: AnimatedStackCards(cards: cards),
          ),
        ),
      ),
    );
  }
}