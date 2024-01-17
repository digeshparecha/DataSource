# frozen_string_literal: true

class User < ApplicationRecord
  after_destroy :update_daily_report

  scope :male, -> { where(gender: 'male') }
  scope :female, -> { where(gender: 'female') }

  enum :gender, %i[male female]

  class << self
    def male_avg_age
      (male.sum(:age).to_f / male.count).round(2)
    end

    def female_avg_age
      (female.sum(:age).to_f / female.count).round(2)
    end
  end

  def update_daily_report
    daily_report = DailyRecord.find_by('DATE(date) = ?', created_at.to_date)
    param = if male?
              { male_count: daily_report.male_count - 1 }
            else
              { female_count: daily_report.female_count - 1 }
            end
    daily_report.update(param)
  end
end
