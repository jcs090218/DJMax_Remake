public class Button extends GameObject{
  
  private float posX, posY;
  private float bWidth, bHeight;
  
  public Button(float posX){
    this.posY = COLUMN_BUTTON_POSITION;
    this.posX = posX;
    this.bWidth = blockWidth;
    this.bHeight = blockHeight;
  }
  
  public void update(){
    textured();
  }
  
  public void textured(){
    fill(255,255,255,255);
    rect(posX, posY, bWidth, bHeight);
  }
  
  
  
}// end Class
