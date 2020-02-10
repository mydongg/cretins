# -*- coding: utf-8 -*-

require 'dotenv/load'
#require 'bcrypt'
require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/base'
require 'sqlite3'
require 'thin'
#require 'slim'
require 'sass'
require 'warden'
require 'rack-flash'
require 'colorize'

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/app')
require 'models'
require 'helpers'
require 'routes'

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/config')
require 'constants.rb'
require 'environments'

enable :sessions
set :sessions, session_store: Rack::Session::Cookie,
                key: 'bruh_moment.session',
                expire_after: (60 * 60 * 24 * 365),
                secret: ENV['SESSION_SECRET']
use Rack::Flash

use Warden::Manager do |config|
  config.serialize_into_session(&:id)
  config.serialize_from_session { |id| User.find(id) }
  config.scope_defaults :default, strategies: [:password], action: '/unauthenticated'
  config.failure_app = Sinatra::Application
end

Warden::Strategies.add(:password) do
  def valid?
    puts '(Warden::Strategies) valid?'.colorize(:blue)
    params['username'] && params['password']
  end

  def authenticate!
    puts '(Warden::Strategies) authenticate!'.colorize(:blue)
    user = User.find_by(username: params['username'])

    if user&.authenticate(params['password'])
      puts '(Warden::Strategies) user present and authenticate returns true'.colorize(:green)
      success!(user)
    else
      puts '(Warden::Strategies) could not authenticate'.colorize(:red)
      fail!('Could not log in')
    end
  end
end

Warden::Manager.before_failure do |env, _opts|
  env['REQUEST_METHOD'] = 'POST'
end