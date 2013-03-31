module SchedulesHelper
  def force_button(schedule)
    if schedule.force_flag
    "<button id='btn_force'#{schedule.id}' class='btn btn-mini btn-success unforce' data-schedule-id='#{schedule.id}' data-target='#force'>
        Unforce <i class='icon-star'></i></button>".html_safe
    else
    "<button id='btn_force#{schedule.id}' class='btn btn-mini btn-primary force' data-schedule-id='#{schedule.id}' data-target='#force'>
        Force <i class='icon-star-empty'></i></button>".html_safe
    end
  end
end
