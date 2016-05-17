public class Sprite{
  
  public Sprite(){
    
  }
  
  // flip horizontally
  public PImage imageFlip(PImage imageName){
    //"h" flips the entire image across the y-axis
    imageName.loadPixels();
    int tempImage[] = new int[imageName.width*imageName.height];
    for(int i = 0; i < imageName.width*imageName.height; i++){
     tempImage[i] = imageName.pixels[i];
    }
    for(int i = 0; i < imageName.height; i++){
      for(int j = 1; j < imageName.width; j++){
        imageName.pixels[(i+1)*(imageName.width) - j] = tempImage[i*imageName.width + j];
      }
    }

    imageName.updatePixels();
    //image(imageName,xpos,ypos);
    
    return imageName;
  }
  
  // flip vertically
  public PImage flipV(PImage imageName){
    imageName.loadPixels();
    int tempImage[] = new int[imageName.width*imageName.height];
    for(int i = 0; i < imageName.width*imageName.height; i++){
     tempImage[i] = imageName.pixels[i];
    }
 
    for(int i = 0; i < imageName.height; i++){
      for(int j = 1; j < imageName.width; j++){
        imageName.pixels[(imageName.height - 1 - i)*(imageName.width) + j] = tempImage[i*(imageName.width) + j];
      }
    }
    imageName.updatePixels();
    //image(imageName,xPos,yPos);
    
    return imageName;
  }
  
}// end class Sprite
