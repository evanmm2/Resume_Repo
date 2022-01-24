/**
 * @file list.cpp
 * Doubly Linked List (MP 3).
 */
#include <stack>

template <class T>
List<T>::List() {
  // @TODO: graded in MP3.1
    head_ = NULL;
    tail_ = NULL;
    length_ = 0;
}

/**
 * Returns a ListIterator with a position at the beginning of
 * the List.
 */
template <typename T>
typename List<T>::ListIterator List<T>::begin() const {
  // @TODO: graded in MP3.1

  return List<T>::ListIterator(head_);
}

/**
 * Returns a ListIterator one past the end of the List.
 */
template <typename T>
typename List<T>::ListIterator List<T>::end() const {
  // @TODO: graded in MP3.1
  return List<T>::ListIterator(NULL);
}




/**
 * Destroys all dynamically allocated memory associated with the current
 * List class.
 */
template <typename T>
void List<T>::_destroy() {
  ListNode* temp = head_;
  if(head_ == NULL){
  return;
  }
  ListNode* temp2 = head_->next;
  while(temp!= NULL){
    delete temp;
    temp = temp2;
    if(temp == NULL){
      return;
    }
    temp2 = temp2->next;
  }
}

/**
 * Inserts a new node at the front of the List.
 * This function **SHOULD** create a new ListNode.
 *
 * @param ndata The data to be inserted.
 */
template <typename T>
void List<T>::insertFront(T const & ndata) {
  /// @todo Graded in MP3.1
  ListNode * newNode = new ListNode(ndata);
  newNode -> next = head_;
  newNode -> prev = NULL;

  if (head_ != NULL) {
    head_ -> prev = newNode;
  }
  head_ = newNode;
  if (tail_ == NULL) {
    tail_ = newNode;
  }


  length_++;

}

/**
 * Inserts a new node at the back of the List.
 * This function **SHOULD** create a new ListNode.
 *
 * @param ndata The data to be inserted.
 */
template <typename T>
void List<T>::insertBack(const T & ndata) {
  /// @todo Graded in MP3.1
  ListNode * newNode = new ListNode(ndata);
  newNode -> prev = tail_;
  newNode -> next = NULL;

  if (tail_ != NULL) {
    tail_ -> next = newNode;
  }
  tail_ = newNode;
  if (head_ == NULL) {
    head_ = newNode;
  }


  length_++;

}


/**
 * Helper function to split a sequence of linked memory at the node
 * splitPoint steps **after** start. In other words, it should disconnect
 * the sequence of linked memory after the given number of nodes, and
 * return a pointer to the starting node of the new sequence of linked
 * memory.
 *
 * This function **SHOULD NOT** create **ANY** new List or ListNode objects!
 *
 * This function is also called by the public split() function located in
 * List-given.hpp
 *
 * @param start The node to start from.
 * @param splitPoint The number of steps to walk before splitting.
 * @return The starting node of the sequence that was split off.
 */
template <typename T>
typename List<T>::ListNode * List<T>::split(ListNode * start, int splitPoint) {
  /// @todo Graded in MP3.1
  ListNode * curr = start;

  for (int i = 0; (i < splitPoint) && (curr != NULL); i++) {
    curr = curr->next;
  }

  if (curr != NULL) {
      ListNode* previous = curr->prev;
      if(previous!=NULL){
      previous->next = NULL;
      curr->prev = NULL;
  }}

  return curr;
}

/**
 * Modifies the List using the waterfall algorithm.
 * Every other node (starting from the second one) is removed from the
 * List, but appended at the back, becoming the new tail. This continues
 * until the next thing to be removed is either the tail (**not necessarily
 * the original tail!**) or NULL.  You may **NOT** allocate new ListNodes.
 * Note that since the tail should be continuously updated, some nodes will
 * be moved more than once.
 */
template <typename T>
void List<T>::waterfall() {
  /// @todo Graded in MP3.1
  ListNode * curr = head_;
  int i = 0;
  while(curr !=tail_ && curr!=NULL){
    ListNode * temp = curr;
    curr = curr->next;
    if(i%2 == 1){
      temp->prev->next = temp->next;
      temp->next->prev = temp->prev;
      tail_->next = temp;
      temp->prev = tail_;
      tail_ = temp;
      temp->next = NULL;
    }
    i++;
  }
}

/**
 * Reverses the current List.
 */
template <typename T>
void List<T>::reverse() {
  reverse(head_, tail_);
}

