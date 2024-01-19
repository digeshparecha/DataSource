# frozen_string_literal: true

class FetchUserDataWorker
  include Sidekiq::Worker

  def perform
    Rails.logger.debug { "Running HourlyJob at #{Time.zone.now}" }
    # Fetching data from Api
    FetchUsersRecordService.fetch_data
  end
end
