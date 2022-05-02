require 'gossip'

class ApplicationController < Sinatra::Base
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    Gossip.new(params[:gossip_author],params[:gossip_content],Array.new()).save
    redirect '/'
  end

  get '/gossips/index/' do
    erb :gossip_index, locals: {gossips: Gossip.all}
  end

  get '/gossips/:id/' do
    erb :show, locals:{gossip: Gossip.find(params['id']), id: params['id']}
  end

  post '/gossips/:id/' do
    puts params
    Gossip.add_comment(params['id'],params['new_comment'])
    redirect "/gossips/#{params['id']}/"
  end

  get '/gossips/:id/edit/' do
    puts params #######
    erb :edit, locals:{gossip: Gossip.find(params['id']), id: params['id']}
  end

  post '/gossips/:id/edit/' do
    Gossip.update(params['id'],params['new_author'],params['new_content'])
    puts params ##########
    redirect "/gossips/#{params['id']}/"
  end
end