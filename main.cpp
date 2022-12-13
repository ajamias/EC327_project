#include <iostream>
#include <fstream>
#include <filesystem>
#include <string>
#include <SFML/Graphics.hpp>
#include <SFML/System.hpp>
#include "Textbox.h"
#include "Input.h"
#include "Button.h"

namespace fs = std::filesystem;

#define max_window_x 2000
#define max_window_y 1000

std::fstream file1;
std::fstream file2;


void enterText(unsigned int unicode, Input*& current_input) {
	if (unicode > 127) return;
	if (unicode == 8) {
		if (current_input->getSize() > 1) current_input->pop_back();
	} else if (current_input != nullptr) { //&& current_input->getSize() < 41) {
		current_input->append(static_cast<sf::String> (unicode));
	}
}

void processFiles(sf::String filename1, sf::String filename2) {
	std::string command;
	command.append("cd ./MATLAB");
	if (!filename1.isEmpty() && !filename2.isEmpty()) {
		file1.open(filename1.toAnsiString(), std::fstream::in);
		file2.open(filename2.toAnsiString(), std::fstream::in);

		command.append(" && /Applications/MATLAB_R2021a.app/bin/matlab -nodisplay -nosplash -nodesktop -r \"run('Main.m(");
		command.append(filename1);
		command.append(", ");
		command.append(filename2);
		command.append(")'); exit;\"");
		std::cout << command << std::endl;
		system(command.c_str());
		system("cd ./..");
		
	} else {
		command.append(" && /Applications/MATLAB_R2021a.app/bin/matlab -nodisplay -nosplash -nodesktop -r \"run('avg_images('catsfolder/', 'dogsfolder/')'); run('visualize2d('catsfolder/', 'dogsfolder/')'); run('visualize_error('catsfolder/', 'dogsfolder/')') exit;\"");
		system(command.c_str());
		system("cd ./..");
	}
	command.clear();
}

