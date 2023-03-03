module GameConcern

  def booked_dates
    # returns an array of arrays of start and end dates of all pokemon's bookings
    bookings.accepteds.pluck(:start_date, :end_date)
  end

  def stringified_booked_dates
    # Returns an array of arrays of start and end dates of all bookings of
    # the Pokemon but in stringified format: "1991-12-28".
    booked_dates.deep_map(&:to_s)
  end

  def booked_dates_hashes
    stringified_booked_dates.map do |dates|
      {
        from: dates.first,
        to: dates.last
      }
    end
  end

  def flatpickr_booked_dates
    {
      dateFormat: "Y-m-d",
      disable: booked_dates_hashes
    }.to_json
  end
end
