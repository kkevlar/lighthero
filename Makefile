

all: inoup

rundemo: demo
	./demo | java LightHeroDemo 


demo: LightHeroDemo demo.o lighthero.o justin.o demo.h lighthero.h platform.h
	gcc demo.o lighthero.o justin.o -lm -o demo 

demo.o: demo.c demo.h lighthero.h platform.h
	gcc -c demo.c -o demo.o

lighthero.o: lighthero.c lighthero.h platform.h
	gcc -c lighthero.c -o lighthero.o

justin.o: justin.cpp justin.h lighthero.h 
	g++ -c justin.cpp -o justin.o

LightHeroDemo: LightHeroDemo.java
	javac LightHeroDemo.java

inoup: inobuild
	cd nano; ino upload -m nano328

nano/src:
	cd nano; ino init
	cd nano/src; rm -rf *

inobuild: nano nano/src nano/src/justin.cpp nano/src/ino.c nano/src/ino.h nano/src/lighthero.h nano/src/lighthero.c nano/src/platform.h  nano/src/justin.hpp
	cd nano; ino build -m nano328 > /dev/null

nano/src/ino.c: ino.c
	cp ino.c nano/src/ino.c

nano/src/ino.h: ino.h
	cp ino.h nano/src/ino.h

nano/src/lighthero.h: lighthero.h
	cp lighthero.h nano/src/lighthero.h

nano/src/lighthero.c: lighthero.c nano/src/justin.hpp
	cp lighthero.c nano/src/lighthero.c

nano/src/justin.hpp: justin.hpp
	cp justin.hpp nano/src/justin.hpp

nano/src/justin.cpp: justin.cpp
	cp justin.cpp nano/src/justin.cpp

nano/src/platform.h: platform.h
	cat platform.h | sed 's;demo\.h;ino.h;' > nano/src/platform.h

nano:
	mkdir nano
	cd nano; rm -rf *

clean:
	rm -f *.class
	rm -f LightHeroDemo
	rm -f *.o
	rm -rf nano



