require_relative "./item.rb"

class List
    attr_accessor :label
    
    def initialize(label)
        @label = label
        @items = Array.new
    end

    def add_item(title, deadline, *description)
        description = [""] if description.empty?
        
        if Item.valid_date?(deadline)
            @items.push(Item.new(title, deadline, description.first))
            return true
        else
            return false
        end
    end

    def size
        @items.length
    end

    def valid_index?(index)
        index >= 0 && index < @items.length
    end

    def swap(index_1, index_2)
        if self.valid_index?(index_1) && self.valid_index?(index_2)
            @items[index_1], @items[index_2] = @items[index_2], @items[index_1]
            return true
        else
            return false
        end
    end

    def [](index)
        if self.valid_index?(index)
            return @items[index]
        else
            return nil
        end
    end

    def priority
        @items.first
    end

    def print
        puts "".ljust(75, "-")
        puts @label.upcase.center(75)
        puts "".ljust(75, "-")
        puts "#{"Index".ljust(10)}|#{"Item".ljust(50)}|#{"Deadline".ljust(10)}"
        puts "".ljust(75, "-")
        @items.each_with_index do |item, idx|
            puts "#{idx.to_s.ljust(10)}|#{item.title.ljust(50)}|#{item.deadline.ljust(10)}"
        end
        puts "".ljust(75, "-")
    end

    def print_full_item(index)
        puts "".ljust(50, "-")
        puts @items[index].title.ljust(40) + @items[index].deadline.ljust(10)
        puts @items[index].description.ljust(50)
        puts "".ljust(50, "-")
    end

    def print_priority
        self.print_full_item(0)
    end

    def up(index, *entered_amount)
        if entered_amount.empty?
            amount = 1
        else
            amount = entered_amount.first
        end 

        if self.valid_index?(index)
            until amount == 0 || index == 0
                @items[index], @items[index - 1] = @items[index - 1], @items[index]
                index -= 1
                amount -=1
            end
            return true
        else
            return false
        end
    end

    def down(index, *entered_amount)
        if entered_amount.empty?
            amount = 1
        else
            amount = entered_amount.first
        end 

        if self.valid_index?(index)
            until amount == 0 || index == @items.length - 1
                @items[index], @items[index + 1] = @items[index + 1], @items[index]
                index += 1
                amount -=1
            end
            return true
        else
            return false
        end
    end

    def sort_by_date!
        @items.sort_by! { |item| item.deadline }
    end
end