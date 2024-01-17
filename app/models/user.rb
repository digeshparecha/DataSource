# frozen_string_literal: true

class User < ApplicationRecord
  scope :male, -> { where(gender: 'male') }
  scope :female, -> { where(gender: 'female') }

  enum :gender, %i[male female]

  class << self
    def male_avg_age
      male.sum(:age) / male.count
    end

    def female_avg_age
      female.sum(:age) / female.count
    end
  end
end
