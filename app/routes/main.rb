class TaskTao::Application
  get '/' do
    redirect '/action'
  end

  # Capture Mode
  get '/capture' do
    @areas = Area.where(active: true).order(:position)
    @last_area = session[:last_area_id] ? Area[session[:last_area_id]] : @areas.first
    erb :'capture/index'
  end

  # Planning Mode
  get '/planning' do
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @areas = Area.order(:position)
    erb :'planning/index'
  end

  # Action Mode
  get '/action' do
    @date = Date.today
    @important_tasks = Task.where(type: 'important', for_today: true, completed: false)
                          .order(:position)
                          .all
    @urgent_tasks = Task.where(type: 'urgent', for_today: true, completed: false)
                       .order(:position)
                       .all
    @routines = Routine.where(active: true)
                      .all
                      .reject { |r| r.completed && !r.reset_completion? }
    erb :'action/index'
  end
end 