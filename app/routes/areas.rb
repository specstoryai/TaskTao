class TaskTao::Application
  # Show area creation form
  get '/areas/new' do
    erb :'areas/new', layout: false
  end

  # Create area
  post '/areas' do
    area = Area.new(params[:area])
    if area.save
      redirect '/planning'
    else
      erb :'areas/new', layout: false
    end
  end

  # Show area edit form
  get '/areas/:id/edit' do
    @area = Area[params[:id]]
    erb :'areas/edit', layout: false
  end

  # Update area
  patch '/areas/:id' do
    area = Area[params[:id]]
    if area.update(params[:area])
      redirect '/planning'
    else
      erb :'areas/edit', layout: false
    end
  end

  # Delete area
  delete '/areas/:id' do
    area = Area[params[:id]]
    area.destroy
    redirect '/planning'
  end

  # Update area position
  post '/areas/:id/reorder' do
    area = Area[params[:id]]
    area.update(position: params[:position])
    200
  end
end 