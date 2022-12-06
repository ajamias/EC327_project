#include <SFML/Graphics.hpp>

int main() {

	sf::RenderWindow window(sf::VideoMode(574, 768), "PANTS!");
//	sf::RenderWindow window(sf::VideoMode(1500, 1500), "SFML works!");
	window.setFramerateLimit(60);
	sf::CircleShape shape(750.f);
	shape.setFillColor(sf::Color::Green);

	while (window.isOpen()) {
		sf::Event event;
		while (window.pollEvent(event)) {
			if (event.type == sf::Event::Closed) window.close();
		}

	window.setActive();

	sf::Texture texture;
	texture.loadFromFile("pants.png");

	sf::Sprite sprite;
	sprite.setTexture(texture);

	window.clear();
	window.draw(sprite);
//	window.draw(shape);
	window.display();
	}

	return 0;
}
