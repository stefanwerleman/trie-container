# Stefan F. Werleman
# University of Central Florida
# Copyright 2020, Stefan F. Werleman, All rights reserved.

# This is a Ruby Trie container class that can be used in different programs.

# Node class that holds the path to each letter in the alphabet
class TrieNode
   attr_accessor :count, :children, :childCount;

   def initialize
      @count = 0;
      @childCount = 0;
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

      @size += 1;

      string = string.downcase();
      aux = @root;

      string.each_char { |c|
         index = c.ord - 'a'.ord;

         if aux.children[index] == nil
            aux.children[index] = TrieNode.new();
            aux.childCount += 1;
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
      string = string.downcase();

      return (contains(string)) ? string : nil;
   end

   # removes and returns the string if it exist
   # otherwise returns nil
   def remove(string)
      if string == nil
         return nil;
      end

      string = string.downcase();

      prevSize = @size;
      @root = remove_helper(@root, string, 0);

      if @root == nil || prevSize != @size
         return string;
      else
         return nil;
      end
   end

   def remove_helper(root, string, k)
      if k >= string.length()
         if root.count > 1
            root.count -= 1;
         elsif root.childCount > 0
            root.count = 0;
         else
            root = nil;
         end

         @size -= 1;
         return root;
      end

      index = string[k].ord - 'a'.ord;

      if root.children[index] != nil
         root.children[index] = remove_helper(root.children[index], string, k + 1);
      else
         return root;
      end

      if root.children[index] == nil
         root.childCount -= 1;
      end

      if root.count > 0 || root.childCount > 0
         return root;
      end

      return nil;
   end

   # true -> if trie contains the string
   # false -> if it does not exist in the trie
   def contains(string)
      if string == nil
         return false;
      end

      string = string.downcase();

      aux = @root;

      string.each_char { |c|
         index = c.ord - 'a'.ord;

         if aux.children[index] == nil
            return false;
         end

         aux = aux.children[index];
      }

      if aux.count > 0
         return true;
      else
         return false;
      end
   end

   # Prints all the strings and their frequency that are in the Trie
   def print
      if is_empty()
         puts("(Trie is empty)");
         return;
      end

      buffer = "";

      print_helper(@root, buffer, 0);
   end

   # recursive method to traverse
   def print_helper(root, buffer, k)
      if root == nil
         return;
      end

      if root.count > 0
         puts("%s (%d)" % [buffer, root.count]);
      end

      buffer += "";

      for i in 0..25
         if (root.children[i] != nil)
            buffer[k] = (i + 'a'.ord).chr;
            print_helper(root.children[i], buffer, k + 1);
         end
      end
   end

   # Returns an array representation of the Trie in alphabetical order
   # returns an empty array if Trie is empty
   def to_array
      if is_empty
         return Array.new();
      end

      buffer = "";

      return to_array_helper(@root, buffer, Array.new(), 0);
   end

   def to_array_helper(root, buffer, array, k)
      if root == nil
         return nil;
      end

      if root.count > 0
         array.insert(array.length, buffer);
      end

      buffer += "";

      for i in 0..25
         if (root.children[i] != nil)
            buffer[k] = (i + 'a'.ord).chr;
            to_array_helper(root.children[i], buffer, array, k + 1);
         end
      end

      return array;
   end
end
