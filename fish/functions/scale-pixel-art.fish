function scale-pixel-art
  convert $argv[1] -filter point -resize $argv[2] $argv[1]
end
