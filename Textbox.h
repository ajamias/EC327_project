#ifndef TEXTBOX_H
#define TEXTBOX_H
#include <SFML/Graphics.hpp>
#include <SFML/System.hpp>

class Textbox: public sf::Drawable, public sf::Transformable {
public:
        Textbox();
        Textbox(sf::String string,
                sf::Font& font,
                sf::Vector2f position,
                unsigned int max_length,
                unsigned int char_size = 30);
        void draw(sf::RenderTarget& target, sf::RenderStates states) const;
        void setBoxColor(sf::Color color);
	void setTextColor(sf::Color color);
	bool isEmpty();
	sf::String getString();
protected:
        sf::String string;
        sf::Font font;
        sf::Vector2f position;
        unsigned int max_length;
        unsigned int char_size;
        sf::Text text;
        sf::RectangleShape box;
};

#endif
