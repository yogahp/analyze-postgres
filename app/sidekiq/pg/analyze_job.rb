require 'csv'

class Pg::AnalyzeJob
  include Sidekiq::Job

  def perform(table_name)
    sql = "analyze verbose #{table_name}"
    status = Rails.cache.read("table_#{table_name}")

    # puts "STATUS: #{status}"

    if status != true
      if ActiveRecord::Base.connection.execute(sql)
        Rails.cache.write("table_#{table_name}", true)
        # status = Rails.cache.read(table_name)

        # puts "STATUS: #{status}"
      end
    end
  end
end
