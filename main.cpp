#include <iostream>
#include <string>
#include <SFML/Graphics.hpp>
#include <SFML/System.hpp>
#include "Textbox.h"
#include "Input.h"
#include "Button.h"

#define max_window_x
// use https://github.com/lava/matplotlib-cpp for c++ graph visualisation

void enterText(unsigned int unicode, Input*& current_input) {
	if (unicode > 127) return;
	if (unicode == 8) {
		if (current_input->getSize() > 1) current_input->pop_back();
	} else if (current_input != nullptr && current_input->getSize() < 41) {
		current_input->append(static_cast<sf::String> (unicode));
	}
}

int main() {

	sf::RenderWindow window(sf::VideoMode(2000, 1000), "PANTS!");//, sf::Style::Titlebar | sf::Style::Close);

	window.setFramerateLimit(60);
	
//	sf::Texture texture;
//	sf::Sprite sprite;
//	texture.loadFromFile("pants.png");
//	sprite.setTexture(texture);
//	sprite.setPosition(1401, 116);

	sf::String directory1_text, directory2_text;
	sf::String empty;
	sf::Font font;
	font.loadFromFile("./Fonts/CourierPrime-Regular.ttf");

	Input directory1(font, sf::Vector2f(645, 50), 41);

	Input directory2(font, sf::Vector2f(645, 100), 41);
	
	sf::String temp_text("Enter directories of files containing image data:");
	Textbox temp(	temp_text,
			font, 
			sf::Vector2f(500, 0), 
			temp_text.getSize());

	sf::String labels_text("Labels:");
	Textbox labels(	labels_text, 
			font, 
			sf::Vector2f(1400, 0), 
			labels_text.getSize());
	
	Input label1(font, sf::Vector2f(1400, 50), labels_text.getSize());

	Input label2(font, sf::Vector2f(1400, 100), labels_text.getSize());

	sf::String fileLabelText_1("file 0:");
	Textbox fileLabel_1(	fileLabelText_1, 
				font, 
				sf::Vector2f(500, 50), 
				fileLabelText_1.getSize());

	sf::String fileLabelText_2("file 1:");
	Textbox fileLabel_2(	fileLabelText_2, 
				font, 
				sf::Vector2f(500, 100), 
				fileLabelText_2.getSize());
	
	sf::String button1_text("train!");
	Button button1(button1_text,
			font,
			sf::Vector2f(1600, 75),
			button1_text.getSize());
	button1.setBoxColor(sf::Color::White);
	button1.setTextColor(sf::Color::Black);

	

	Input* current_input = nullptr;

	while (window.isOpen()) {
		sf::Event event;
		while (window.pollEvent(event)) {
			switch (event.type) {
				case (sf::Event::Closed):
					window.close();
					break;
				case (sf::Event::TextEntered):
					enterText(event.text.unicode, current_input);
					break;
				case (sf::Event::MouseButtonPressed):
					if (event.mouseButton.button == sf::Mouse::Left) {
						sf::Vector2i mouse_pos = sf::Mouse::getPosition(window);
						directory1.clickCheck(mouse_pos, current_input);
						directory2.clickCheck(mouse_pos, current_input);
						label1.clickCheck(mouse_pos, current_input);
						label2.clickCheck(mouse_pos, current_input);
						if (button1.clickCheck(mouse_pos)) {
							std::cout << "clicked" << std::endl;
						}					
					}
					break;
				default:
					break;
			}
		}

		window.setActive();

		window.clear();
		window.draw(fileLabel_1);
		window.draw(fileLabel_2);
		window.draw(directory1);
		window.draw(directory2);
		window.draw(temp);
		window.draw(labels);
		window.draw(label1);
		window.draw(label2);
		window.draw(button1);

		window.display();

	}

	return 0;}
