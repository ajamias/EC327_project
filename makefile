GCC = g++

OBJS = main.o

project: $(OBJS)
	$(GCC) $(OBJS) -o project -L/Users/austin/SFML/lib -lsfml-graphics -lsfml-window -lsfml-system -lsfml-network && export LD_LIBRARY_PATH=/Users/austin/SFML/lib && ./project ; make clear

main.o: main.cpp
	$(GCC) -c main.cpp -I/Users/austin/SFML/include

clear:
	rm *.o project
