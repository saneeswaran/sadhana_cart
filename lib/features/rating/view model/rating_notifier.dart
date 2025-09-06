import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/features/rating/model/rating_model.dart';
import 'package:sadhana_cart/features/rating/model/rating_state.dart';
import 'package:sadhana_cart/features/rating/service/rating_service.dart';

final ratingProvider = StateNotifierProvider<RatingNotifier, RatingState>(
  (ref) => RatingNotifier(),
);

final specificProductrating = FutureProvider.autoDispose
    .family<List<RatingModel>, String>((ref, productId) async {
      return ref
          .read(ratingProvider.notifier)
          .fetchProductRating(productId: productId);
    });

class RatingNotifier extends StateNotifier<RatingState> {
  RatingNotifier() : super(RatingState.initialState());

  void addrating({required RatingModel rating}) {
    state = state.copyWith(ratings: [...state.ratings, rating]);
  }

  void deleteRating({required String ratingId}) {
    state = state.copyWith(
      ratings: state.ratings.where((e) => e.userId != ratingId).toList(),
    );
  }

  void updaterating({required RatingModel rating}) {
    state = state.copyWith(
      ratings: state.ratings
          .map((e) => e.ratingId == rating.ratingId ? rating : e)
          .toList(),
    );
  }

  Future<List<RatingModel>> fetchProductRating({
    required String productId,
  }) async {
    try {
      state = state.copyWith(isLoading: true, ratings: []);
      final data = await RatingService.fetchRating(productId: productId);
      state = state.copyWith(isLoading: false, ratings: data);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        ratings: [],
        error: e.toString(),
      );
    }
    return state.ratings;
  }
}
