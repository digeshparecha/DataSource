# frozen_string_literal: true

class HourlyWorker
  include Sidekiq::Worker

  def perform
    # Your job logic goes here
    Rails.logger.debug { "Running HourlyJob at #{Time.zone.now}" }
    api = 'https://randomuser.me/api/?results=20'
    FetchUsersRecordService.new(api).fetch_data
  end
end
