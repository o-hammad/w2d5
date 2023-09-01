# Todo Board, Phase 2: So Little Time, So Much Todo

In this phase of the project, you'll upgrade your code to support the following
features:

1. Enhanced item/list functionality
   * Marking items as done
   * Deleting items
2. Managing multiple lists in a single board

## Extending items and lists

### Item#initialize(title, deadline, description)

Modify this existing method to also initialize a boolean instance variable to
track whether or not the item is `done`. An item should not be `done` by
default.

### Item#toggle, List#toggle_item(index)

The new `Item#toggle` method should "flip" the current state the item. That is,
if the item is done, then change it to not done; if it is not done, then change
it to done.

Don't expose a writer method for the instance variable that tracks the done
state. You want to properly encapsulate all of the data within an `Item`.
Imagine that the user is out to break your program! If they could write to the
instance variable, they could assign it to some non-boolean value. Encapsulation
means that the user can only manipulate the data in ways that the **programmer**
intends.

You need to fully integrate this new feature into your app. Create a
corresponding `List#toggle_item(index)` and modify `TodoBoard#get_command` to
allow a user to utilize this new feature with the input command `toggle
<index>`.

### List#print, #print_full, #print_priority

Since your `Item` contains a new field, update the output of these methods to
also print out a column indicating whether or not the item is done.

### List#remove_item(index)

This method should permanently delete the item of the list at the given index.
If the index is invalid, the method should return `false`. If the deletion is
successful, the method should return `true`. Implement this method so that there
are no awkward gaps in the list after an item is removed. Allow a user to
utilize this new feature by supporting the input command `rm <index>`.

### List#purge

This method should remove all items that are currently marked as done. Correctly
implementing this may be tricky.

### Checkpoint: Are you "done" yet?

You know the drill. Test your code thoroughly before moving forward! Here are
some sample tests to get you started:

```plaintext
[1] pry(main)> load 'todo_board.rb'
[2] pry(main)> my_board = TodoBoard.new('cool-tech-to-learn')
=> #<TodoBoard:0x
 @list=
  #<List:0x
   @items=[],
   @label="cool-tech-to-learn">>
[3] pry(main)> my_board.run

Enter a command: mktodo ruby 2019-12-04
Enter a command: mktodo sql 2019-12-20
Enter a command: mktodo rails 2020-01-06
Enter a command: mktodo javascript 2020-01-08
Enter a command: mktodo react 2020-02-08
Enter a command: mktodo redux 2020-02-15
Enter a command: print
-------------------------------------------------
                COOL-TECH-TO-LEARN
-------------------------------------------------
Index | Item                 | Deadline   | Done
-------------------------------------------------
0     | ruby                 | 2019-12-04 | [ ]
1     | sql                  | 2019-12-20 | [ ]
2     | rails                | 2020-01-06 | [ ]
3     | javascript           | 2020-01-08 | [ ]
4     | react                | 2020-02-08 | [ ]
5     | redux                | 2020-02-15 | [ ]
-------------------------------------------------

Enter a command: toggle 0

Enter a command: print 0
-------------------------------------------------
ruby                            2019-12-04    [✓]

-------------------------------------------------

Enter a command: toggle 0

Enter a command: print
-------------------------------------------------
                COOL-TECH-TO-LEARN
-------------------------------------------------
Index | Item                 | Deadline   | Done
-------------------------------------------------
0     | ruby                 | 2019-12-04 | [ ]
1     | sql                  | 2019-12-20 | [ ]
2     | rails                | 2020-01-06 | [ ]
3     | javascript           | 2020-01-08 | [ ]
4     | react                | 2020-02-08 | [ ]
5     | redux                | 2020-02-15 | [ ]
-------------------------------------------------

Enter a command: toggle 0

Enter a command: toggle 2

Enter a command: toggle 3

Enter a command: print
-------------------------------------------------
                COOL-TECH-TO-LEARN
-------------------------------------------------
Index | Item                 | Deadline   | Done
-------------------------------------------------
0     | ruby                 | 2019-12-04 | [✓]
1     | sql                  | 2019-12-20 | [ ]
2     | rails                | 2020-01-06 | [✓]
3     | javascript           | 2020-01-08 | [✓]
4     | react                | 2020-02-08 | [ ]
5     | redux                | 2020-02-15 | [ ]
-------------------------------------------------

Enter a command: rm 4

Enter a command: print
-------------------------------------------------
                COOL-TECH-TO-LEARN
-------------------------------------------------
Index | Item                 | Deadline   | Done
-------------------------------------------------
0     | ruby                 | 2019-12-04 | [✓]
1     | sql                  | 2019-12-20 | [ ]
2     | rails                | 2020-01-06 | [✓]
3     | javascript           | 2020-01-08 | [✓]
4     | redux                | 2020-02-15 | [ ]
-------------------------------------------------

Enter a command: purge

Enter a command: print
-------------------------------------------------
                COOL-TECH-TO-LEARN
-------------------------------------------------
Index | Item                 | Deadline   | Done
-------------------------------------------------
0     | sql                  | 2019-12-20 | [ ]
1     | redux                | 2020-02-15 | [ ]
-------------------------------------------------
```

