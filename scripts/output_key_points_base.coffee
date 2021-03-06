require '../common/init'
fs = require 'fs'

# coffee scripts/output_key_points_base.coffee de
# coffee scripts/output_key_points_base.coffee nceone
# coffee scripts/output_key_points_base.coffee de/nceone [28,29,32,33] #方括号表示可选参数

type = process.argv[2] or process.exit 1
dataPath = "local_data/#{type}_json"
outputDir = "local_data/#{type}_base"

list = process.argv[3]?.split ',' #可以传参数，逗号分隔，不含空格 28,29,32,33

fs.readdir dataPath, (err, files) ->
  needToProcess = []
  if list
    _.each list, (index) ->
      needToProcess.push files[~~index - 1]
  else
    needToProcess = files

  for file in needToProcess
#    console.log file
    buildStringFromJson file

buildStringFromJson = (file) ->
  datas = require "../#{dataPath}/#{file}"
  lines = []
  _.each datas, (data) ->
    lines.push data.sentenceNo, data.english, '<k></k>' + '\n'

  newName = file.replace /.srt.json/, '.txt'

  do (newName) ->
    fs.writeFile "#{outputDir}/#{newName}", (lines.join '\n') + '\n', (err) ->
      if err
        console.log err
        process.exit 1

      console.log "write success: #{newName}"
