/**
 * @file quackfun.cpp
 * This is where you will implement the required functions for the
 * stacks and queues portion of the lab.
 */

namespace QuackFun {

/**
 * Sums items in a stack.
 *
 * **Hint**: think recursively!
 *
 * @note You may modify the stack as long as you restore it to its original
 * values.
 *
 * @note You may use only two local variables of type T in your function.
 * Note that this function is templatized on the stack's type, so stacks of
 * objects overloading the + operator can be summed.
 *
 * @note We are using the Standard Template Library (STL) stack in this
 * problem. Its pop function works a bit differently from the stack we
 * built. Try searching for "stl stack" to learn how to use it.
 *
 * @param s A stack holding values to sum.
 * @return  The sum of all the elements in the stack, leaving the original
 *          stack in the same state (unchanged).
 */
template <typename T>
T sum(stack<T>& s)
{
if(s.size()==1)
  return s.top();
  T original = s.top();
  s.pop();
  T result = sum(s) + original;
  s.push(original);
  return result;

// We want to pop it sum it, push it back on

    // Your code here
   // stub return value (0 for primitive types). Change this!
                // Note: T() is the default value for objects, and 0 for
                // primitive types
}

/**
 * Checks whether the given string (stored in a queue) has balanced brackets.
 * A string will consist of square bracket characters, [, ], and other
 * characters. This function will return true if and only if the square bracket
 * characters in the given string are balanced. For this to be true, all
 * brackets must be matched up correctly, with no extra, hanging, or unmatched
 * brackets. For example, the string "[hello][]" is balanced, "[[][[]a]]" is
 * balanced, "[]]" is unbalanced, "][" is unbalanced, and "))))[cs225]" is
 * balanced.
 *
 * For this function, you may only create a single local variable of type
 * `stack<char>`! No other stack or queue local objects may be declared. Note
 * that you may still declare and use other local variables of primitive types.
 *
 * @param input The queue representation of a string to check for balanced brackets in
 * @return      Whether the input string had balanced brackets
 */
bool isBalanced(queue<char> input)
{
stack<char> Counter;
char z;
  for(unsigned i = 0; i < input.size(); i++){
    z = input.front();
    if(z == ']' && Counter.size() == 0){
      return false;
    }
    if(z == '['){
      Counter.push(z);
    }
    if(z == ']'){
      Counter.pop();
    }
    input.pop();
    input.push(z);

    }

    if(Counter.size() != 0){
      return false;}
    return true;



    // @TODO: Make less optimistic

}

/**
 * Reverses even sized blocks of items in the queue. Blocks start at size
 * one and increase for each subsequent block.
 *
 * **Hint**: You'll want to make a local stack variable.
 *
 * @note Any "leftover" numbers should be handled as if their block was
 * complete.
 *
 * @note We are using the Standard Template Library (STL) queue in this
 * problem. Its pop function works a bit differently from the stack we
 * built. Try searching for "stl stack" to learn how to use it.
 *
 * @param q A queue of items to be scrambled
 */
template <typename T>
void scramble(queue<T>& q)
{
    stack<T> s;
    // optional: queue<T> q2;
    unsigned d = 0; //d is a dummy variable
    unsigned x = 0; // x is our operation counter
    int flag = 0;
    unsigned g = 0; //total count

    unsigned i; // For loop variables
    unsigned j;


for(i = 0; i < q.size(); d++){
      if(x%2 == 0){            // If we are on an even operation, keep them the same
        x = x+1;              // Increment x so we know what function we are on
        g = g+x;
        while((g)>q.size()){     // We need to watch for overcounting, without incrementing
          x = x-1;                 // Decrement x down so that the process isn't done too many times
          flag = 1;             // Flag that we are done with the process
          g = g-1;
        }
        for(j = 0; j < x; j++){  // Go through each variable and shove it back to front
          q.push(q.front());  //Move the variable to the back
          q.pop();            // Delete it's copy at the front
        }
        if(flag==1){
          break;
        }
}
        else{
          x = x+1;                  // Increments function index
          g = g+x;

          while((g)>q.size()){     // We need to watch for overcounting, without incrementing i
          x = x-1;                 // Decrement x down so that the process isn't done too many times
          flag = 1;             // Flag that we are done with the process
          g = g-1;
        }
        for(j = 0; j < x; j++){   //Add to stack
          s.push(q.front());
          q.pop();
        }
        for(j = 0; j < x; j++){   //Add back to queue
          q.push(s.top());
          s.pop();
        }
        if(flag==1){
          break;
        }
    }
  }}









    // Your code here


/**
 * Checks if the parameter stack and queue are the same. A stack and a queue
 * are considered to the "the same" if they contain only elements of exactly
 * the same values in exactly the same order.
 *
 * @note You may assume the stack and queue contain the same number of items!
 *
 * @note The back of the queue corresponds to the top of the stack!
 *
 * @note There are restrictions for writing this function.
 * - Your function may not use any loops
 * - In your function you may only declare ONE local boolean variable to use in
 *   your return statement, and you may only declare TWO local variables of
 *   parametrized type T to use however you wish.
 * - No other local variables can be used.
 * - After execution of verifySame, the stack and queue must be unchanged. Be
 *   sure to comment your code VERY well.
 *
 * @param s The stack to compare
 * @param q The queue to compare
 * @return  true if the stack and the queue are the same; false otherwise
 */
template <typename T>
bool verifySame(stack<T>& s, queue<T>& q)
{
    bool retval = true; // optional
    // T temp1; // rename me
    // T temp2; // rename :)

    // Your code here

    return retval;
}
}
