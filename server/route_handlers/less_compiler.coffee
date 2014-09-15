path = require 'path'
fs = require 'fs'
less = require 'less'
autoprefixer = require 'autoprefixer'

module.exports = (req, res, next) ->
  if req.params.filename.indexOf('.css') is -1
    return next()
  
  # Try to find a corresponding .less file
  lessFilePath = path.join(__dirname, '../../client/styles', req.params.filename.replace('.css', '.less'))

  fs.exists(lessFilePath, (exists) ->
    if exists 
      # Compile into css and render
      fs.readFile(lessFilePath, 'utf8', (err, data) ->
        if err
          return next()
        
        # Compile
        parser = new(less.Parser)({
          paths: [path.join(__dirname, '../../client/styles')]
          filename: 'application.less'
        })
        
        parser.parse(data, (err, tree) ->
          if err
            splitPath = err.filename.split('/')
            pathLength = splitPath.length
            #growl(err.message + " in " + splitPath[pathLength - 2] + "/" + splitPath[pathLength - 1], { title: 'Less Parse Error', image: 'Terminal', sticky: true })
            console.log(err)
            return next()

          prefixed = autoprefixer().process(tree.toCSS({compress: true})).css;

          res.set('Content-Type', 'text/css')
          res.status(200).send(prefixed)
        )
      )
    else
      return next()
  )
