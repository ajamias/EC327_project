#ifndef INPUT_H
#define INPUT_H
#include "Textbox.h"

class Input: public Textbox {
public:
        double x1, x2, y1, y2;
        Input();
        Input(  sf::Font& font,
                sf::Vector2f position,
                unsigned int max_length,
                unsigned int char_size = 30);
	void clickCheck(sf::Vector2i m_pos, Input*& current_input);
        void select();
        void deselect();
        void append(sf::String string);
        void pop_back();
        unsigned int getMaxLength();
        unsigned int getSize();
private:
	bool selected;
};

#endif
