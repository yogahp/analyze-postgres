class AnalyzeJobService < BaseService
  def self.execute
    ActiveRecord::Base.connection.tables.each do |table_name|
      Pg::AnalyzeJob.perform_async(table_name)
    end
  end

  def self.remove
    ActiveRecord::Base.connection.tables.each do |table_name|
      Rails.cache.delete("table_#{table_name}")
    end
  end
end