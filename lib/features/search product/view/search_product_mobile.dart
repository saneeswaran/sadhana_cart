import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20model/product/product_model.dart';
import 'package:sadhana_cart/core/common%20repo/product/all_products_notifier.dart';
import 'package:sadhana_cart/core/common%20services/product/product_service.dart';
import 'package:sadhana_cart/core/widgets/custom_search_field.dart';
import 'package:sadhana_cart/features/search%20product/widgets/search_product_tile.dart';

class SearchProductMobile extends ConsumerStatefulWidget {
  final PreferredSizeWidget? appBar;
  const SearchProductMobile({super.key, this.appBar});

  @override
  ConsumerState<SearchProductMobile> createState() =>
      _SearchProductMobileState();
}

class _SearchProductMobileState extends ConsumerState<SearchProductMobile>
    with SingleTickerProviderStateMixin {
  // Scroll controller
  late ScrollController _scrollController;

  final controller = TextEditingController();
  List<ProductModel> displayedProducts = [];
  bool isRightDrawerOpen = false;
  bool isLoading = false;

  // Price filter
  bool isFiltering = false;
  final double _minPrice = 0;
  final double _maxPrice = 5000;
  RangeValues _currentRange = const RangeValues(0, 5000);

  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    controller.addListener(_onSearchChanged);
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        // load next page when near bottom
        ref.read(allProductsProvider.notifier).fetchNextProducts();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  // Search
  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      final queryText = controller.text.trim();

      setState(() => isLoading = true);

      try {
        List<ProductModel> baseProducts;

        if (isFiltering) {
          // first apply price filter
          baseProducts = await ProductService.getProductsByMoneyFilter(
            min: _currentRange.start.round(),
            max: _currentRange.end.round(),
          );
        } else {
          // otherwise fetch all products
          baseProducts = await ProductService.fetchProducts();
        }

        // now apply search on baseProducts
        final results = baseProducts.where((product) {
          final name = product.name?.toLowerCase() ?? "";
          return name.contains(queryText.toLowerCase());
        }).toList();

        setState(() {
          displayedProducts = results;
        });

        log("✅ Search results within filter: ${results.length}");
      } catch (e) {
        log("Search error: $e");
        setState(() {
          displayedProducts = [];
        });
      } finally {
        setState(() => isLoading = false);
      }
    });
  }

  // Filter
  Future<void> _applyPriceFilter() async {
    setState(() {
      isLoading = true;
      isFiltering = true;
    });

    try {
      final results = await ProductService.getProductsByMoneyFilter(
        min: _currentRange.start.round(),
        max: _currentRange.end.round(),
      );

      setState(() {
        displayedProducts = results;
      });

      log("Filter applied. Showing ${results.length} products");
    } catch (e) {
      log("Error applying filter: $e");
      setState(() {
        displayedProducts = [];
      });
    } finally {
      setState(() => isLoading = false);
      toggleRightDrawer();
    }
  }

  void toggleRightDrawer() {
    setState(() => isRightDrawerOpen = !isRightDrawerOpen);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final allProducts = ref.watch(allProductsProvider);
    final notifier = ref.read(allProductsProvider.notifier);

    // Determine what to show
    final isSearching = controller.text.trim().isNotEmpty;

    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: widget.appBar,
      drawer: const Drawer(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Search bar + filter
                Row(
                  children: [
                    Expanded(
                      child: CustomSearchBar(
                        backgroundColor: Colors.white,
                        controller: controller,
                        hintText: "Search...",
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      height: size.height * 0.06,
                      width: size.width * 0.15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: toggleRightDrawer,
                        icon: const Icon(Icons.filter_list),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Loading state
                if (isLoading)
                  const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  )
                // Searching
                else if (isSearching)
                  displayedProducts.isEmpty
                      ? const Expanded(
                          child: Center(child: Text("No matching products")),
                        )
                      : Expanded(
                          flex: 3,
                          child: SearchProductTile(
                            products: displayedProducts,
                            isLoadingMore: false, // no pagination in search
                            onTap: (product) {},
                          ),
                        )
                // Price filtering
                else if (isFiltering)
                  displayedProducts.isEmpty
                      ? const Expanded(
                          child: Center(
                            child: Text("No products in this price range"),
                          ),
                        )
                      : Expanded(
                          flex: 3,
                          child: SearchProductTile(
                            products: displayedProducts,
                            isLoadingMore: false, // no pagination in filter
                            onTap: (product) {},
                          ),
                        )
                else // 📦 Default - show all products with pagination
                  allProducts.isEmpty
                      ? const Expanded(
                          child: Center(child: Text("No products found")),
                        )
                      : Expanded(
                          flex: 3,
                          child: SearchProductTile(
                            controller:
                                _scrollController, // scroll for pagination
                            products: allProducts,
                            isLoadingMore: notifier.isLoading,
                            onTap: (product) {},
                          ),
                        ),
              ],
            ),
          ),

          //  Right drawer overlay (Filter Panel)
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            top: 0,
            bottom: 0,
            right: isRightDrawerOpen ? 0 : -size.width * 0.7,
            width: size.width * 0.7,
            child: Material(
              elevation: 16,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade300, width: 2),
                ),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Filters",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: toggleRightDrawer,
                          ),
                        ],
                      ),
                      // const SizedBox(height: 20),
                      // const Text("Category"),
                      // const SizedBox(height: 10),
                      // const Text("Brand"),
                      // const SizedBox(height: 10),
                      const Text(
                        "Price",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(trackHeight: 2),
                        child: RangeSlider(
                          values: _currentRange,
                          min: _minPrice,
                          max: _maxPrice,
                          divisions: 100,
                          activeColor: Colors.black,
                          labels: RangeLabels(
                            "₹${_currentRange.start.round()}",
                            "₹${_currentRange.end.round()}",
                          ),
                          onChanged: (values) {
                            setState(() {
                              _currentRange = values;
                            });
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("₹${_currentRange.start.round()}"),
                          Text("₹${_currentRange.end.round()}"),
                        ],
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: isLoading ? null : _applyPriceFilter,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(
                            45,
                          ), // optional, for full width
                        ),
                        child: isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text("Apply Filters"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
