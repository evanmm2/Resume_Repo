/**
 * @file common_words.cpp
 * Implementation of the CommonWords class.
 *
 * @author Zach Widder
 * @date Fall 2014
 */

#include "common_words.h"

#include <fstream>
#include <string>
#include <vector>
#include <iostream>
#include <iterator>
#include <algorithm>

using std::string;
using std::vector;
using std::ifstream;
using std::cout;
using std::endl;
using std::feof;

string remove_punct(const string& str)
{
    string ret;
    std::remove_copy_if(str.begin(), str.end(), std::back_inserter(ret),
                        std::ptr_fun<int, int>(&std::ispunct));
    return ret;
}

CommonWords::CommonWords(const vector<string>& filenames)
{
    // initialize all member variables
    init_file_word_maps(filenames);
    init_common();
}

void CommonWords::init_file_word_maps(const vector<string>& filenames)
{
    // make the length of file_word_maps the same as the length of filenames
    file_word_maps.resize(filenames.size());

    // go through all files
    for (size_t i = 0; i < filenames.size(); i++) {
        // get the corresponding vector of words that represents the current
        // file
        vector<string> words = file_to_vector(filenames[i]);
        /* Your code goes here! */
        for(size_t j = 0; j < words.size(); j++){
          string word = words[j];
          map<string, unsigned int>::iterator lookup = file_word_maps[i].find(word);
          if (lookup != file_word_maps[i].end()) {
              file_word_maps[i][word] = file_word_maps[i][word] + 1;
          }
          else{
            file_word_maps[i].insert(std::pair<string, unsigned int>(word, 1) );
          }
        }
    }
}

void CommonWords::init_common()
{
    /* Your code goes here! */
    for(size_t j = 0; j < file_word_maps.size(); j++){   //This checks each of the individual maps
      map<string, unsigned int>::iterator lookup = file_word_maps[j].begin();
      map<string, unsigned int>::iterator end = file_word_maps[j].end();
      for(; lookup != end; lookup++){                         // Now we need for it to check all of the strings and put them into one map


        string word = lookup->first;      // Looks at the string value
        map<string, unsigned int>::iterator find = common.find(word);   //Looks for that specific word in our common map
        if (find != common.end()) {                          // If that word exists in our common map, then add
            common[word] = common[word] + 1;
        }
        else{
          common.insert(std::pair<string, unsigned int>(lookup->first, 1) );
        }
    }
  }
}

/**
 * @param n The number of times to word has to appear.
 * @return A vector of strings. The vector contains all words that appear
 * in each file >= n times.
 */
vector<string> CommonWords::get_common_words(unsigned int n) const
{
    vector<string> out;
    /* Your code goes here! */
     map<string, unsigned int>::const_iterator  lookup = common.begin();
     map<string, unsigned int>::const_iterator  end = common.end();

     for(; lookup != end; lookup++){
     if(file_word_maps.size()  == lookup->second){
       for(size_t j = 0; j < file_word_maps.size(); j++){ //Goes through each of the maps

       map<string, unsigned int>::const_iterator  inner = file_word_maps[j].find(lookup->first); // Finds the string with the number of times it's seen in that map
        if(inner->second < n){

          break;

        }
        //if it hasn't broken yet at the very end of the looping, add it


        if(j == file_word_maps.size() - 1){
          out.push_back(lookup->first);
        }

       }

     }
   }



    return out;
}

/**
 * Takes a filename and transforms it to a vector of all words in that file.
 * @param filename The name of the file that will fill the vector
 */
vector<string> CommonWords::file_to_vector(const string& filename) const
{
    ifstream words(filename);
    vector<string> out;

    if (words.is_open()) {
        std::istream_iterator<string> word_iter(words);
        while (!words.eof()) {
            out.push_back(remove_punct(*word_iter));
            ++word_iter;
        }
    }
    return out;
}
