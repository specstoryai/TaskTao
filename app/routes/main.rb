class TaskTao::Application
  get '/' do
    logger.info "Redirecting root to action mode"
    redirect '/action'
  end

  # Capture Mode
  get '/capture' do
    logger.info "Entering capture mode"
    @areas = Area.where(active: true).order(:position)
    @last_area = session[:last_area_id] ? Area[session[:last_area_id]] : @areas.first
    logger.debug "Last used area", area_id: @last_area&.id, area_title: @last_area&.title
    erb :'capture/index'
  end

  # Planning Mode
  get '/planning' do
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    logger.info "Entering planning mode", date: @date
    @areas = Area.order(:position)
    logger.debug "Loaded areas", count: @areas.count
    erb :'planning/index'
  end

  # Action Mode
  get '/action' do
    @date = Date.today
    logger.info "Entering action mode", date: @date

    @important_tasks = Task.where(type: 'important', for_today: true, completed: false)
                          .order(:position)
                          .all
    @urgent_tasks = Task.where(type: 'urgent', for_today: true, completed: false)
                       .order(:position)
                       .all
    @routines = Routine.where(active: true)
                      .all
                      .reject { |r| r.completed && !r.reset_completion? }

    logger.debug "Loaded tasks", 
      important_count: @important_tasks.count,
      urgent_count: @urgent_tasks.count,
      routines_count: @routines.count

    erb :'action/index'
  end
end 