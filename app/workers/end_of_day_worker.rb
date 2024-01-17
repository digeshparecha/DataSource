# frozen_string_literal: true

class EndOfDayWorker
  include Sidekiq::Worker

  def perform
    Rails.logger.debug { "Running EndOfDayJob at #{Time.zone.now}" }

    # Fetch data from Redis
    redis = Redis.new
    redis_data = redis.hgetall('hourly_records')

    male_count = redis_data['male_count'].to_i
    female_count = redis_data['female_count'].to_i

    DailyRecord.create!(date: Time.zone.today, male_count:, female_count:)
    redis.hmset('hourly_records', 'male_count', 0, 'female_count', 0)
  end
end
