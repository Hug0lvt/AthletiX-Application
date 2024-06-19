import 'dart:convert';

PaginationResult<TItem> paginationResultFromJson<TItem>(String str) =>
    PaginationResult<TItem>.fromJson(json.decode(str));

String paginationResultToJson<TItem>(PaginationResult<TItem> data) =>
    json.encode(data.toJson());

class PaginationResult<TItem> {
  List<TItem> items;
  int totalItems;
  int nextPage;

  PaginationResult({
    required this.items,
    required this.totalItems,
    required this.nextPage,
  });

  factory PaginationResult.fromJson(Map<String, dynamic> json) =>
      PaginationResult<TItem>(
        items: List<TItem>.from(json["Items"].map((x) => x)),
        totalItems: json["TotalItems"],
        nextPage: json["NextPage"],
      );

  Map<String, dynamic> toJson() => {
    "Items": List<dynamic>.from(items.map((x) => x)),
    "TotalItems": totalItems,
    "NextPage": nextPage,
  };
}
