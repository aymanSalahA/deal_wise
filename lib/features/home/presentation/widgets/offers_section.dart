import 'package:carousel_slider/carousel_slider.dart';
import 'package:deal_wise/features/home/presentation/cubit/offer_cubit.dart';
import 'package:deal_wise/features/home/presentation/cubit/offer_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class OffersSection extends StatefulWidget {
  const OffersSection({super.key});

  @override
  State<OffersSection> createState() => _OffersSectionState();
}

class _OffersSectionState extends State<OffersSection> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<OfferCubit>().getOffers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OfferCubit, OfferState>(
      builder: (context, state) {
        if (state is OfferLoading) {
          return Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: const Color(0xFF003366),
                size: 40,
              ),
            ),
          );
        } else if (state is OfferSuccess) {
          final offers = state.offers;

          return Column(
            children: [
              CarouselSlider(
                items: offers.map((offer) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          offer.coverUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(
                                Icons.broken_image,
                                size: 60,
                                color: Colors.pink,
                              ),
                            );
                          },
                        ),
                        Container(color: const Color.fromARGB(75, 0, 0, 0)),
                        Positioned(
                          left: 20,
                          bottom: 20,
                          child: Text(
                            offer.name,
                            style: GoogleFonts.nunito(
                              shadows: [
                                const Shadow(
                                  color: Colors.black54,
                                  offset: Offset(3, 1),
                                  blurRadius: 2,
                                ),
                              ],
                              textStyle: const TextStyle(),
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 180,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  viewportFraction: 0.9,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: offers.asMap().entries.map((entry) {
                  final bool isActive = _currentIndex == entry.key;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    height: 8.0,
                    width: isActive ? 20.0 : 8.0,
                    decoration: BoxDecoration(
                      color: isActive
                          ? const Color(0xFF27AAED)
                          : Colors.grey[400],
                      borderRadius: BorderRadius.circular(8),
                    ),
                  );
                }).toList(),
              ),
            ],
          );
        } else if (state is OfferFailure) {
          return Center(child: Text(state.message));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
