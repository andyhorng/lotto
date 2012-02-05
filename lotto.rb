#!/usr/bin/env ruby

require 'pry'
require 'colorize'

class LuckyNumber

  attr_reader :nums

  def initialize
    begin
      @nums = gets.split.uniq
    end until valid?
    @nums = @nums.map {|num| num.to_i}.sort
  end

  def valid?
    return true if @nums.empty?
    return false if @nums.length != 6 
    @nums.detect { |n| !n =~ /\d+/ } and return false
    @nums.detect { |n| n.to_i > 49 } and return false
    return true
  end

  def vs(lotto_number)
    enum = @nums.each
    lotto_enum = lotto_number.nums.each

    result = []
    loop do
      begin
        if enum.peek == lotto_enum.peek
          result << enum.next.to_s.red
          lotto_enum.next
        elsif enum.peek > lotto_enum.peek
          lotto_enum.next
        else
          result << enum.next.to_s
        end
        # rest
      rescue StopIteration
        result.concat(rest_of(enum))
        puts result.join(", ") 
        break
      end
    end
  end

  def rest_of(enum)
    rest = []
    loop do
      begin
        rest << enum.next
      rescue StopIteration
        return rest
      end
    end
  end

end


class Main
  def initialize

    @lucky_numbers = []
    i = 0 
    loop do
      i += 1
      puts "lucky number #{i}:"
      lucky_number = LuckyNumber.new
      break if lucky_number.nums.empty?
      @lucky_numbers << lucky_number
    end

    puts "lotto number: "
    @lotto_numbers = []
    i = 0
    loop do
      i += 1
      puts "lotto number #{i}:"
      lotto_number = LuckyNumber.new
      break if lotto_number.nums.empty?
      @lotto_numbers << lotto_number
    end

    # overview
    puts "your lucky numbers:"
    @lucky_numbers.each do |lucky_number|
      puts lucky_number.nums.to_s
    end
    puts "your lotto numbers:"
    @lotto_numbers.each do |lotto_number|
      puts lotto_number.nums.to_s
    end
  end

  def go
    @lotto_numbers.each do |lotto_number|
      puts lotto_number.nums.to_s.green
      @lucky_numbers.each do |lucky_number|
        print "\t"
        lucky_number.vs(lotto_number)
      end
    end
  end
end


main = Main.new
main.go
