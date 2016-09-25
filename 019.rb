def first_day_of_each_year
  collection = [0, 1]
  (2..100).each do |year|
    if year % 4 == 1
      collection << (collection.last + 366) % 7
    else
      collection << (collection.last + 365) % 7
    end
  end
  collection
end

p first_day_of_each_year

# def first_day_of_month(year, month)
#
# end
