# Stefan F. Werleman
# University of Central Florida
# Copyright 2020, Stefan F. Werleman, All rights reserved.

# This is a Ruby Trie container class that can be used in different programs.

# Node class that holds the path to each letter in the alphabet
class TrieNode
   attr_accessor :count, :children;

   def initialize
      @count = 0;
      @children = Array.new(26);
   end
end

# Contains the entire Trie and Trie operations (case insensitive)
class Trie
   attr_accessor :size, :root;

   def initialize
      @size = 0;
      @root = TrieNode.new();
   end

   # true -> if trie has no strings
   # false -> if it contains at least 1 string
   def is_empty
      return (@size > 0) ? false : true;
   end

   # returns the number strings currently in the trie
   def size
      return @size;
   end

   # inserts string whether or not it already exists.
   # Case insensitive: store lowercase words
   def add(string)
      # Verify the validity of inputs
      if string == nil
         return false;
      end

      string = string.downcase();
      aux = @root;

      string.each_char { |c|
         index = c.ord - 'a'.ord;

         if aux.children[index] == nil
            aux.children[index] = TrieNode.new();
         end

         aux = aux.children[index];
      }

      aux.count += 1;
      return true;
   end

   # stores the list of strings into the Trie
   def add_all(list)
      # Verify the validity of inputs
      if list == nil || list.length() < 1
         return false
      end

      # calls the method that adds a single string
      list.each { |string|
         add(string);
      }

      return true;
   end

   # returns the string if it exists in the Trie, otherwise nil
   def get(string)

   end

   # removes and returns the string if it exist
   # otherwise returns nil
   def remove(string)

   end

   # true -> if trie contains the string
   # false -> if it does not exist in the trie
   def contains(string)

   end

   # Prints all the strings and their frequency that are in the Trie
   def print

      if is_empty()
         puts("(Trie is empty)");
      end


   end


   # Returns an array representation of the Trie
   # returns an empty array if Trie is empty
   def to_array
      if is_empty
         return Array.new();
      end
   end
end

t = Trie.new();

t.print();
