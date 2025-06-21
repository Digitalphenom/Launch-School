#! /usr/bin/env ruby

require "pg"
require "bundler/setup"

def display_list_expense
  db = PG.connect(dbname:"expenses")
  result = db.exec("SELECT * FROM expenses")

  result.each do |row|
  puts "#{row['id']}| #{row['created_on'].rjust(5)} | #{row['amount'].rjust (10)} | #{row['memo']}"
  end
end

def display_help
  puts <<-HEREDOC
  An expense recording system

  Commands:

  add AMOUNT MEMO - record a new expense
  clear - delete all expenses
  list - list all expenses
  delete NUMBER - remove expense with id NUMBER
  search QUERY - list expenses with a matching memo field
  HEREDOC
end

if ARGV.empty?
  display_help
else
  display_list_expense
end

# We use a `<<-` to display our content in the format in which we write it rather than needing to manually insert `\n` chars.