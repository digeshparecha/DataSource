# frozen_string_literal: true

class EndOfDayWorker
  include Sidekiq::Worker

  def perform
    Rails.logger.debug { "Running EndOfDayJob at #{Time.zone.now}" }

    # Fetch data from Redis
    redis_data = redis.hgetall('hourly_records')

    male_count = redis_data['male_count'].to_i
    female_count = redis_data['female_count'].to_i

    DailyRecord.create!(male_count:, female_count:)
    avgerage_male_female_age
  end

  def avgerage_male_female_age
    if male_count_previously_changed?
      males = User.where(gender: 'male')
      males_average_age = males.sum / males.length.to_f
      daily_record.update! male_avg_age: males_average_age
    end
    return unless female_count_previously_changed?

    females = User.where(gender: 'female')
    females_average_age = females.sum / females.length.to_f
    daily_record.update! female_avg_age: females_average_age
  end
end
