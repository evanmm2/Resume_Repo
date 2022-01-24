/**
 * @file lphashtable.cpp
 * Implementation of the LPHashTable class.
 */
#include "lphashtable.h"

template <class K, class V>
LPHashTable<K, V>::LPHashTable(size_t tsize)
{
    if (tsize <= 0)
        tsize = 17;
    size = findPrime(tsize);
    table = new std::pair<K, V>*[size];
    should_probe = new bool[size];
    for (size_t i = 0; i < size; i++) {
        table[i] = NULL;
        should_probe[i] = false;
    }
    elems = 0;
}

template <class K, class V>
LPHashTable<K, V>::~LPHashTable()
{
    for (size_t i = 0; i < size; i++)
        delete table[i];
    delete[] table;
    delete[] should_probe;
}

template <class K, class V>
LPHashTable<K, V> const& LPHashTable<K, V>::operator=(LPHashTable const& rhs)
{
    if (this != &rhs) {
        for (size_t i = 0; i < size; i++)
            delete table[i];
        delete[] table;
        delete[] should_probe;

        table = new std::pair<K, V>*[rhs.size];
        should_probe = new bool[rhs.size];
        for (size_t i = 0; i < rhs.size; i++) {
            should_probe[i] = rhs.should_probe[i];
            if (rhs.table[i] == NULL)
                table[i] = NULL;
            else
                table[i] = new std::pair<K, V>(*(rhs.table[i]));
        }
        size = rhs.size;
        elems = rhs.elems;
    }
    return *this;
}

template <class K, class V>
LPHashTable<K, V>::LPHashTable(LPHashTable<K, V> const& other)
{
    table = new std::pair<K, V>*[other.size];
    should_probe = new bool[other.size];
    for (size_t i = 0; i < other.size; i++) {
        should_probe[i] = other.should_probe[i];
        if (other.table[i] == NULL)
            table[i] = NULL;
        else
            table[i] = new std::pair<K, V>(*(other.table[i]));
    }
    size = other.size;
    elems = other.elems;
}

template <class K, class V>
void LPHashTable<K, V>::insert(K const& key, V const& value)
{

    /**
     * @todo Implement this function.
     *
     * @note Remember to resize the table when necessary (load factor >= 0.7).
     * **Do this check *after* increasing elems (but before inserting)!!**
     * Also, don't forget to mark the cell for probing with should_probe!
     */
     elems = elems + 1;             // The total number of elements should be increased
     if((double)elems/size >= .7){
     resizeTable();
     }

     size_t i = hashes::hash(key, size);
     while(table[i] != NULL){
       i = i + 1;
       if(i == size){
         i = 0;
       }
     }

     table[i] = new std::pair <K, V>(key, value);
     should_probe[i] = true;
}

template <class K, class V>
void LPHashTable<K, V>::remove(K const& key)
{
    /**
     * @todo: implement this function
     */
     size_t i = findIndex(key);
     delete table[i];
     table[i] = NULL;
     elems = elems - 1;
}

template <class K, class V>
int LPHashTable<K, V>::findIndex(const K& key) const
{

    /**
     * @todo Implement this function
     *
     * Be careful in determining when the key is not in the table!
     */
     // What do we need to do here? We need to have the index and loop around the table looking for it
     size_t index = hashes::hash(key,size);

     size_t start = index;

     while(1==1){       // Infinite loop. Will only break when either the condition is met for finding the key or the index loops back to the start
       if(table[index]!=NULL){
         if(table[index]->first == key){
           return index;
         }
       }
       index  = index + 1;
       if(index == size){
         index = 0;
       }
       if(index == start){
         return -1;
       }
     }


    return -1;
}

template <class K, class V>
V LPHashTable<K, V>::find(K const& key) const
{
    int idx = findIndex(key);
    if (idx != -1)
        return table[idx]->second;
    return V();
}

template <class K, class V>
V& LPHashTable<K, V>::operator[](K const& key)
{
    // First, attempt to find the key and return its value by reference
    int idx = findIndex(key);
    if (idx == -1) {
        // otherwise, insert the default value and return it
        insert(key, V());
        idx = findIndex(key);
    }
    return table[idx]->second;
}

template <class K, class V>
bool LPHashTable<K, V>::keyExists(K const& key) const
{
    return findIndex(key) != -1;
}

template <class K, class V>
void LPHashTable<K, V>::clear()
{
    for (size_t i = 0; i < size; i++)
        delete table[i];
    delete[] table;
    delete[] should_probe;
    table = new std::pair<K, V>*[17];
    should_probe = new bool[17];
    for (size_t i = 0; i < 17; i++)
        should_probe[i] = false;
    size = 17;
    elems = 0;
}

template <class K, class V>
void LPHashTable<K, V>::resizeTable()
{
    // This is very similar to Dhhash resizeTable
    /**
     * @todo Implement this function
     *
     * The size of the table should be the closest prime to size * 2.
     *
     * @hint Use findPrime()!
     */
     size_t newSize = findPrime(size * 2);                            // Sets the new size for the array
     std::pair<K, V>** newTable = new std::pair<K, V>*[newSize];      // Sets the new temporary array that is resized
     bool* probe = new bool[newSize];                                 // Sets up a new tempotary array for the bool values
     delete [] should_probe;                                          // Deletes the original set of values.
     should_probe = probe;                                            // Sets the old bool array to the new size, uninitialized
     for(unsigned i = 0; i < newSize; i++){                           // In the array size for the two new tables, they are initialized
       newTable[i] = NULL;
       should_probe[i] = false;
     }

     for(unsigned i = 0; i < size; i++){
       if(table[i] != NULL){                                          // If it's null, don't do this for that set

       size_t hashLocation = hashes::hash(table[i]->first, newSize);  // If it's not null, find the new array index location using the old table key and the new size
       while(newTable[hashLocation] != NULL){                         // If the new location is not null, then we increase the index.
         hashLocation = hashLocation + 1;
         if(hashLocation == newSize){                                 // If the index reaches the max size of the array, then we loop it back to location 0 again
           hashLocation = 0;
         }
       }

      newTable[hashLocation] = table[i];                              // Once the proper location is found, the previous table pointer location is copied to the new accepted location
      should_probe[hashLocation] = true;                              // The probe location is also now evaluated to true
    }
}
  delete [] table;                                                    // The old table itself was destroyed, but the things in the pointers are left untouched
  table = newTable;                                                   // The new table is copied over
  size = newSize;                                                     // The new size is changed
}
