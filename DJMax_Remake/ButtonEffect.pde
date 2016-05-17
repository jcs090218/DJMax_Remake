public class ButtonEffect extends GameObject{
  
  private float r, g, b, a;
  private float posX, posY;
  private float thisWidth, thisHeight;
  
  private PImage img = null;
  private Sprite sprite = null;
  
  /**
   *  Constructor
   */
  public ButtonEffect(float posX){
    this.thisWidth = blockWidth;    // this should be same width
    this.thisHeight = blockHeight;    // and same height
    this.img = createImage((int)blockWidth, 600, ARGB);
    this.r = 255;
    this.g = 255;
    this.b = 255;
    this.a = 127;
    this.posX = posX;
    this.posY = SCREEN_WIDTH - 600;
    sprite = new Sprite();
  }// end Constructor
  
  public void update(){
    textured();
  }// end update()
  
  public void textured(){
    
    image(img,posX, posY);
    
    colorMode(HSB);      // announc color mode
    img.loadPixels();
    for(int i = 0; i < img.pixels.length; i++){
      float alpha = map(i, 0, img.pixels.length, 57, 0);
      img.pixels[i] = color(hVal, g, b, alpha);
    }
    img.updatePixels();
    
    sprite.flipV(img);
    colorMode(RGB);      // cancel color mode
  }// end textured()
  
}// end class ButtonEffect 
