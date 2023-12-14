import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/detail/detail_restaurant_cubit.dart';
import '../../cubit/review/review_cubit.dart';
import '../../models/detail_restauraunt_model.dart';
import '../../shared/helper.dart';
import '../../shared/style.dart';
import 'custom_button.dart';

class CustomFormReview extends StatefulWidget {
  final DetailRestaurant detailRestaurant;
  const CustomFormReview({
    super.key,
    required this.detailRestaurant,
  });

  @override
  State<CustomFormReview> createState() => _CustomFormReviewState();
}

class _CustomFormReviewState extends State<CustomFormReview> {
  final nameController = TextEditingController();
  final reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Review Restaurant ${widget.detailRestaurant.name}',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: 'Name',
              hintStyle: greyTextStyle.copyWith(
                fontSize: 16,
              ),
              labelText: 'Name',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: reviewController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'I love this restaurant because...',
              hintStyle: greyTextStyle.copyWith(
                fontSize: 16,
              ),
              labelText: 'Review',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                text: 'Cancel',
                color: redColor,
              ),
              CustomButton(
                onPressed: () {
                  if (nameController.text.isNotEmpty &&
                      reviewController.text.isNotEmpty) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Submit Review'),
                        content: const Text(
                            'Are you sure you want to submit this review?'),
                        actions: [
                          CustomButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            text: 'Cancel',
                            color: redColor,
                          ),
                          BlocConsumer<ReviewCubit, ReviewState>(
                            listener: (context, state) {
                              if (state is ReviewSuccess) {
                                Navigator.pop(context);
                                toast(
                                  'Thank you for your review !!!',
                                  greenColor,
                                );
                                Navigator.pop(context);
                                context
                                    .read<DetailRestaurantCubit>()
                                    .getDetailRestaurant(
                                      widget.detailRestaurant.id!,
                                    );
                              }

                              if (state is ReviewFailed) {
                                Navigator.pop(context);
                                toast(
                                  'Failed submit review !!!',
                                  redColor,
                                );
                                Navigator.pop(context);
                              }
                            },
                            builder: (context, state) {
                              return CustomButton(
                                onPressed: () {
                                  context.read<ReviewCubit>().createReviews(
                                        id: widget.detailRestaurant.id!,
                                        name: nameController.text,
                                        review: reviewController.text,
                                      );
                                },
                                text: 'Ok',
                                color: blueColor,
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  }

                  if (nameController.text.isEmpty) {
                    toast(
                      'Please fill your name !!!',
                      redColor,
                    );
                  } else if (reviewController.text.isEmpty) {
                    toast(
                      'Please fill your review !!!',
                      redColor,
                    );
                  }
                },
                text: 'Submit',
                color: blueColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
