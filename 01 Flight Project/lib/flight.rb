class Flight
    attr_reader :passengers
    
    def initialize(flight_num, capacity)
        @flight_number = flight_num
        @capacity = capacity
        @passengers = Array.new
    end

    def full?
        @passengers.length >= @capacity
    end

    def board_passenger(passenger_name)
        @passengers << passenger_name if !self.full? && passenger_name.has_flight?(@flight_number)
    end

    def list_passengers
        @passengers.map { |passenger| passenger.name }
    end

    def [](index)
        @passengers[index]
    end

    def <<(passenger_name)
        board_passenger(passenger_name)
    end
end