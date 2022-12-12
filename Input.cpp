#include "Input.h"
#include <iostream>

Input::Input(): Textbox() {}

Input::Input(	sf::Font& font,
		sf::Vector2f position,
		unsigned int max_length,
		unsigned int char_size):
	Textbox(sf::String(), font, position, max_length, char_size) {
	x1 = position.x;
	y1 = position.y;
	x2 = position.x + max_length * char_size / 1.65;
	y2 = position.y + char_size * 5.3/4;
	selected = false;
}

void Input::clickCheck(sf::Vector2i m_pos, Input*& current_input) {
	if (m_pos.x >= x1 && m_pos.x <= x2 && m_pos.y >= y1 && m_pos.y <= y2) {
		if (current_input != nullptr) current_input->deselect();
		select();
		current_input = this;
	}
}

void Input::select() {
	selected = true;
	string += "_";
	text.setString(string);
}

void Input::deselect() {
	selected = false;
	string.erase(string.getSize() - 1);
	text.setString(string);
}

void Input::append(sf::String string) {
	if (this->string.getSize() < max_length) {
		this->string.insert(this->string.getSize() - 1, string);
		text.setString(this->string);
	} else if (this->string.getSize() >= max_length) {
		this->string.insert(this->string.getSize() - 1, string);
		text.setString(this->string.substring(this->string.getSize() - max_length, max_length));
	}
}

void Input::pop_back() {
	string.erase(string.getSize() - 2);
	if (string.getSize() < max_length) {
		text.setString(string);
	} else {
		text.setString(string.substring(string.getSize() - max_length));
	}
}

unsigned int Input::getMaxLength() {
	return max_length;
}

unsigned int Input::getSize() {
	return string.getSize();
}