Play with your board for a bit. It's really coming together!

## Implementing support for multiple lists

Now it's time for the big one! You've been following some important object
oriented practices up until this point and now it's time to get the pay-off.
Your goal is to now manage multiple `List`s in your `TodoBoard`. Because you
have separated your logic wisely thus far, you should only have to modify your
boards.

### TodoBoard#initialize

`Board` should no longer initialize with a single list. Instead, initialize
a board to contain an empty hash. You will allow the user to create lists at
runtime. This hash will eventually contain list labels as the keys and list
instances as the values. A hash is a great choice here because keys are unique,
much like how you'll want the user to refer to their different lists with unique
labels.

### TodoBoard#get_command

The entirety of this new feature has to do with how the user interfaces with
their many lists, so your only task is to update this method. It is quite an
interesting update though. For your existing commands, the user now needs to
specify **which** list to apply the action to.

It is left to you to determine how best to upgrade this method. Here are all of
the commands you will need to support (note that some of these are new):

* `mklist <new_list_label>`
  * make a new list with the given label
* `ls`
  * print the labels of all lists
* `showall`
  * print all lists
* `mktodo <list_label> <item_title> <item_deadline> <optional_item_description>`
  * add a new item to the specified list with the given information
* `toggle <list_label> <item_index>`
  * toggle "done" for the specified item on the given list
* `rm <list_label> <item_index>`
  * remove the specified item on the given list
* `purge <list_label>`
  * remove all "done" items on the given list
* `up <list_label> <item_index> <optional_amount>`
  * move the specified item higher on the given list
* `down <list_label> <item_index> <optional_amount>`
  * move the specified item higher on the given list
* `swap <list_label> <item_index_1> <item_index_2>`
  * swap the positions of the specified items on the given list
* `sort <list_label>`
  * sort the given list by deadline
* `priority <list_label>`
  * print the all information for the item at the top of the given list
* `print <list_label> <optional_index>`
  * print all items of the given list if index is not provided
  * print the specific item of the given list if index is provided
* `quit`

Finish out your application by making it runnable outside of pry. Simply create
and `#run` an instance of `TodoBoard` at the bottom of __todo_board.rb__. Then
you can execute your app with a simple `ruby todo_board.rb` from the terminal.

Here is an example of your final product in action:

```plaintext
Enter a command: mklist groceries
Enter a command: mklist tech
Enter a command: ls
 groceries
 tech

Enter a command: mktodo groceries butter 2019-10-24
Enter a command: mktodo groceries milk 2019-10-23
Enter a command: mktodo groceries candy 2019-10-31 sugar-free
Enter a command: mktodo groceries toothpaste 2019-10-29
Enter a command: print groceries
-------------------------------------------------
                GROCERIES
-------------------------------------------------
Index | Item                 | Deadline   | Done
-------------------------------------------------
0     | butter               | 2019-10-24 | [ ]
1     | milk                 | 2019-10-23 | [ ]
2     | candy                | 2019-10-31 | [ ]
3     | toothpaste           | 2019-10-29 | [ ]
-------------------------------------------------

Enter a command: print groceries 2
-------------------------------------------------
candy                           2019-10-31    [ ]
sugar-free
-------------------------------------------------

Enter a command: mktodo tech ruby 2019-10-24
Enter a command: mktodo tech rails 2019-11-02
Enter a command: mktodo tech javascript 2019-11-30
Enter a command: showall
-------------------------------------------------
                GROCERIES
-------------------------------------------------
Index | Item                 | Deadline   | Done
-------------------------------------------------
0     | butter               | 2019-10-24 | [ ]
1     | milk                 | 2019-10-23 | [ ]
2     | candy                | 2019-10-31 | [ ]
3     | toothpaste           | 2019-10-29 | [ ]
-------------------------------------------------
-------------------------------------------------
                TECH
-------------------------------------------------
Index | Item                 | Deadline   | Done
-------------------------------------------------
0     | ruby                 | 2019-10-24 | [ ]
1     | rails                | 2019-11-02 | [ ]
2     | javascript           | 2019-11-30 | [ ]
-------------------------------------------------

Enter a command: toggle groceries 1
Enter a command: toggle groceries 3
Enter a command: toggle tech 2
Enter a command: showall
-------------------------------------------------
                GROCERIES
-------------------------------------------------
Index | Item                 | Deadline   | Done
-------------------------------------------------
0     | butter               | 2019-10-24 | [ ]
1     | milk                 | 2019-10-23 | [✓]
2     | candy                | 2019-10-31 | [ ]
3     | toothpaste           | 2019-10-29 | [✓]
-------------------------------------------------
-------------------------------------------------
                TECH
-------------------------------------------------
Index | Item                 | Deadline   | Done
-------------------------------------------------
0     | ruby                 | 2019-10-24 | [ ]
1     | rails                | 2019-11-02 | [ ]
2     | javascript           | 2019-11-30 | [✓]
-------------------------------------------------
```