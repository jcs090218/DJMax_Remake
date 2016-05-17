public class BackgroundEffect{
  private float r, g, b, a;
  private float posX, posY;
  private float thisWidth, thisHeight;
  
  private PImage img = null;
  private Sprite sprite = null;
  
  public BackgroundEffect(float posX){
    this.thisWidth = blockWidth * buttons;    // this should be same width
    this.thisHeight = blockHeight;    // and same height
    img = new PImage();
    img = createImage((int)blockWidth * buttons, 400, ARGB);
    r = 255;
    g = 255;
    b = 255;
    a = 127;
    this.posX = posX;
    this.posY = SCREEN_WIDTH - 400;
    this.sprite = new Sprite();
  }// end Constructor
  
  public void update(){
    
    image(img,posX, posY);
    
    colorMode(HSB);      // announc color mode
    img.loadPixels();
    for(int i = 0; i < img.pixels.length; i++){
      float alpha = map(i, 0, img.pixels.length, 200, 0);
      img.pixels[i] = color(hVal, g, b, alpha);
    }
    img.updatePixels();
    
    sprite.flipV(img);
    colorMode(RGB);      // cancel color mode
  }// end update()
  
}// end BackgroundEffect
