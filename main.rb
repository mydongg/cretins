# -*- coding: utf-8 -*-

require 'sinatra'
require 'sqlite3'
require 'slim'
require 'sass'
require 'sinatra/activerecord'
require 'redcarpet'

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/app')
require 'routes'
require 'models'
require 'helpers'

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/config')
require 'constants.rb'
require 'environments'
