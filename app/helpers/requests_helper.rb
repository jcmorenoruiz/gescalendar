module RequestsHelper

	 def weekdays_in_date_range(range)
    # You could modify the select block to also check for holidays
    range.select { |d| (1..5).include?(d.wday) }.size
  end
end
