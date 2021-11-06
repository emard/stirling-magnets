all: animated.gif
	convert 'frame*.png' -set delay 1x25 pic/animated.gif

view: pic/animated.gif
	mpv -loop pic/animated.gif

clean:
	rm -f frame*.png
