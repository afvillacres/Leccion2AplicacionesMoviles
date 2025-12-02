import 'package:flutter/material.dart';
import '../../domain/entities/base_entity.dart';
import '../../domain/usecases/get_data_usecase.dart';

class BaseViewModel<T extends BaseEntity> extends ChangeNotifier {
  final GetDataUseCase<T> useCase;

  BaseViewModel(this.useCase);

  List<T> items = [];
  List<T> filteredItems = [];
  List<T> paginatedItems = [];
  
  bool loading = false;
  String? error;
  
  // Paginación
  int currentPage = 1;
  int itemsPerPage = 10;
  
  // Filtrado
  String searchQuery = "";

  Future<void> loadData() async {
    loading = true;
    notifyListeners();

    try {
      items = await useCase();
      filteredItems = items;
      _updatePaginatedItems();
    } catch (e) {
      error = e.toString();
    }

    loading = false;
    notifyListeners();
  }

  void search(String query) {
    searchQuery = query;
    _applyFilter();
    currentPage = 1; // Volver a la página 1 al filtrar
    _updatePaginatedItems();
    notifyListeners();
  }

  void _applyFilter() {
    if (searchQuery.isEmpty) {
      filteredItems = items;
    } else {
      filteredItems = items
          .where((item) => item.toString().toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }
  }

  void _updatePaginatedItems() {
    final startIndex = (currentPage - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;
    
    paginatedItems = filteredItems.length > endIndex 
        ? filteredItems.sublist(startIndex, endIndex)
        : filteredItems.sublist(startIndex);
  }

  void nextPage() {
    final maxPages = getTotalPages();
    if (currentPage < maxPages) {
      currentPage++;
      _updatePaginatedItems();
      notifyListeners();
    }
  }

  void previousPage() {
    if (currentPage > 1) {
      currentPage--;
      _updatePaginatedItems();
      notifyListeners();
    }
  }

  int getTotalPages() {
    return filteredItems.isEmpty ? 1 : (filteredItems.length / itemsPerPage).ceil();
  }

  int getTotalItems() {
    return filteredItems.length;
  }
}
