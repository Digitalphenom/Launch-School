#! /usr/bin/env ruby

require "pg"
require "bundler/setup"

command = ARGV.first
DB = PG.connect(dbname:"expenses")

#◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

def display_list_expense
  result = DB.exec("SELECT * FROM expenses")

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

def display_error
  puts "You must provide an amount and memo"
end

def add_expenses
  type, amount, memo = ARGV
  require 'pry-byebug'; binding.pryc
  return display_error if amount.nil? || memo.nil?
  sql = "INSERT INTO expenses(amount, memo, created_on) VALUES('#{amount}', '#{memo}', NOW())"
  DB.exec(sql)
end

#◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

if ARGV.empty?
  display_help
elsif command == "list"
  display_list_expense
elsif command == "add"
  add_expenses
else
  puts "Invalid command"
end

# We use a `<<-` to display our content in the format in which we write it rather than needing to manually insert `\n` chars.