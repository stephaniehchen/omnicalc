class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    # Library
    @text_split_into_array = @text.gsub(/[^a-z0-9\s]/i, "").downcase.split
    @text_remove_spaces = @text.tr(" ","")
    # End Library

    @word_count = @text_split_into_array.length

    @character_count_with_spaces = @text.mb_chars.length

    @character_count_without_spaces = @text_remove_spaces.mb_chars.length

    @occurrences = @text_split_into_array.count(@special_word.gsub(/[^a-z0-9\s]/i, "").downcase)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    @apr_monthly_percent = @apr/(100*12)
    @rate_times_principal = @apr_monthly_percent*@principal
    @months_neg = -1*@years*12
    @monthly_payment = @rate_times_principal/(1-(1+@apr_monthly_percent)**@months_neg)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    #Library
    @number_of_seconds = @ending-@starting
    #End Library

    @seconds = @number_of_seconds
    @minutes = @number_of_seconds / 60
    @hours = @number_of_seconds / (60*60)
    @days = @number_of_seconds / (60*60*24)
    @weeks = @number_of_seconds / (60*60*24*7)
    @years = @number_of_seconds / (60*60*24*7*52)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end



  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    #Library
    @center = @numbers.count/2

    #End Library

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @sorted_numbers.first

    @maximum = @sorted_numbers.last

    @range = @maximum-@minimum

    @median =  (@sorted_numbers[(@count - 1) / 2] + @sorted_numbers[@count / 2]) / 2.0

    @sum = @numbers.sum

    @mean = @sum/@count

    #Start Variance Calc#
    @array_for_var = []
    @numbers.each do |difference|
      @diff = (difference - @mean)**2
      @array_for_var.push(@diff)
    end
    @sum_array_for_var = @array_for_var.sum

    @variance = @sum_array_for_var/(@count)

    #End Variance Calc#

    @standard_deviation =  Math.sqrt(@variance)

    @mode = @numbers.group_by(&:to_s).values.max_by(&:size).try(:first)



    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