/**
 * Helper function to reverse a sequence of linked memory inside a List,
 * starting at startPoint and ending at endPoint. You are responsible for
 * updating startPoint and endPoint to point to the new starting and ending
 * points of the rearranged sequence of linked memory in question.
 *
 * @param startPoint A pointer reference to the first node in the sequence
 *  to be reversed.
 * @param endPoint A pointer reference to the last node in the sequence to
 *  be reversed.
 */
template <typename T>
void List<T>::reverse(ListNode *& startPoint, ListNode *& endPoint) {
  ListNode* curr = startPoint;
  ListNode* temp2 = endPoint->next;
  ListNode* Startprev = startPoint->prev;
  ListNode* Endnext = endPoint->next;
  ListNode* Prevend = endPoint;
  ListNode* Prevstart = startPoint;


  while(curr!=temp2){
    ListNode* temp = curr->next;
    curr->next = curr->prev;
    curr->prev = temp;
    curr = curr->prev;

    }

    startPoint = endPoint;
    endPoint = Prevstart;

    if(Startprev != NULL){
      Startprev->next = startPoint;
    }

    if(Endnext != NULL){
      Endnext->prev = endPoint;
    }

    if(Prevend != NULL && Prevend == tail_){
    tail_ = endPoint;
    }

    if(Prevstart != NULL && Prevstart == head_){
      head_ = startPoint;
    }

  }




  /// @todo Graded in MP3.2
  // std::stack<ListNode*> stack;
  // ListNode* curr = startPoint;
  // ListNode* temp3 = startPoint;
  //
  // ListNode* temp = startPoint->prev;
  // ListNode* temp2 = NULL;
  // while(curr != endPoint->next){
  //   stack.push(curr);
  //   curr = curr->next;
  // }
  //
  //   if(head_== NULL && tail_ == NULL){             // Case for if the list is empty
  //     return;
  //   }
  //
  //
  //   if(startPoint == head_ && endPoint == tail_){     // Case for if it covers the whole list
  //     head_ = tail_;
  //     tail_ = startPoint;
  //     startPoint = endPoint;
  //     endPoint = temp3;
  //     stack.pop();
  //     temp = head_;           //Makes temp equal what the current head should be
  //
  //     while(stack.size() != 0 && temp!=NULL){
  //
  //       temp->next = stack.top();               //Makes the current nodes next, which should be the head the top, the stack node
  //       stack.top()->prev = temp;               //Makes the element on top of the stack's previous equal to the current node
  //       stack.top()->next = NULL;               //Makes the top of the stack next equal to NULL
  //       stack.pop();                            //Pops it off
  //       temp = temp->next;                      //Makes temp whatever it just popped off
  //     }
  //
  //     return;
  //     }
  //
  //
  //   if(head_ == startPoint){              // Case for if it starts at the head
  //     head_ = stack.top();
  //     startPoint = endPoint;
  //     endPoint = temp3;
  //     stack.pop();
  //     temp = head_;                       // Saves the location of the front of the reversal
  //     while(stack.size() != 0 && temp!=NULL){           // While stack isn't empty
  //       temp->next = stack.top();         // Make the head next equal the top of the stack
  //       stack.top()->prev = temp;         // Make the new nodes added previous the current node
  //       temp2 = stack.top()->next;        // Saves the next of the top until the last node that is added
  //       stack.top()->next = NULL;         // Make the new nodes next equal to NULL
  //       stack.pop();                      // Pop it off the stack because it should be incorporated into our list now
  //       temp = temp->next;                // Make temp that new thing popped off the stack
  //       }
  //       if(temp!=NULL && temp2!=NULL){   // Replaces the next of the back of the reversal with the next of the last reversal thing put in
  //       temp->next = temp2;                       // Takes the node at the back of the traversal and makes its next what the previous last in the traversal's was.
  //       temp2->prev = temp;                       // Makes that end node's previous pointer the last node in the traversal
  //       }
  //       return;
  //   }
  //
  //   if(tail_ == endPoint){             // Case for if it ends at the tail
  //     startPoint = endPoint;
  //     endPoint = temp3;
  //     while(stack.size() != 0 && temp!=NULL){
  //
  //       temp->next = stack.top();
  //       stack.top()->prev = temp;
  //       stack.top()->next = NULL;
  //       stack.pop();
  //       tail_ = temp;
  //       temp = temp->next;
  //       }
  //       return;
  //   }
  //
  //   if(head_!=startPoint && tail_!= endPoint){
  //     startPoint = endPoint;
  //     endPoint = temp3;
  //   while(stack.size() != 0 && stack.top() != NULL && temp!= NULL){           // If it isn't at the end or the beginning, but somewhere in the middle
  //     temp->next = stack.top();
  //     stack.top()->prev = temp;
  //     temp2 = stack.top()->next;
  //     stack.top()->next = NULL;
  //     stack.pop();
  //     temp = temp->next;
  //     }
  //     if(temp!=NULL && temp2!=NULL){
  //     temp->next = temp2;
  //     temp2->prev = temp;
  //     }
  // }}





