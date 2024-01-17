# frozen_string_literal: true

class FetchUserDataWorker
  include Sidekiq::Worker

  def perform
    # Your job logic goes here
    Rails.logger.debug { "Running HourlyJob at #{Time.zone.now}" }
    FetchUsersRecordService.fetch_data
  end
end
