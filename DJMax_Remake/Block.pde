public class Block extends GameObject{
  
  private float posX, posY;
  private float speedY;
  private float r, g, b, a;
  private int whichRows;
  private boolean showMiss;
  
  public Block(){
    this.r = 255;
    this.g = 255;
    this.b = 255;
    this.a = 0;
    this.speedY = 5;
    this.posX = -500;
    this.posY = -10;
    this.whichRows = 0;
    this.showMiss = false;
  }
  
  public void update(){
    if(a > 0){
      movement();
      textured();
    }
    if(a != 255) setRow(1);
  }// end update()
  
  public void setRow(int rows){
    this.showMiss = false;
    this.whichRows = rows;
    if(rows >= 0 && rows <= buttons){
      posX = startPosition + 
             blockWidth * rows;
    }
    a = 255;  // active a to active movement
    posY = -10;
  }// end setRow()
  
  private void textured(){
    // change color for each block
    if(buttons == 7){
      if(whichRows == 0){
        this.r = 0;
        this.g = 255;
        this.b = 255;
      }else if(whichRows == 1){
        this.r = 0;
        this.g = 12;
        this.b = 255;
      }else if(whichRows == 2){
        this.r = 117;
        this.g = 234;
        this.b = 216;
      }else if(whichRows == 3){
        this.r = 255;
        this.g = 255;
        this.b = 0;
      }else if(whichRows == 4){
        this.r = 117;
        this.g = 234;
        this.b = 216;
      }else if(whichRows == 5){
        this.r = 0;
        this.g = 12;
        this.b = 255;
      }else if(whichRows == 6){
        this.r = 0;
        this.g = 255;
        this.b = 255;
      }
    }else{
      this.r = 255;
      this.g = 255;
      this.b = 255;
    }
    
    fill(r,g,b,a);
    rect(posX, posY, blockWidth, blockHeight);
  }// end textured()
  
  private void movement(){
    if(a != 0) this.posY += speedY;
    
    if(posY > SCREEN_WIDTH + 50){
      this.a = 0;
      gm.blockPool.backToPool(this);    // return pool for reuse
      tm.changeScore(-15);
    }
    
    if(posY > COLUMN_BUTTON_POSITION + blockHeight && !showMiss){
      tm.activeMiss(whichRows);
      combo = 0;
      gm.setTargetCombo(0);
      showMiss = true;
    }
  }// end movement()
  
  public int getRows(){
    return this.whichRows;
  }// end getRows()
  
  public float getPosY(){
    return this.posY;
  }// end getPosY()
  
}// end Block Class