/**
 * Reverses blocks of size n in the current List. You should use your
 * reverse( ListNode * &, ListNode * & ) helper function in this method!
 *
 * @param n The size of the blocks in the List to be reversed.
 */
template <typename T>
void List<T>::reverseNth(int n) {
  /// @todo Graded in MP3.2
  ListNode* start = head_;
  ListNode* end = head_;
  ListNode* endNULL = end;
  while(end != NULL){
    int i = n;
    std::cout<<"Makes it to loop";
    while(i!=0){
      if(end == NULL){
        break;
        std::cout<<"Breaks at NULL";
      }


      end = end->next;
      i--;
  }

  if(end!=NULL){
  reverse(start, end);
  start = end->next;
}
}
std::cout<<"Makes it out of loop";

  if(end==NULL && start != NULL){
    reverse(start, tail_);
  }

}


/**
 * Merges the given sorted list into the current sorted list.
 *
 * @param otherList List to be merged into the current list.
 */
template <typename T>
void List<T>::mergeWith(List<T> & otherList) {
    // set up the current list
    head_ = merge(head_, otherList.head_);
    tail_ = head_;

    // make sure there is a node in the new list
    if (tail_ != NULL) {
        while (tail_->next != NULL)
            tail_ = tail_->next;
    }
    length_ = length_ + otherList.length_;

    // empty out the parameter list
    otherList.head_ = NULL;
    otherList.tail_ = NULL;
    otherList.length_ = 0;
}

/**
 * Helper function to merge two **sorted** and **independent** sequences of
 * linked memory. The result should be a single sequence that is itself
 * sorted.
 *
 * This function **SHOULD NOT** create **ANY** new List objects.
 *
 * @param first The starting node of the first sequence.
 * @param second The starting node of the second sequence.
 * @return The starting node of the resulting, sorted sequence.
 */
template <typename T>
typename List<T>::ListNode * List<T>::merge(ListNode * first, ListNode* second) {
  /// @todo Graded in MP3.2
  ListNode* First1 = first;               // Making a set of dummy variables that edit the first and second trees
  ListNode* Dummy = NULL;
  ListNode* Travel = second;
if(Travel == NULL){
  return first;
}
if(First1 == NULL){
  return second;
}
while(First1->next!=NULL && Travel->next!=NULL){              // If first hasn't reached the end of it's list, then we are not done merging
  if(First1->data < Travel->data){      // If the first dummy variables data is less than the data in what is traveling down the second list
    First1 = First1->next;              // Just increment the dummy variable by one
  }
  else
    { Dummy = Travel;                   // This is when we are inputting the 2nd tree into the first
      if(Travel->next != NULL){         // If the second tree is not at the end, then set it to it's next one and use the dummy for the rest
        Travel = Travel->next;
      }
      Dummy->prev = First1->prev;       // Dummy's previous is now first's previous
      Dummy->next = First1;             // Dummy now points to First1 and is cut from the original tree
      if(First1 != NULL){
        if(First1->prev!=NULL){
      First1->prev->next = Dummy;       // First1-> previous is still pointing to the previous node, so make its next node out dummy
    }
      Dummy->next->prev = Dummy;        // Makes the next nodes previous go to dummy
      First1 = First1->prev;            // Makes the First node iterator point to whatever dummy is for comparison to the next integer in tree 2
  }}}


  First1->next = Travel;                // Tacks on the extra of the second list to the end of the first list
  Travel->prev = First1;


  return first;                        // First should still be pointing to the head of the first list
}

/**
 * Sorts a chain of linked memory given a start node and a size.
 * This is the recursive helper for the Mergesort algorithm (i.e., this is
 * the divide-and-conquer step).
 *
 * Called by the public sort function in List-given.hpp
 *
 * @param start Starting point of the chain.
 * @param chainLength Size of the chain to be sorted.
 * @return A pointer to the beginning of the now sorted chain.
 */
template <typename T>
typename List<T>::ListNode* List<T>::mergesort(ListNode * start, int chainLength) {
  /// @todo Graded in MP3.2
if(chainLength == 1){
  return start;
}
ListNode* List2header = split(start,chainLength);
ListNode* Merge1 = mergesort(start, chainLength/2);
ListNode* Merge2 = mergesort(List2header, chainLength-chainLength/2);
ListNode* Output = merge(Merge1,Merge2);
  return Output;
}
