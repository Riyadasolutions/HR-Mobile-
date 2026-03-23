

class PaginationParameters {
     int _currentPage;

   void setCurrentPage(int currentPage) => _currentPage = currentPage;
   void toNextPage() => _currentPage ++;
   void resetPage() => _currentPage =1;


  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["page"] = _currentPage;
    return data;
  }

  PaginationParameters({
    int currentPage = 1,
  })  :
        _currentPage = currentPage;

  int get currentPage => _currentPage;

}
