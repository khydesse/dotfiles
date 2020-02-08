(setxkbmap -layout us -option caps:escape) &
(urxvtd -q -o -f) &
(feh --bg-scale ~/.wallpaper) &
xrdb merge .Xresources
#exec i3
kitty &
sxhkd &
exec bspwm
