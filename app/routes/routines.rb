class TaskTao::Application
  # Show routine creation form
  get '/routines/new' do
    logger.info "Handling routines/new request"
    erb :'routines/new', layout: false
  end

  # Create routine
  post '/routines' do
    logger.info "Creating new routine", params: params[:routine]
    routine = Routine.new(params[:routine])
    if routine.save
      logger.info "Routine created successfully", id: routine.id
      redirect '/planning'
    else
      logger.error "Routine creation failed", errors: routine.errors
      erb :'routines/new', layout: false
    end
  end

  # Show routine edit form
  get '/routines/:id/edit' do
    logger.info "Editing routine", id: params[:id]
    @routine = Routine[params[:id]]
    erb :'routines/edit', layout: false
  end

  # Update routine
  patch '/routines/:id' do
    logger.info "Updating routine", id: params[:id], params: params[:routine]
    routine = Routine[params[:id]]
    if routine.update(params[:routine])
      logger.info "Routine updated successfully", id: routine.id
      redirect back
    else
      logger.error "Routine update failed", errors: routine.errors
      erb :'routines/edit', layout: false
    end
  end

  # Toggle routine completion
  post '/routines/:id/toggle' do
    logger.info "Toggling routine completion", id: params[:id]
    routine = Routine[params[:id]]
    routine.update(
      completed: !routine.completed,
      completed_at: routine.completed ? nil : Time.now
    )
    logger.info "Routine completion toggled", id: routine.id, completed: routine.completed
    erb :'action/_routine', locals: { routine: routine }, layout: false
  end

  # Toggle routine active status
  post '/routines/:id/toggle_active' do
    logger.info "Toggling routine active status", id: params[:id]
    routine = Routine[params[:id]]
    routine.update(active: !routine.active)
    logger.info "Routine active status toggled", id: routine.id, active: routine.active
    redirect back
  end
end 