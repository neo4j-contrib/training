define [], () ->

  prettyColors = [
    {bright:"#3498db", dim:"#C9D3DB"} # blue
    {bright:"#1abc9c", dim:"#DAE9E6"} # green
    {bright:"#e74c3c", dim:"#E0D6E6"} # red
    {bright:"#C56EF5", dim:"#C6BBCC"} # violet
    {bright:"#FCAB33", dim:"#F7DBB7"} # orange
    {bright:"#2BDAD2", dim:"#CEEDEC"} # indigo-ish
  ]

  defaultColor = {bright:"#525864", dim:"#ccc"}

  class ColorManager

    constructor: ->
      @registeredLabelColors = {}

    getColorForLabels: (labels) ->
      return defaultColor unless labels && labels.length > 0
      labelToUse = labels[labels.length-1]
      if !@registeredLabelColors[labelToUse]
        return defaultColor if prettyColors.length == 0
        color = prettyColors[_.random(0, prettyColors.length-1)]
        prettyColors.splice(_.indexOf(prettyColors, color), 1)
        @registeredLabelColors[labelToUse] = color
      return @registeredLabelColors[labelToUse]

  # singleton
  return new ColorManager()