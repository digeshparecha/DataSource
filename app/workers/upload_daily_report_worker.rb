# frozen_string_literal: true

class UploadDailyReportWorker
  include Sidekiq::Worker

  def perform
    Rails.logger.debug { "Running EndOfDayJob at #{Time.zone.now}" }

    # Fetch data from Redis
    redis_data_service = RedisDataStoreService.new

    DailyRecord.create!(date: Time.zone.today, male_count: redis_data_service.male_count,
                        female_count: redis_data_service.female_count)

    redis_data_service.reset
  end
end
