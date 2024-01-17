# frozen_string_literal: true

class CaptureUserRecordsController < ApplicationController
  def fetch_users_record
    api = "https://randomuser.me/api/?results=20"
    FetchUsersRecordService.new(api).fetch_data
  end
end
