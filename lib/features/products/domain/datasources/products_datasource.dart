import '../entities/product.dart';


abstract class ProductsDatasource {

  Future<List<Product>> getProductsByPage({ int limit = 10, int offset = 0 });
  Future<Product> getProductById(String id);

  Future<List<Product>> searchProductByTerm( String term );
  
  Future<Product> createUpdateProduct( Map<String,dynamic> productLike );


}

