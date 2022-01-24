#include "List.h"

int main() {
  List<int> list;
  List<int> list2;

  for(int i= 0; i<=20;i++){
    i%2==0 ? list.insertBack(i) : list.insertFront(i);
  }
list.print(std::cout);
cout<<endl;

list.sort();
cout<<endl;
list.print(std::cout);






  return 0;
}
