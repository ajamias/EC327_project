#include "Textbox.h"
#include <SFML/Graphics.hpp>
#include <SFML/System.hpp>

Textbox::Textbox() {}
Textbox::Textbox(sf::String string,
		 sf::Font& font,
		 sf::Vector2f position,
		 unsigned int max_length,
		 unsigned int char_size):
		 text(string.substring(0, max_length), font, char_size) {

	this->string = string;
	this->font = font;
	this->position = position;
	this->max_length = max_length;
	this->char_size = char_size;

	text.setFillColor(sf::Color::White);
	text.setPosition(position);
	box.setSize(sf::Vector2f(max_length * char_size / 1.65, char_size * 5.3/4));
	box.setPosition(position);
	box.setFillColor(sf::Color::Black);
	box.setOutlineThickness(1);
	box.setOutlineColor(sf::Color::White);
	visible = true;
}
void Textbox::draw(sf::RenderTarget& target, sf::RenderStates states) const {
	if (visible) {
		target.draw(box, states);
		target.draw(text, states);
	}
}
void Textbox::setBoxColor(sf::Color color) {
	box.setFillColor(color);
}

void Textbox::setTextColor(sf::Color color) {
	text.setFillColor(color);
}

bool Textbox::isEmpty() {
	if (string.getSize() == 1) return true;
	return false;
}

sf::String Textbox::getString() {
	return string;
}

void Textbox::changeString(sf::String string) {
	this->string = string;
	text.setString(string);
	max_length = string.getSize();
	box.setSize(sf::Vector2f(max_length * char_size / 1.65, char_size * 5.3/4));
}

void Textbox::setOrigin(sf::Vector2f position) {
	text.setOrigin(position);
	box.setOrigin(position);
}

unsigned int Textbox::getCharSize() {
	return text.getCharacterSize();
}

bool Textbox::isVisible() {
	return visible;
}

void Textbox::setVisible(bool visibility) {
	visible = visibility;
}
