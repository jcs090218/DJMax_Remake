import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

/**
 *  DJMax_Remake Project
 *  
 *  by Jen-Chieh Shen
 */
 private static final int SCREEN_WIDTH = 800, SCREEN_HEIGHT = 600;
 public static final String MODE = P3D;
 private static final int FRAME_RATE = 60;
 
 // Buttons
 public static final float COLUMN_BUTTON_POSITION = 450;
 private static final int buttons = 2;    // default: 2, 4, 7 which mean mode!!!
 private static int level = buttons - 3;
 private static final int[] totalButton = new int[buttons];
 private static float hVal = 0;
 private static float startPosition;

 // Block
 public static final float blockWidth = 60;
 public static final float blockHeight = 15;
 public static final float COLUMN_BLOCK_POSITION = -50;
 private static float[] button_position = new float[buttons];
 private static final float TIGGER_DISTANCE = 75; // trigger we want to detect wheather hit or not
 
 // key
 private boolean jKey = false;
 private boolean kKey = false;
 private boolean fKey = false;
 private boolean dKey = false;
 private boolean spaceKey = false;
 private boolean sKey = false;
 private boolean lKey = false;
 
 // managers
 public GameManager gm = null;
 //public AudioManager am = null;
 public TextManager tm = null;
 public BlockManager bm = null;
 
 // Game Audio
  public static Minim minim = null;
  public static AudioPlayer mp3player = null;
  public static FFT fft = null;
  public static AudioOutput out = null;
  private static int audioPosX = 400;
  private static int audioPosY = 500;
  private static int audioTimer = 0;
  private static int delayBlockTime = 15;
  
 // Score
 private static int score;
 private static int combo = 0;
 
 
 void setup(){
   smooth();
   size(SCREEN_WIDTH, SCREEN_HEIGHT, MODE);   
   frameRate(FRAME_RATE);
   lights();
   // init managers
   if(gm == null) gm = new GameManager();
   //if(am == null) am = new AudioManager();
   if(tm == null) tm = new TextManager();
   if(bm == null) bm = new BlockManager();
   
   gm.initScene();
   
   minim = new Minim(this);
   mp3player = minim.loadFile("data/hajimete no chu  cossami.mp3",2048);   
   mp3player.play();
   mp3player.setGain(-10);  // setVolume
   fft = new FFT( mp3player.bufferSize(), mp3player.sampleRate() );
 }// end setup()
 
 void draw(){
   hitKey();
   gm.update();
   tm.update();
   audioHandler();
   checkDif();
 }// end draw()
 
 private void checkDif(){
   delayBlockTime = (combo > 25)? 10 : 15;
 }// end checkDif(){ } 
 
 private void audioHandler(){
   fft.forward( mp3player.mix );
   
   colorMode(HSB);      // announc color mode
   stroke(hVal, 255, 255, 255);
   
   for(int j = 0; j < fft.specSize(); j++){
     line( j + audioPosX,
           audioPosY,
           j + audioPosX,
           audioPosY - fft.getBand(j + audioPosX)*8 );
   }
   
   //stroke(255, 255, 255);
   colorMode(RGB);      // cancel color mode
   //-------------------- After Drawing Line -----------------------------------
   
   audioTimer++;
   
   for(int i = 0; i < fft.specSize(); i++){
     //println(fft.getBand(i + audioPosX)*8);
     
     if(buttons == 2){
       if(audioTimer % delayBlockTime == 1){
         if(fft.getBand(i + audioPosX)*8 > 5){
           gm.blockPool.execute(1);
           break;
         }else if(fft.getBand(i + audioPosX)*8 > 0){ 
           gm.blockPool.execute(0);
           break;
         }
       }
     }else if(buttons == 4){
       if(audioTimer % delayBlockTime == 1){
         if(fft.getBand(i + audioPosX)*8 > 30){
           gm.blockPool.execute(2);
           break;
         }else if(fft.getBand(i + audioPosX)*8 > 20){
           gm.blockPool.execute(1);
           break;
         }else if(fft.getBand(i + audioPosX)*8 > 10){
           gm.blockPool.execute(3);
           break;
         }else if(fft.getBand(i + audioPosX)*8 > 0){ 
           gm.blockPool.execute(0);
           break;
         }
       }
     }else if(buttons == 7){
       if(audioTimer % delayBlockTime == 1){
         if(fft.getBand(i + audioPosX)*8 > 30){
           gm.blockPool.execute(1);
           break;
         }else if(fft.getBand(i + audioPosX)*8 > 25){
           gm.blockPool.execute(3);
           break;
         }else if(fft.getBand(i + audioPosX)*8 > 20){
           gm.blockPool.execute(4);
           break;
         }else if(fft.getBand(i + audioPosX)*8 > 15){
           gm.blockPool.execute(5);
           break;
         }else if(fft.getBand(i + audioPosX)*8 > 10){
           gm.blockPool.execute(2);
           break;
         }else if(fft.getBand(i + audioPosX)*8 > 5){
           gm.blockPool.execute(6);
           break;
         }else if(fft.getBand(i + audioPosX)*8 > 0){ 
           gm.blockPool.execute(0);
           break;
         }
       }
     }
     
     
   }// end for(){ }
 }// end audioHandler()
 
 /**
  *  check if the key hit the block or not
  */
 void hitKey(){
   if(buttons == 2){
     if(jKey) gm.checkHitBlock(1);
     else if(fKey) gm.checkHitBlock(0);
   }else if(buttons == 4){
     if(kKey) gm.checkHitBlock(3);
     else if(jKey) gm.checkHitBlock(2);
     else if(fKey) gm.checkHitBlock(1);
     else if(dKey) gm.checkHitBlock(0);
   }else if(buttons == 7){
     if(lKey) gm.checkHitBlock(6);
     else if(kKey) gm.checkHitBlock(5);
     else if(jKey) gm.checkHitBlock(4);
     else if(spaceKey) gm.checkHitBlock(3);
     else if(fKey) gm.checkHitBlock(2);
     else if(dKey) gm.checkHitBlock(1);
     else if(sKey) gm.checkHitBlock(0);
   }
 }// end hitKey()
 
 void keyPressed(){
   if(key == 'f') fKey = true;
   if(key == 'd') dKey = true;
   if(key == 'j') jKey = true;
   if(key == 'k') kKey = true;
   if(key == 's') sKey = true;
   if(key == 'l') lKey = true;
   if(key == ' ') spaceKey = true;
 }
 
 void keyReleased(){
   if(key == 'f') fKey = false;
   if(key == 'd') dKey = false;
   if(key == 'j') jKey = false;
   if(key == 'k') kKey = false;
   if(key == 's') sKey = false;
   if(key == 'l') lKey = false;
   if(key == ' ') spaceKey = false;
 }
 
 
 
 
 
 
 
 
 
 
 
