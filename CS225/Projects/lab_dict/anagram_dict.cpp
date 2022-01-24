/**
 * @file anagram_dict.cpp
 * Implementation of the AnagramDict class.
 *
 * @author Matt Joras
 * @date Winter 2013
 */

#include "anagram_dict.h"

#include <algorithm> /* I wonder why this is included... */
#include <fstream>

using std::string;
using std::vector;
using std::ifstream;

/**
 * Constructs an AnagramDict from a filename with newline-separated
 * words.
 * @param filename The name of the word list file.
 */
AnagramDict::AnagramDict(const string& filename)
{
    /* Your code goes here! */
    ifstream wordsFile(filename);  // Opens file accordin gto given code
    string word;
    if(wordsFile.is_open()) {     //
      while (getline(wordsFile, word)){
        string x = word;
        std::sort(x.begin(), x.end()); //Makes the anagram sorted key
        dict[x].push_back(word);    // Uses that key and pushes back the word that could make it at that location
    }
  }
}

/**
 * Constructs an AnagramDict from a vector of words.
 * @param words The vector of strings to be used as source words.
 */
AnagramDict::AnagramDict(const vector<string>& words)
{
    /* Your code goes here! */
    for(size_t i = 0; i < words.size(); i++){
      string x = words[i];    // gets the word out of the location
      std::sort(x.begin(), x.end()); //Makes the anagram sorted key
      dict[x].push_back(words[i]);    // Uses that key and pushes back the word that could make it at that location
    }
}

/**
 * @param word The word to find anagrams of.
 * @return A vector of strings of anagrams of the given word. Empty
 * vector returned if no anagrams are found or the word is not in the
 * word list.
 */
vector<string> AnagramDict::get_anagrams(const string& word) const
{
    /* Your code goes here! */

    string x = word;    // Make a copy of word
    std::sort(x.begin(), x.end()); //Makes the anagram sorted key
    if(dict.find(x) == dict.end()){
      return vector<string>();
    }
    return dict.find(x)->second;
}

/**
 * @return A vector of vectors of strings. Each inner vector contains
 * the "anagram siblings", i.e. words that are anagrams of one another.
 * NOTE: It is impossible to have one of these vectors have less than
 * two elements, i.e. words with no anagrams are ommitted.
 */
vector<vector<string>> AnagramDict::get_all_anagrams() const
{
    /* Your code goes here! */    //We need to have it go through the anagrammed dictionary and push back a vector
    vector<vector<string>> x;
    std::map<std::string, std::vector<std::string>>::const_iterator lookup = dict.begin();
    std::map<std::string, std::vector<std::string>>::const_iterator end = dict.end();

    for(; lookup!=end; lookup++){
      if(lookup->second.size() < 2){
        continue;
      }
      x.push_back(lookup->second);
    }

    return x;
}
