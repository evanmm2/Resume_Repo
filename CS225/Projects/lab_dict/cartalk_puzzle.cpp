/**
 * @file cartalk_puzzle.cpp
 * Holds the function which solves a CarTalk puzzler.
 *
 * @author Matt Joras
 * @date Winter 2013
 */

#include <fstream>

#include "cartalk_puzzle.h"

using namespace std;

/**
 * Solves the CarTalk puzzler described here:
 * http://www.cartalk.com/content/wordplay-anyone.
 * @return A vector of (string, string, string) tuples
 * Returns an empty vector if no solutions are found.
 * @param d The PronounceDict to be used to solve the puzzle.
 * @param word_list_fname The filename of the word list to be used.
 */
vector<std::tuple<std::string, std::string, std::string>> cartalk_puzzle(PronounceDict d,
                                    const string& word_list_fname)
{
    vector<std::tuple<std::string, std::string, std::string>> ret;

    /* Your code goes here! */

    ifstream wordsFile(word_list_fname);  // Opens file accordin gto given code
    string word;
    if(wordsFile.is_open()) {     //
      while (getline(wordsFile, word)) {
        if(word.length() < 3){          // Cannot have a homophone if less than 3 characters
          continue;                      // Don't break because still wan't to keep checking stuff
        }
        string word1 = word.substr(1); //Gets the second string we are looking for after the first letter
        string word2 = word.substr(0,1) + word.substr(2); //Takes only the first and concatenates it with everything past the second letter
        //Now we need to check if they are homophones
        if(d.homophones(word, word1) && d.homophones(word,word2)){//Use the dictionary d to check if they are homophones and then shove the values into ret
          ret.push_back(std::tuple<string, string, string>(word,word1,word2));
        }
      }

    }

    return ret;
}
