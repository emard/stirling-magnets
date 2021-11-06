all: animated.gif
	convert 'frame*.png' -set delay 1x25 animated.gif

view: animated.gif
	mpv -loop animated.gif

clean:
	rm -f animated.gif frame*.png
