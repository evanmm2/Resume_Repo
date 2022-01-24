#include "Image.h"
#include "StickerSheet.h"

int main() {

  //
  // Reminder:
  //   Before exiting main, save your creation to disk as myImage.png
  //
  Image Mine;
  Image o;
  Image l;
  Image b;
  Image lady;
  Image lad;
  Image smack;

  Mine.readFromFile("wood.png");
  o.readFromFile("orange.png");
  l.readFromFile("lime.png");
  b.readFromFile("banana.png");
  lady.readFromFile("DogLady.png");
  lad.readFromFile("Hoodlad.png");
  smack.readFromFile("PeopleSmack.png");

  Mine.scale(.5);
  o.scale(1);
  b.scale(1);
  l.scale(1);
  lady.scale(.25);
  lad.scale(.25);
  smack.scale(.25);

  StickerSheet MySheet(Mine,6);
  MySheet.addSticker(o, 20 ,400);
  MySheet.addSticker(l, 300, 700 );
  MySheet.addSticker(lady,1200,640);
  MySheet.addSticker(lad, 500,500 );
  MySheet.addSticker(smack, 600,700 );
  MySheet.addSticker(b, 1450, 530 );

  Image Output = MySheet.render();

  Output.writeToFile("myImage.png");

  return 0;
}
