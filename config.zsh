config=(os-check aliases docker go less llvm ls)
((OSX)) && config=($config homebrew java locale)
((LINUX)) && config=($config)
((MSYS)) && config=($config)
