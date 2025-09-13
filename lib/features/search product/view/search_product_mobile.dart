import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20model/product/product_model.dart';
import 'package:sadhana_cart/core/common%20services/product/product_service.dart';
import 'package:sadhana_cart/core/widgets/custom_search_field.dart';

class SearchProductMobile extends ConsumerStatefulWidget {
  final PreferredSizeWidget? appBar;
  const SearchProductMobile({super.key, this.appBar});

  @override
  ConsumerState<SearchProductMobile> createState() =>
      _SearchProductMobileState();
}

class _SearchProductMobileState extends ConsumerState<SearchProductMobile>
    with SingleTickerProviderStateMixin {
  final controller = TextEditingController();
  List<ProductModel> displayedProducts = [];
  bool isRightDrawerOpen = false;
  bool isLoading = false;

  // Price filter
  final double _minPrice = 0;
  final double _maxPrice = 5000;
  RangeValues _currentRange = const RangeValues(0, 5000);

  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    controller.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      final queryText = controller.text.trim();

      setState(() => isLoading = true);

      try {
        // Fetch filtered products matching the search query
        final results = await ProductService.getProductByQuery(
          query: queryText,
        );

        setState(() {
          displayedProducts = results;
        });
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

  void toggleRightDrawer() {
    setState(() => isRightDrawerOpen = !isRightDrawerOpen);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final itemsToShow = displayedProducts;

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
                // Search bar and filter button
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

                // Show loading or empty states
                if (isLoading)
                  const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (itemsToShow.isEmpty)
                  const Expanded(
                    child: Center(child: Text("No products found")),
                  )
                else
                  // GridView showing only filtered products
                  Expanded(
                    flex: 3,
                    child: GridView.builder(
                      itemCount: itemsToShow.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 0.65,
                          ),
                      itemBuilder: (context, index) {
                        final product = itemsToShow[index];
                        return Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Product Image
                              product.images != null &&
                                      product.images!.isNotEmpty
                                  ? ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                      child: Image.network(
                                        product.images![0],
                                        height: 120,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Container(
                                      height: 120,
                                      width: double.infinity,
                                      color: Colors.grey.shade200,
                                      child: const Icon(Icons.image, size: 50),
                                    ),

                              // Product Name
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  product.name ?? "No Name",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              // Product Price
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: Text(
                                  "₹${product.price?.toStringAsFixed(0) ?? 0}",
                                  style: const TextStyle(color: Colors.green),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),

          // Right drawer overlay (Filter Panel)
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
                      const SizedBox(height: 20),
                      const Text("Category"),
                      const SizedBox(height: 10),
                      const Text("Brand"),
                      const SizedBox(height: 10),
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
                        onPressed: toggleRightDrawer,
                        child: const Text("Apply Filters"),
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
