abstract class StorageService {
  // load data from storage at app-start
  Future initApp();

  // store memory data in localStorage
  void store();
}
