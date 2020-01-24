# -*- coding: utf-8 -*-
require 'bcrypt'
require 'sinatra'
require 'sinatra/flash'
require 'sqlite3'
require 'thin'
#require 'slim'
require 'sass'
require 'sinatra/activerecord'
#require 'redcarpet'

enable :sessions

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/app')
require 'models'
require 'helpers'
require 'routes'

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/config')
require 'constants.rb'
require 'environments'
