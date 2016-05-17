public class TextManager{
  
  // score text
  private float a, r, g, b;
  private String tScore;
  private float scoreTextSize;
  
  // combo text
  private float coA = 255, coR = 255, coG = 255, coB = 255;
  private String comboText = "Combo ";
  
  // miss effect text
  private float missA, missR, missG, missB;
  private float missTextSize;
  private String tMiss;
  private float misX, misY;
  private float moveSpeed;
  private float alphaSpeed;
  
  // increase or decrease score
  private int targetScore = 100;
  private boolean addScore = false;
  
  public TextManager(){
    this.a = 200;  missA = 0;
    this.r = 255;  missR = 255;
    this.g = 255;  missG = 255;
    this.b = 255;  missB = 255;
    this.misX = 0;  this.misY = COLUMN_BUTTON_POSITION;
    score = 100;
    this.tScore = "Score: " + score;
    this.tMiss = "MISS";
    this.moveSpeed = 0.7;
    this.alphaSpeed = 5;
    this.missTextSize = 20;
    this.scoreTextSize = 50;
  }// end Constructor
  
  public void update(){
    onChangesScore();
    runScore();
    runMiss();
    runCombo();
    checkScore();    // set game over
  }// end update()
  
  private void runCombo(){
    this.comboText = "Combo " + combo;
    
    if(combo != 0){
      coA = 255;
      colorMode(HSB);      // announc color mode
      textSize(50);
      fill(hVal, coG, coB, coA);
      text(comboText, 75, 200);
      colorMode(RGB);      // cancel color mode
    }else{
      coA = 0;
    }
  }// end runCombo()
  
  private void checkScore(){
    if(targetScore < 0) targetScore = 0;
  }// end checkScore
  
  private void runScore(){
    this.tScore = "Score: " + score;
    
    colorMode(HSB);      // announc color mode
    textSize(scoreTextSize);
    fill(hVal, g, b, a);
    text(tScore, 400, 200);
    colorMode(RGB);      // cancel color mode
  }// end runScore()
  
  private void runMiss(){
    //colorMode(HSB);      // announc color mode
    textSize(missTextSize);
    fill(missR, missG, missB, missA);
    text(tMiss, misX, misY);
    misY -= moveSpeed;
    missA -= alphaSpeed;
    //colorMode(RGB);      // cancel color mode
  }// end runMiss()
  
  public void activeMiss(int rows){
    misX = startPosition + 
           blockWidth * rows + 
           blockWidth/2 - missTextSize;
    
    misY = COLUMN_BUTTON_POSITION;
    missA = 200;
  }// end activeMiss()
  
  public void changeScore(int changeScore){
    if(changeScore != 0 && !addScore) {
      this.targetScore += changeScore;
      addScore = true;
    }
  }// end changeScore()
  
  private void onChangesScore(){
    if(addScore){
      if(targetScore != score){
        if(targetScore >= score){
          score++;
        }else if(targetScore <= score){
          score--;
        }
      }else addScore = false;
    }// end if(addScore){ }
  }// end onChangesScore()
  
  public void setScore(int newScore){
    if(newScore <= 0) newScore = 0;
    else if(newScore >= 100) newScore = 100;
    score = newScore;
  }// end setScore();
  
}// end class
