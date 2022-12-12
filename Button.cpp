#include "Button.h"

Button::Button():Textbox() {}
Button::Button( sf::String string,
	sf::Font& font,
	sf::Vector2f position,
	unsigned int max_length,
	unsigned int char_size):
	Textbox(string, font, position, max_length, char_size) {
	x1 = position.x;
	y1 = position.y;
	x2 = position.x + max_length * char_size / 1.65;
        y2 = position.y + char_size * 5.3/4;
}

bool Button::clickCheck(sf::Vector2i m_pos) {
	return (m_pos.x >= x1 && m_pos.x <= x2 && m_pos.y >= y1 && m_pos.y <= y2);
}
