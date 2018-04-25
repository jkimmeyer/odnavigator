require 'clockwork'
require 'active_support/time' # Allow numeric durations (eg: 1.minutes)

module Clockwork
  handler do |job|
    puts "Running #{job}"
  end

  # handler receives the time when job is prepared to run in the 2nd argument
  # handler do |job, time|
  #   puts "Running #{job}, at #{time}"
  # end

  every(1.week, 'data_portals.harvest_sources', :at => 'Monday 00:00') do
    DataPortal.all.each do |data_portal|
      HarvestAllDataPortals.call
    end
  end
end
