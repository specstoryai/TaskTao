class TaskTao::Application
  # Show routine creation form
  get '/routines/new' do
    erb :'routines/new', layout: false
  end

  # Create routine
  post '/routines' do
    routine = Routine.new(params[:routine])
    if routine.save
      redirect '/planning'
    else
      erb :'routines/new', layout: false
    end
  end

  # Show routine edit form
  get '/routines/:id/edit' do
    @routine = Routine[params[:id]]
    erb :'routines/edit', layout: false
  end

  # Update routine
  patch '/routines/:id' do
    routine = Routine[params[:id]]
    if routine.update(params[:routine])
      redirect back
    else
      erb :'routines/edit', layout: false
    end
  end

  # Toggle routine completion
  post '/routines/:id/toggle' do
    routine = Routine[params[:id]]
    routine.update(
      completed: !routine.completed,
      completed_at: routine.completed ? nil : Time.now
    )
    erb :'action/_routine', locals: { routine: routine }, layout: false
  end

  # Toggle routine active status
  post '/routines/:id/toggle_active' do
    routine = Routine[params[:id]]
    routine.update(active: !routine.active)
    redirect back
  end
end 