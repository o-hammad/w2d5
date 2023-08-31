# Flight Project

In this project, you will implement a very simple flight booking and boarding
app.

## Instructions

Download the project skeleton below and upload your work when you are finished.

See the "Practice Instructions" reading under W1D1->PROJECTS in the sidebar if
you need help downloading, opening, or uploading the project.

This practice uses RSpec tests to guide and check your work. Run `bundle
install` in your terminal to set up the project. Then run `bundle exec rspec`.
The tests should all fail. Your job is to implement the classes and methods
outlined by the RSpec output. Do this in the corresponding __lib/__ files.

Work until all the specs are green/passing. Look at the __spec/__ files to get
additional clarity or hints on how to satisfy specific specs.

You may find the following RSpec commands useful:

To run all the specs: `bundle exec rspec`  
To run specs in a particular file, e.g., __01_flight_spec.rb__: `bundle exec rspec spec/01_flight_spec.rb`  
To run the spec that begins, e.g., on line 25: `bundle exec rspec spec/01_flight_spec.rb:25`

A high-level overview of this project follows below, but pay attention to RSpec
especially.

## Passenger

In this project, a `Passenger` class will store information about a single
passenger and the flight numbers for which they are booked. Note that a single
`Passenger` can book multiple flights. `Passenger` must support the following
attributes and instance methods:

+ Attributes
  + `@name`
  + `@flight_numbers`
+ Instance Methods
  + `#initialize`
  + `#name`
  + `#has_flight?`
  + `#add_flight`

## Flight

The `Flight` class will store information about a single flight, identified by
its `@flight_number`. A passenger can only board the flight if they have booked
the `@flight_number`. `Flight` must support the following attributes and
instance methods:

+ Attributes
  + `@flight_number`
  + `@capacity`
  + `@passengers`
+ Instance Methods
  + `#initialize`
  + `#passengers`
  + `#full?`
  + `#board_passenger`
  + `#list_passengers`
  + `#[]`
  + `#<<`