# -*- coding: utf-8 -*-

require 'bcrypt'
require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/base'
require 'sqlite3'
require 'thin'
#require 'slim'
require 'sass'
#require 'warden'
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