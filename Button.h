#ifndef BUTTON_H
#define BUTTON_H
#include "Textbox.h"

class Button: public Textbox {
public:
	double x1, x2, y1, y2;
	Button();
	Button( sf::String string,
		sf::Font& font,
		sf::Vector2f,
		unsigned int max_length,
		unsigned int char_size = 30);

	bool clickCheck(sf::Vector2i m_pos);
//private:
//	sf::RectangleShape shadow;
};

#endif
