class Item
    attr_accessor :title, :deadline, :description

    def self.valid_date?(date_string)
        date_arr = date_string.split("-").map(&:to_i)

        date_arr[1] >= 1 && date_arr[1] <= 12 && date_arr.last >= 1 && date_arr.last <= 31    
    end

    def initialize(title, deadline, description)
        raise "invalid date" if !Item.valid_date?(deadline)
        
        @title = title
        @deadline = deadline
        @description = description
    end
end


