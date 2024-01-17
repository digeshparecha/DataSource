# frozen_string_literal: true

class RedisDataStoreService
  attr_accessor :male_count, :female_count

  def initialize
    @redis = Redis.new
    data = @redis.hgetall('hourly_records')
    @male_count = data['male_count'].to_i
    @female_count = data['female_count'].to_i
  end

  def save
    @redis.hmset('hourly_records', 'male_count', @male_count, 'female_count', @female_count)
  end

  def reset
    @male_count = 0
    @female_count = 0
    save
  end
end
