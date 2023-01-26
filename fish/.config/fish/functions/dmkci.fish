function dmkci --wraps='doas make clean install' --description 'alias dmkci=doas make clean install'
  doas make clean install $argv
        
end
