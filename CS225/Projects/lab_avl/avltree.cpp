/**
 * @file avltree.cpp
 * Definitions of the binary tree functions you'll be writing for this lab.
 * You'll need to modify this file.
 */

template <class K, class V>
V AVLTree<K, V>::find(const K& key) const
{
    return find(root, key);
}

template <class K, class V>
V AVLTree<K, V>::find(Node* subtree, const K& key) const
{
    if (subtree == NULL)
        return V();
    else if (key == subtree->key)
        return subtree->value;
    else {
        if (key < subtree->key)
            return find(subtree->left, key);
        else
            return find(subtree->right, key);
    }
}

template <class K, class V>
void AVLTree<K, V>::rotateLeft(Node*& t)
{
    functionCalls.push_back("rotateLeft"); // Stores the rotation name (don't remove this)
    // your code here
    Node* temp = t;
    t = t->right;
    temp->right = t->left;
    t->left = temp;
    temp->height = std::max(heightOrNeg1(temp->left), heightOrNeg1(temp->right))+1;
    t->height = std::max(heightOrNeg1(t->left), heightOrNeg1(t->right))+1;

}

template <class K, class V>
void AVLTree<K, V>::rotateLeftRight(Node*& t)
{
    functionCalls.push_back("rotateLeftRight"); // Stores the rotation name (don't remove this)
    // Implemented for you:
    rotateLeft(t->left);
    rotateRight(t);
}

template <class K, class V>
void AVLTree<K, V>::rotateRight(Node*& t)
{
    functionCalls.push_back("rotateRight"); // Stores the rotation name (don't remove this)
    // your code here
    Node* temp = t;
    t = t->left;
    temp->left = t->right;
    t->right = temp;
    temp->height = std::max(heightOrNeg1(temp->left), heightOrNeg1(temp->right))+1;
    t->height = std::max(heightOrNeg1(t->left), heightOrNeg1(t->right))+1;
}

template <class K, class V>
void AVLTree<K, V>::rotateRightLeft(Node*& t)
{
    functionCalls.push_back("rotateRightLeft"); // Stores the rotation name (don't remove this)
    // your code here
    rotateRight(t->right);
    rotateLeft(t);
}

template <class K, class V>
void AVLTree<K, V>::rebalance(Node*& subtree)
{
    // your code here
    int balance2;
    int balance = heightOrNeg1(subtree->right) - heightOrNeg1(subtree->left);
    if(balance > 1){
        balance2 = heightOrNeg1(subtree->right->right) - heightOrNeg1(subtree->right->left);
        if(balance2 < 0){
          rotateRightLeft(subtree);
        }
        else{
          rotateLeft(subtree);
        }
      }
    if(balance < -1){
      balance2 = heightOrNeg1(subtree->left->right) - heightOrNeg1(subtree->left->left);
      if(balance2 < 0){
        rotateRight(subtree);
      }
      else{
        rotateLeftRight(subtree);
      }
    }
      subtree->height = std::max(heightOrNeg1(subtree->left),heightOrNeg1(subtree->right)) + 1;
}

template <class K, class V>
void AVLTree<K, V>::insert(const K & key, const V & value)
{
    insert(root, key, value);
}

template <class K, class V>
void AVLTree<K, V>::insert(Node*& subtree, const K& key, const V& value)
{
    // your code here
    if (subtree == NULL) {
        subtree = new Node(key, value);
    }
    else if (subtree->key == key) {
        subtree->value = value;
    }
    else if (key < subtree->key) {
        insert(subtree->left, key, value);
    }
    else {
        insert(subtree->right, key, value);
    }
    rebalance(subtree);
}

template <class K, class V>
void AVLTree<K, V>::remove(const K& key)
{
    remove(root, key);
}

template <class K, class V>
void AVLTree<K, V>::remove(Node*& subtree, const K& key)
{
    if (subtree == NULL){
        return;
      }
    if (key < subtree->key) {
        // your code here
        remove(subtree->left, key);
        rebalance(subtree);
    } else if (key > subtree->key) {
        // your code here
        remove(subtree->right, key);
        rebalance(subtree);
    } else {
        if (subtree->left == NULL && subtree->right == NULL) {
            /* no-child remove */
            // your code here
            delete subtree;
            subtree = NULL;
        } else if (subtree->left != NULL && subtree->right != NULL) {
            /* two-child remove */
            // your code here
            Node* temp = subtree->left;
            while(temp->right!=NULL){
              temp = temp->right;
            }
            swap(subtree, temp);
            remove(subtree->left, key);
        } else {
            /* one-child remove */
            // your code here
            Node* parent = subtree;
            Node* child;
            if(subtree->left!=NULL){
                child = subtree->left;
              }
              else{
                child = subtree->right;
              }
              subtree = child;
              delete parent;
              
            }


        // your code here
        if(subtree != NULL){
        rebalance(subtree);
      }
    }
}
