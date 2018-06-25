import ddf.minim.analysis.*;
import ddf.minim.*;
import ddf.minim.signals.*;
 
Minim minim;
AudioPlayer jingle;
AudioOutput out;
AudioInput in;
FFT fft;
String windowName;
 
void setup()
{
  size(512, 200, P3D);
  //textMode(SCREEN);
 
  minim = new Minim(this);
  in = minim.getLineIn(Minim.MONO, 2048);
  // create an FFT object that has a time-domain buffer 
  // the same size as jingle's sample buffer
  // note that this needs to be a power of two 
  // and that it means the size of the spectrum
  // will be 512. see the online tutorial for more info.
  fft = new FFT(in.bufferSize(), in.sampleRate());
 
}
 
void draw()
{
  background(0);
  stroke(255);
  // perform a forward FFT on the samples in jingle's left buffer
  // note that if jingle were a MONO file, 
  // this would be the same as using jingle.right or jingle.left
  fft.forward(in.mix);
  noStroke();
  fill(255, 0, 0, 128);
  for(int i = 0; i < 250; i++) {
    float b = fft.getBand(i)*25;
    rect(i*2, height - b, 5, b);
    rect(i*2, height - b, 5, b);
  {
    // draw the line for frequency band i, scaling it by 4 so we can see it a bit better
    line(i, height, i, height - fft.getBand(i)*4);
  }
  fill(128);
}
}
void keyPressed()
{
  if ( key == 'm' || key == 'M' )
  {
    if ( in.isMonitoring() )
    {
      in.disableMonitoring();
    }
    else
    {
      in.enableMonitoring();
    }
  }
}
void stop()
{
  // always close Minim audio classes when you finish with them
  out.close();
  minim.stop();
 
  super.stop();
}
