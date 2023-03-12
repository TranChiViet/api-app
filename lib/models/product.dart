import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  final String name;
  final String id;
  final int price;
  Product({
    required this.name,
    required this.id,
    required this.price,
  });

  Product copyWith({
    String? name,
    String? id,
    int? price,
  }) {
    return Product(
      name: name ?? this.name,
      id: id ?? this.id,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'price': price,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] as String,
      id: map['id'] as String,
      price: map['price'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Product(name: $name, id: $id, price: $price)';

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.id == id &&
      other.price == price;
  }

  @override
  int get hashCode => name.hashCode ^ id.hashCode ^ price.hashCode;
}
