fs = require 'fs'

{print} = require 'sys'
{spawn} = require 'child_process'

sbuildFrontend = (callback) ->
  coffee = spawn 'coffee', ['-c', '-o', 'public/js', 'public_CoffeeScript']
  coffee.stderr.on 'data', (data) ->
    process.stderr.write data.toString()
  coffee.stdout.on 'data', (data) ->
    print data.toString()
  coffee.on 'exit', (code) ->
    callback?() if code is 0


sbuildControllers = (callback) ->
  coffee = spawn 'coffee', ['-c', '-o', 'app/controllers', 'app/controllers']
  coffee.stderr.on 'data', (data) ->
    process.stderr.write data.toString()
  coffee.stdout.on 'data', (data) ->
    print data.toString()
  coffee.on 'exit', (code) ->
    callback?() if code is 0
    
sbuildModels = (callback) ->
  coffee = spawn 'coffee', ['-c', '-o', 'app/models', 'app/models']
  coffee.stderr.on 'data', (data) ->
    process.stderr.write data.toString()
  coffee.stdout.on 'data', (data) ->
    print data.toString()
  coffee.on 'exit', (code) ->
    callback?() if code is 0

sbuildViews = (callback) ->
  coffee = spawn 'coffee', ['-c', '-o', 'app/views', 'app/views']
  coffee.stderr.on 'data', (data) ->
    process.stderr.write data.toString()
  coffee.stdout.on 'data', (data) ->
    print data.toString()
  coffee.on 'exit', (code) ->
    callback?() if code is 0
    

sbuildServer = (callback) ->
  coffee = spawn 'coffee', ['-c', '-o', './', './']
  coffee.stderr.on 'data', (data) ->
    process.stderr.write data.toString()
  coffee.stdout.on 'data', (data) ->
    print data.toString()
  coffee.on 'exit', (code) ->
    callback?() if code is 0
    
task 'sbuild', 'Build app', ->
  sbuildFrontend()
  sbuildControllers()
  sbuildModels()
  sbuildViews()
  sbuildServer()