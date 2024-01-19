# frozen_string_literal: true

class FetchUsersRecordService
  API_URL = 'https://randomuser.me/api/?results=20'

  def self.fetch_data
    male_record_count = female_record_count = 0
    data = HTTParty.get(API_URL)
    data['results'].each do |record|
      uuid = record.dig('login', 'uuid')

      user = User.find_or_initialize_by(uuid:)
      user.assign_attributes({
                               gender: record['gender'],
                               name: record['name'],
                               location: record['location'],
                               age: record.dig('dob', 'age')
                             })

      user.save!
      if user.male?
        male_record_count += 1
      elsif user.female?
        female_record_count += 1
      end
    end

    redis_data_service = RedisDataStoreService.new

    redis_data_service.male_count = redis_data_service.male_count + male_record_count
    redis_data_service.female_count = redis_data_service.female_count + female_record_count
    redis_data_service.save
  rescue HTTParty::Error, StandardError => e
    Rails.logger.debug { "An error occurred: #{e.message}" }
  end
end