int main() {

	sf::RenderWindow window(sf::VideoMode(max_window_x, max_window_y), "PANTS!");//, sf::Style::Titlebar | sf::Style::Close);

	window.setFramerateLimit(60);
	
//	sf::Texture texture;
//	sf::Sprite sprite;
//	texture.loadFromFile("pants.png");
//	sprite.setTexture(texture);
//	sprite.setPosition(1401, 116);

//	void (*fptr) (sf::String, sf::String);
//	fptr = &processFiles;

	sf::Texture img1, img2, img3, img4;
	sf::Sprite sp1, sp2, sp3, sp4;
	sp1.setOrigin(sf::Vector2f(1376/2, 1426/2));
	sp2.setOrigin(sf::Vector2f(1376/2, 1425/2));
	sp3.setOrigin(sf::Vector2f(1944/2, 1490/2));
	sp4.setOrigin(sf::Vector2f(1825/2, 1384/2));
	sp1.setPosition(sf::Vector2f(max_window_x * 3/28.0, max_window_y * 3/4.0));
	sp2.setPosition(sf::Vector2f(max_window_x * 5/14.0, max_window_y * 3/4.0));
	sp3.setPosition(sf::Vector2f(max_window_x * 17/28.0, max_window_y * 3/4.0));
	sp4.setPosition(sf::Vector2f(max_window_x * 6/7.0, max_window_y * 3/4.0));
	sp1.setScale(sf::Vector2f(0.25, 0.25));
	sp2.setScale(sf::Vector2f(0.25, 0.25));
	sp3.setScale(sf::Vector2f(0.23, 0.23));
	sp4.setScale(sf::Vector2f(0.25, 0.25));



	sf::String directory1_text, directory2_text;
	sf::String empty;
	sf::Font font;
	font.loadFromFile("./Fonts/CourierPrime-Regular.ttf");


	Input directory1(font, sf::Vector2f(645, 50), 41);					// directory 1

	Input directory2(font, sf::Vector2f(645, 100), 41);					// directory 2
	
	sf::String prompt_text("Enter directories of files containing image data:");		// prompt
	Textbox prompt(	prompt_text,
			font, 
			sf::Vector2f(500, 0), 
			prompt_text.getSize());

	sf::String explanation1("Create machine learning model using ");			// TODO

	sf::String labels_text("Labels:");							// labels
	Textbox labels(	labels_text, 
			font, 
			sf::Vector2f(1400, 0), 
			labels_text.getSize());
	
	Input label1(font, sf::Vector2f(1400, 50), labels_text.getSize());			// input label1

	Input label2(font, sf::Vector2f(1400, 100), labels_text.getSize());			// input label2


	sf::String avg_text1("\"average\"  ");							// average 1
	Textbox avg_label1(	avg_text1,
				font,
				sf::Vector2f(sp1.getPosition().x - 171, sp1.getPosition().y - 225),
				avg_text1.getSize());
	avg_label1.setVisible(false);

	sf::String avg_text2("\"average\"  ");							// average 2
	Textbox avg_label2(	avg_text2,
				font,
				sf::Vector2f(sp2.getPosition().x - 171, sp2.getPosition().y - 225),
				avg_text2.getSize());
	avg_label2.setVisible(false);


	sf::String fileLabelText_1("file 0:");							// file 0:
	Textbox fileLabel_1(	fileLabelText_1, 
				font, 
				sf::Vector2f(500, 50), 
				fileLabelText_1.getSize());

	sf::String fileLabelText_2("file 1:");							// file 1:
	Textbox fileLabel_2(	fileLabelText_2, 
				font, 
				sf::Vector2f(500, 100), 
				fileLabelText_2.getSize());
	
	sf::String button1_text("train!");							// train button
	Button button1( button1_text,
			font,
			sf::Vector2f(1600, 75),
			button1_text.getSize());
	button1.setBoxColor(sf::Color::White);
	button1.setTextColor(sf::Color::Black);

	sf::String button2_text("Click me!");							// Click me! button
	Button button2( button2_text,
			font,
			sf::Vector2f(1600, 300),
			button2_text.getSize());
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
							button1.changeString(sf::String("loading..."));
							button1.setBoxColor(sf::Color::Yellow);
							window.draw(button1);
							window.display();

							processFiles(directory1.getString(), directory2.getString());

							img1.loadFromFile("./images/AvgCat.png");
							img2.loadFromFile("./images/AvgDog.png");
							img3.loadFromFile("./images/ErrorRate.png");
							img4.loadFromFile("./images/2D.png");

							sp1.setTexture(img1);
							sp2.setTexture(img2);
							sp3.setTexture(img3);
							sp4.setTexture(img4);

							sf::String temp(label1.getString());
							if (temp.find("_") != sf::String::InvalidPos) temp.erase(temp.find("_"));
							avg_text1.insert(avg_text1.getSize() - 1, temp);
							avg_label1.changeString(avg_text1);
							avg_label1.setVisible(true);

							temp = label2.getString();
							if (temp.find("_") != sf::String::InvalidPos) temp.erase(temp.find("_"));
							avg_text2.insert(avg_text2.getSize() - 1, temp);
							avg_label2.changeString(avg_text2);
							avg_label2.setVisible(true);

							button1.changeString(sf::String("train!"));
							
						}/* else if (button2.clickCheck(mouse_pos)) {
							system("cd ./MATLAB && /Applications/MATLAB_R2021a.app/bin/matlab -nodisplay -nosplash -nodesktop -r \"run('visualize2d.m'); exit;\"");
							system("cd ./..");
						}
*/
					}
					break;
				default:
					break;
			}
		}

		//std::cout << "(" << sf::Mouse::getPosition(window).x << ", " << sf::Mouse::getPosition(window).y << ")" << std::endl;

		window.setActive();
		window.clear();

		window.draw(fileLabel_1);
		window.draw(fileLabel_2);
		window.draw(directory1);
		window.draw(directory2);
		window.draw(prompt);
		window.draw(labels);
		window.draw(label1);
		window.draw(label2);
		window.draw(button1);
		window.draw(button2);
		window.draw(sp1);
		window.draw(sp2);
		window.draw(sp3);
		window.draw(sp4);
		window.draw(avg_label1);
		window.draw(avg_label2);

		window.display();

	}

	return 0;}
