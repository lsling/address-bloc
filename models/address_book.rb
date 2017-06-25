require_relative 'entry'
require "csv"

  class AddressBook
    attr_reader :entries

    def initialize
      @entries = []
    end

  def add_entry(name, phone_number, email)
    index = 0
    entries.each do |entry|
      if name < entry.name
        break
      end
      index+= 1
    end
    entries.insert(index, Entry.new(name, phone_number, email))
  end

# #7 we defined import_from_csv. The method starts by reading the file, using  File.read
  def import_from_csv(file_name)
    csv_text = File.read(file_name)
    csv = CSV.parse(csv_text, headers: true, skip_blanks: true)

    #8, we iterate over the CSV::Table object's rows. On the next line we create a hash for each row
    csv.each do |row|
       row_hash = row.to_hash
       add_entry(row_hash["name"], row_hash["phone_number"], row_hash["email"])
     end
  end

  def binary_search(name)
    # #1 we save the index of the leftmost item in the array in a variable named lower, and the index of rightmost item in the array in upper
     lower = 0
     upper = entries.length - 1

     # #2 we loop while our lower index is less than or equal to our upper index
     while lower <= upper
       # #3 we find the middle index by taking the sum of lower and upper and dividing it by two
       mid = (lower + upper) / 2
       mid_name = entries[mid].name

       # #4 we compare the name that we are searching for, name, to the name of the middle index, mid_name
       if name == mid_name
         return entries[mid]
       elsif name < mid_name
         upper = mid - 1
       elsif name > mid_name
         lower = mid + 1
       end
     end

     # #5 if we divide and conquer to the point where no match is found, we return nil
     return nil
  end

  def annihilate_entries
    entries.clear
  end
end
