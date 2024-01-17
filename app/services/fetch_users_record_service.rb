# frozen_string_literal: true

class FetchUsersRecordService
  def initialize(api)
    @api = api
  end

  def fetch_data
    data = HTTParty.get(@api)
    data['results'].each do |record|
      uuid = record.dig('login', 'uuid')

      existing_user = User.find_by(uuid:)

      if existing_user
        # If the user with the same uuid exists, update the attributes
        existing_user.update!(
          gender: record['gender'],
          name: record['name'],
          location: record['location'],
          age: record.dig('dob', 'age')
        )
      else
        # If the user with the uuid doesn't exist, create a new user
        User.create!(
          uuid:,
          gender: record['gender'],
          name: record['name'],
          location: record['location'],
          age: record.dig('dob', 'age')
        )
      end
    end
    male_count = User.where(gender: 'male').count
    female_count = User.where(gender: 'female').count
    Redis.new.hmset('hourly_records','male_count',male_count,'female_count',female_count)
  end
end
