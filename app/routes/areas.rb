class TaskTao::Application
  # Show area creation form
  get '/areas/new' do
    logger.info "Handling areas/new request"
    erb :'areas/new', layout: false
  end

  # Create area
  post '/areas' do
    logger.info "Creating new area", params: params[:area]
    area = Area.new(params[:area])
    if area.save
      logger.info "Area created successfully", id: area.id
      if request.headers['HX-Request']
        redirect '/planning', 303
      else
        redirect '/planning'
      end
    else
      logger.error "Area creation failed", errors: area.errors
      erb :'areas/new', layout: false
    end
  end

  # Show area edit form
  get '/areas/:id/edit' do
    logger.info "Editing area", id: params[:id]
    @area = Area[params[:id]]
    erb :'areas/edit', layout: false
  end

  # Update area
  patch '/areas/:id' do
    logger.info "Updating area", id: params[:id], params: params[:area]
    area = Area[params[:id]]
    if area.update(params[:area])
      logger.info "Area updated successfully", id: area.id
      redirect '/planning'
    else
      logger.error "Area update failed", errors: area.errors
      erb :'areas/edit', layout: false
    end
  end

  # Delete area
  delete '/areas/:id' do
    logger.info "Deleting area", id: params[:id]
    area = Area[params[:id]]
    area.destroy
    logger.info "Area deleted successfully", id: params[:id]
    redirect '/planning'
  end

  # Update area position
  post '/areas/:id/reorder' do
    logger.info "Reordering area", id: params[:id], position: params[:position]
    area = Area[params[:id]]
    area.update(position: params[:position])
    200
  end
end 