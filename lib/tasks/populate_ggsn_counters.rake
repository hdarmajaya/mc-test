namespace :db do
  desc 'Load sample entries in database'
  task :load_db => :environment do
    require 'securerandom'

    def random_count
      rand(1..1000)
    end

    def random_filename
      "#{SecureRandom.hex}.gz"
    end
  
    # Delete data
    GgsnCounter.delete_all

    #start_date = Date.today.beginning_of_year
    start_date = Date.today - 100
    end_date = Date.today

    (start_date..end_date).each do |date|
      puts date
      (0..23).each do |hour|
        calltime = DateTime.new(date.year, date.month, date.day, hour)

        (1..rand(5)).each do |record|
          filename = random_filename
          out_count = random_count
          mal_count = random_count
          mis_count = random_count
          zero_count = random_count
          min_count = random_count
          in_count = out_count + mal_count + mis_count + zero_count + min_count

          GgsnCounter.create!(filename: filename,
                              calltime: calltime,
                              malformed_data: mal_count,
                              min_too_low: min_count,
                              missing_data: mis_count,
                              zero_value: zero_count,
                              records_out: out_count,
                              records_in: in_count)
        end
      end
    end
  end
end
