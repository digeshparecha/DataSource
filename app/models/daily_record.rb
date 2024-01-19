# frozen_string_literal: true

class DailyRecord < ApplicationRecord
  before_save :update_average_age

  private

  def update_average_age
    calculate_average(:male_avg_age, male_record_avg) if male_count_changed?
    calculate_average(:female_avg_age, female_record_avg) if female_count_changed?
  end

  def calculate_average(field, avg)
    send(:"#{field}=", avg)
  end

  def male_record_avg
    User.male_avg_age
  end

  def female_record_avg
    User.female_avg_age
  end
end
