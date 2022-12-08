#include <iostream>
#include <string>
#include <SFML/Graphics.hpp>
#include <SFML/System.hpp>

#define max_window_x
// use https://github.com/lava/matplotlib-cpp for c++ graph visualisation

class Textbox: public sf::Drawable, public sf::Transformable {
public:
	Textbox() {}
	Textbox(sf::String& string,
		sf::Font& font,
		sf::Vector2f& position,
		unsigned int max_length,
		unsigned int char_size = 30):
		text(string.substring(0, max_length), font, char_size) {
		text.setFillColor(sf::Color::White);
		text.setPosition(position);
		box.setSize(sf::Vector2f(max_length * char_size / 1.65, char_size * 5.3/4));
		box.setPosition(position);
		box.setFillColor(sf::Color::Black);
		box.setOutlineThickness(1);
		box.setOutlineColor(sf::Color::White);
	}
	void draw(sf::RenderTarget& target, sf::RenderStates states) const {
		target.draw(box, states);
		target.draw(text, states);
	}
	void setBoxColor(sf::Color color) {
		box.setFillColor(color);
	}
private:
	sf::Text text;
	sf::RectangleShape box;
};



int main() {

	sf::RenderWindow window(sf::VideoMode(2000, 1000), "PANTS!");//, sf::Style::Titlebar | sf::Style::Close);

	window.setFramerateLimit(60);
	
	sf::Texture texture;
	sf::Sprite sprite;
	texture.loadFromFile("pants.png");
	sprite.setTexture(texture);
	sprite.setPosition(1401, 116);

	sf::String directory1_text, directory2_text;
	sf::String empty;
	sf::Text directory1, directory2;
	sf::Font font;
	font.loadFromFile("./Fonts/CourierPrime-Regular.ttf");


	directory1.setFont(font);
	directory1.setFillColor(sf::Color::White);
	directory1.setPosition(645, 50);

	directory2.setFont(font);
	directory2.setFillColor(sf::Color::White);
	directory2.setPosition(645, 100);
	

	sf::String temp_text("Enter directories of files containing image data:");
	sf::Vector2f temp_vec(500, 0);
	Textbox temp(temp_text, font, temp_vec, temp_text.getSize());
	
	sf::String fileLabelText_1("file 0:");
	sf::Vector2f fileLabelPosition_1(500, 50);
	Textbox fileLabel_1(fileLabelText_1, font, fileLabelPosition_1, fileLabelText_1.getSize());

	sf::Vector2f fileTextPosition_1(645, 50);
	Textbox fileText_1(empty, font, fileTextPosition_1, 41);

	sf::String fileLabelText_2("file 1:");
	sf::Vector2f fileLabelPosition_2(500, 100);
	Textbox fileLabel_2(fileLabelText_2, font, fileLabelPosition_2, fileLabelText_2.getSize());
	
	sf::Vector2f fileTextPosition_2(645, 100);
	Textbox fileText_2(empty, font, fileTextPosition_2, 41);

	bool text_select = true;
	directory1_text += "_";
	directory1.setString(directory1_text);

	while (window.isOpen()) {
		sf::Event event;
		while (window.pollEvent(event)) {
			switch (event.type) {
				case (sf::Event::Closed):
					window.close();
					break;
				case (sf::Event::TextEntered):
					if (event.text.unicode < 128) {
						if (event.text.unicode == 10) {
							
						} else if (event.text.unicode == 9) {
							text_select = !text_select;
							if (text_select) {
								directory1_text += "_";
								directory2_text.erase(directory2_text.getSize() - 1);
							} else {
								directory2_text += "_";
								directory1_text.erase(directory1_text.getSize() - 1);
							}
						}
						else if (text_select) {
							if (event.text.unicode == 8 && directory1_text.getSize() > 1) {
								directory1_text.erase(directory1_text.getSize() - 2);
							} else if (event.text.unicode != 8 && directory1_text.getSize() < 41) {
								directory1_text.insert(directory1_text.getSize() - 1, event.text.unicode);
							}
						} else {
							if (event.text.unicode == 8 && directory2_text.getSize() > 1) {
								directory2_text.erase(directory2_text.getSize() - 2);
							} else if (event.text.unicode != 8 && directory2_text.getSize() < 41) {
								directory2_text.insert(directory2_text.getSize() - 1, event.text.unicode);
							}
						}
						directory1.setString(directory1_text);
						directory2.setString(directory2_text);
					}
					std::cout << event.text.unicode << std::endl;
					break;
				case (sf::Event::MouseButtonPressed):
					if (event.mouseButton.button == sf::Mouse::Left) {
						if (	sf::Mouse::getPosition(window).x >= 645 && sf::Mouse::getPosition(window).x <= 1390 &&
							sf::Mouse::getPosition(window).y >= 50 && sf::Mouse::getPosition(window).y <= 87) {
							text_select = true;
							directory1_text += "_";
							directory2_text.erase(directory2_text.getSize() - 1);
						} else if (sf::Mouse::getPosition(window).x >= 645 && sf::Mouse::getPosition(window).x <= 1390 &&
							   sf::Mouse::getPosition(window).y >= 100 && sf::Mouse::getPosition(window).y <= 137) {
							text_select = false;
							directory2_text += "_";
							directory1_text.erase(directory1_text.getSize() - 1);
						}
					}
					break;
				default:
					break;
			}
		}

		window.setActive();

		window.clear();
		window.draw(sprite);
		window.draw(fileLabel_1);
		window.draw(fileText_1);
		window.draw(fileLabel_2);
		window.draw(fileText_2);
		window.draw(directory1);
		window.draw(directory2);
		window.draw(temp);

		window.display();

	}

	return 0;
}
