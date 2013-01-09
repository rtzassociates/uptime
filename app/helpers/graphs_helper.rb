module GraphsHelper
  def events_chart_data_weekly
    (1.week.ago.to_date..Date.today).map do |date|
      {
        created_at: date,
        event_count: Event.where("date(created_at) = ?", date).count,
        outages: Event.outages.where("date(created_at) = ?", date).count,
        slowdowns: Event.slowdowns.where("date(created_at) = ?", date).count,
        errors: Event.errors.where("date(created_at) = ?", date).count,
        restarts: Event.restarts.where("date(created_at) = ?", date).count
      }
    end
  end
  
  def events_chart_data_monthly
    (1.month.ago.to_date..Date.today).map do |date|
      {
        created_at: date,
        event_count: Event.where("date(created_at) = ?", date).count,
        outages: Event.outages.where("date(created_at) = ?", date).count,
        slowdowns: Event.slowdowns.where("date(created_at) = ?", date).count,
        errors: Event.errors.where("date(created_at) = ?", date).count,
        restarts: Event.restarts.where("date(created_at) = ?", date).count
      }
    end
  end
  
  def events_chart_data_quarterly
    (3.months.ago.to_date..Date.today).map do |date|
      {
        created_at: date,
        event_count: Event.where("date(created_at) = ?", date).count,
        outages: Event.outages.where("date(created_at) = ?", date).count,
        slowdowns: Event.slowdowns.where("date(created_at) = ?", date).count,
        errors: Event.errors.where("date(created_at) = ?", date).count,
        restarts: Event.restarts.where("date(created_at) = ?", date).count
      }
    end
  end
  
  def events_chart_data_annually
    (1.year.ago.to_date..Date.today).map do |date|
      {
        created_at: date,
        event_count: Event.where("date(created_at) = ?", date).count,
        outages: Event.outages.where("date(created_at) = ?", date).count,
        slowdowns: Event.slowdowns.where("date(created_at) = ?", date).count,
        errors: Event.errors.where("date(created_at) = ?", date).count,
        restarts: Event.restarts.where("date(created_at) = ?", date).count
      }
    end
  end
end
