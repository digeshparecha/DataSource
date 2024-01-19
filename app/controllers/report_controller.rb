# frozen_string_literal: true

class ReportController < ApplicationController
  def simple_report
    @daily_records = DailyRecord.all
    source = Rails.root.join('app/views/report/daily_record.liquid').read
    @template = Liquid::Template.parse(source, error_mode: :strict)
  end
end
