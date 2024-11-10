class TaskTao::Application
  # Create task
  post '/tasks' do
    task = Task.new(params[:task])
    if task.save
      session[:last_area_id] = task.area_id
      if request.xhr?
        status 200
      else
        redirect back
      end
    else
      status 422
    end
  end

  # Show task edit form
  get '/tasks/:id/edit' do
    @task = Task[params[:id]]
    erb :'tasks/edit', layout: false
  end

  # Update task
  patch '/tasks/:id' do
    task = Task[params[:id]]
    if task.update(params[:task])
      redirect back
    else
      erb :'tasks/edit', layout: false
    end
  end

  # Toggle task completion
  post '/tasks/:id/toggle' do
    task = Task[params[:id]]
    task.update(
      completed: !task.completed,
      completed_at: task.completed ? nil : Time.now
    )
    erb :'action/_task', locals: { task: task }, layout: false
  end

  # Toggle task for today
  post '/tasks/:id/toggle_today' do
    task = Task[params[:id]]
    task.update(for_today: !task.for_today)
    redirect back
  end

  # Delete task
  delete '/tasks/:id' do
    task = Task[params[:id]]
    task.destroy
    redirect back
  end

  # Update task position
  post '/tasks/:id/reorder' do
    task = Task[params[:id]]
    task.update(position: params[:position])
    200
  end
end 