GCC = g++ -std=c++17

current_path = $(shell pwd)

OBJS = main.o Textbox.o Input.o Button.o

project: $(OBJS)
	export LD_LIBRARY_current_path=$(current_path)/SFML/lib
	$(GCC) $(OBJS) -o project -L$(current_path)/SFML/lib -lsfml-graphics -lsfml-window -lsfml-system -lsfml-network
	./project

Textbox.o: Textbox.cpp Textbox.h
	$(GCC) -c Textbox.cpp -I$(current_path)/SFML/include -o Textbox.o

Input.o: Input.cpp Input.h Textbox.h
	$(GCC) -c Input.cpp -I$(current_path)/SFML/include -o Input.o

Button.o: Button.cpp Textbox.h
	$(GCC) -c Button.cpp -I$(current_path)/SFML/include -o Button.o

main.o: main.cpp Textbox.h Input.h Button.h
	$(GCC) -c main.cpp -I$(current_path)/SFML/include -o main.o

run:
	echo $(current_path)
	./project

clear:
	rm *.o project
