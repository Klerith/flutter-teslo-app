import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';

import 'products_repository_provider.dart';


final productProvider = StateNotifierProvider.autoDispose.family<ProductNotifier, ProductState, String>(
  (ref, productId ) {
    
    final productsRepository = ref.watch(productsRepositoryProvider);
  
    return ProductNotifier(
      productsRepository: productsRepository, 
      productId: productId
    );
});



class ProductNotifier extends StateNotifier<ProductState> {

  final ProductsRepository productsRepository;


  ProductNotifier({
    required this.productsRepository,
    required String productId,
  }): super(ProductState(id: productId )) {
    loadProduct();
  }

  Product newEmptyProduct() {
    return Product(
      id: 'new', 
      title: '', 
      price: 0, 
      description: '', 
      slug: '', 
      stock: 0, 
      sizes: [], 
      gender: 'men', 
      tags: [], 
      images: [],
    );
  }


  Future<void> loadProduct() async {

    try {

      if ( state.id == 'new' ) {
        state = state.copyWith(
          isLoading: false,
          product: newEmptyProduct(),
        );  
        return;
      }

      final product = await productsRepository.getProductById(state.id);

      state = state.copyWith(
        isLoading: false,
        product: product
      );

    } catch (e) {
      // 404 product not found
      print(e);
    }

  }

}




class ProductState {

  final String id;
  final Product? product;
  final bool isLoading;
  final bool isSaving;

  ProductState({
    required this.id, 
    this.product, 
    this.isLoading = true, 
    this.isSaving = false,
  });

  ProductState copyWith({
    String? id,
    Product? product,
    bool? isLoading,
    bool? isSaving,
  }) => ProductState(
    id: id ?? this.id,
    product: product ?? this.product,
    isLoading: isLoading ?? this.isLoading,
    isSaving: isSaving ?? this.isSaving,
  );
  
}

