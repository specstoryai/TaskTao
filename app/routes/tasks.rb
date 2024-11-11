class TaskTao::Application
  # Create task
  post '/tasks' do
    logger.info "Creating new task", params: params[:task]
    task = Task.new(params[:task])
    if task.save
      logger.info "Task created successfully", id: task.id
      session[:last_area_id] = task.area_id
      if request.xhr?
        status 200
      else
        redirect back
      end
    else
      logger.error "Task creation failed", errors: task.errors
      status 422
    end
  end

  # Show task edit form
  get '/tasks/:id/edit' do
    logger.info "Editing task", id: params[:id]
    @task = Task[params[:id]]
    erb :'tasks/edit', layout: false
  end

  # Update task
  patch '/tasks/:id' do
    logger.info "Updating task", id: params[:id], params: params[:task]
    task = Task[params[:id]]
    if task.update(params[:task])
      logger.info "Task updated successfully", id: task.id
      redirect back
    else
      logger.error "Task update failed", errors: task.errors
      erb :'tasks/edit', layout: false
    end
  end

  # Toggle task completion
  post '/tasks/:id/toggle' do
    logger.info "Toggling task completion", id: params[:id]
    task = Task[params[:id]]
    task.update(
      completed: !task.completed,
      completed_at: task.completed ? nil : Time.now
    )
    logger.info "Task completion toggled", id: task.id, completed: task.completed
    erb :'action/_task', locals: { task: task }, layout: false
  end

  # Toggle task for today
  post '/tasks/:id/toggle_today' do
    logger.info "Toggling task for today", id: params[:id]
    task = Task[params[:id]]
    task.update(for_today: !task.for_today)
    logger.info "Task today status toggled", id: task.id, for_today: task.for_today
    redirect back
  end

  # Delete task
  delete '/tasks/:id' do
    logger.info "Deleting task", id: params[:id]
    task = Task[params[:id]]
    task.destroy
    logger.info "Task deleted successfully", id: params[:id]
    redirect back
  end

  # Update task position
  post '/tasks/:id/reorder' do
    logger.info "Reordering task", id: params[:id], position: params[:position]
    task = Task[params[:id]]
    task.update(position: params[:position])
    200
  end

  # Show task creation form
  get '/tasks/new' do
    logger.info "Handling tasks/new request", area_id: params[:area_id], type: params[:type]
    @area = Area[params[:area_id]]
    @type = params[:type]
    erb :'tasks/new', layout: false
  end
end 