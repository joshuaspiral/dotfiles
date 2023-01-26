function p --wraps='doas pacman' --description 'alias p=doas pacman'
  doas pacman $argv
        
end
